package com.ai.agent.customer.agent.framework.client;

import com.ai.agent.customer.agent.framework.annotations.Prompt;
import com.ai.agent.customer.agent.framework.annotations.ToolParam;
import com.ai.agent.customer.agent.framework.dto.LlmRequest;
import com.ai.agent.customer.agent.framework.dto.LlmResponse;
import com.ai.agent.customer.agent.framework.meta.LlmFunction;
import com.ai.agent.customer.agent.framework.meta.ToolCall;
import com.ai.agent.customer.agent.framework.meta.ToolMeta;
import com.ai.agent.customer.agent.framework.registry.ToolRegistry;
import com.alibaba.fastjson2.JSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.*;

@Component
@Slf4j
public class LlmClient {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private ToolRegistry toolRegistry;

    @Value("${llm.model.name}")
    private String llmModelName;

    @Value("${llm.model.apiKey}")
    private String llmModelKey;

    @Value("${llm.model.baseUrl}")
    private String llmModelBaseUrl;

    /*@Value("${llm.sysPrompt}")
    private String llmSysPrompt;*/

    @Prompt("sys-prompt.st")
    private String llmSysPrompt;

    @Prompt("plan-prompt.st")
    private String llmPlanPrompt; // 启动时自动注入文件内容

    public ToolCall decide(String message) {

        // 1. 构造 functions
        //List<LlmFunction> functions = buildFunctions(toolRegistry.list());
        List<LlmRequest.ToolWrapper> tools = buildTools(toolRegistry.list());

        // 2. 构造 request
        Map<String, String> userMsg = new HashMap<>();
        userMsg.put("role", "user");
        userMsg.put("content", message);

        LlmRequest req = new LlmRequest();
        req.setModel(llmModelName); // 或通义
        req.setMessages(List.of(userMsg));
        req.setTools(tools);
        //req.setFunctions(functions);

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(llmModelKey);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<LlmRequest> entity = new HttpEntity<>(req, headers);


        System.out.printf("Generated Function req: %s\n", JSON.toJSONString(entity));
        // 3. 调用
        ResponseEntity<LlmResponse> response =
                restTemplate.postForEntity(llmModelBaseUrl, entity, LlmResponse.class);

        System.out.printf("Generated Function res: %s\n", JSON.toJSONString(response));

        // 4. 解析
        LlmResponse.FunctionCall fc =
                null;
        if (response.getBody() != null) {
            fc = response.getBody()
                    .getChoices().getFirst()
                    .getMessage()
                    .getToolCalls().getFirst()
                    .getFunction();
        }

        if (fc == null) {
            return null;
        }

        ToolCall call = new ToolCall();
        call.setName(fc.getName());

        // arguments 是 JSON 字符串
        Map<String, Object> args =
                JSON.parseObject(fc.getArguments(), Map.class);

        call.setArgs(args);

        return call;
    }

    public List<LlmRequest.ToolWrapper> buildTools(List<ToolMeta> tools) {
        List<LlmRequest.ToolWrapper> wrapperList = new ArrayList<>();

        for (ToolMeta tool : tools) {
            Method method = tool.getMethod();
            Map<String, Object> properties = new LinkedHashMap<>(); // 使用 LinkedHashMap 保证顺序
            List<String> requiredFields = new ArrayList<>();

            for (Parameter p : method.getParameters()) {
                // 1. 优先获取注解名，否则获取反射名
                String name = p.getName();
                ToolParam paramAnno = p.getAnnotation(ToolParam.class);

                String description = "";
                if (paramAnno != null) {
                    name = paramAnno.value();
                    description = paramAnno.description(); // 假设你的注解里有这个字段
                }

                // 2. 构建属性详情
                Map<String, String> field = new HashMap<>();
                // 动态映射类型（简单处理：非数值即字符串）
                field.put("type", p.getType().equals(Long.class) || p.getType().equals(Integer.class) ? "integer" : "string");
                if (StringUtils.hasText(description)) {
                    field.put("description", description);
                }

                properties.put(name, field);

                // 3. 默认将所有参数视为必需（或者根据注解判断）
                requiredFields.add(name);
            }

            // 4. 构建标准的 JSON Schema 根对象
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("type", "object");
            parameters.put("properties", properties);
            parameters.put("required", requiredFields); // 哪怕是空数组也传进去

            LlmFunction function = new LlmFunction();
            function.setName(tool.getName());
            function.setDescription(tool.getDescription());
            function.setParameters(parameters);

            // 使用实体类包装
            LlmRequest.ToolWrapper wrapper = new LlmRequest.ToolWrapper();
            wrapper.setFunction(function);
            // type 默认为 "function"，无需重复设置

            wrapperList.add(wrapper);
        }
        return wrapperList;
    }

    // Function 定义（给 AI 看）
    /*public List<LlmFunction> buildFunctions(List<ToolMeta> tools) {

        List<LlmFunction> list = new ArrayList<>();

        for (ToolMeta tool : tools) {

            Method method = tool.getMethod();

            Map<String, Object> properties = new HashMap<>();

            for (Parameter p : method.getParameters()) {

                String name = p.getName();

                ToolParam paramAnno = p.getAnnotation(ToolParam.class);
                if (paramAnno != null) {
                    name = paramAnno.value();
                }

                Map<String, String> field = new HashMap<>();
                field.put("type", "string"); // 先简单处理

                properties.put(name, field);
            }

            Map<String, Object> parameters = new HashMap<>();
            parameters.put("type", "object");
            parameters.put("properties", properties);

            LlmFunction function = new LlmFunction();
            function.setName(tool.getName());
            function.setDescription(tool.getDescription());
            function.setParameters(parameters);

            list.add(function);
        }

        return list;
    }*/

    public List<LlmFunction> buildFunctions(List<ToolMeta> tools) {
        List<LlmFunction> list = new ArrayList<>();

        for (ToolMeta tool : tools) {
            Method method = tool.getMethod();
            Map<String, Object> properties = new LinkedHashMap<>(); // 使用 LinkedHashMap 保证顺序
            List<String> requiredFields = new ArrayList<>();

            for (Parameter p : method.getParameters()) {
                // 1. 优先获取注解名，否则获取反射名
                String name = p.getName();
                ToolParam paramAnno = p.getAnnotation(ToolParam.class);

                String description = "";
                if (paramAnno != null) {
                    name = paramAnno.value();
                    description = paramAnno.description(); // 假设你的注解里有这个字段
                }

                // 2. 构建属性详情
                Map<String, String> field = new HashMap<>();
                // 动态映射类型（简单处理：非数值即字符串）
                field.put("type", p.getType().equals(Long.class) || p.getType().equals(Integer.class) ? "integer" : "string");
                if (StringUtils.hasText(description)) {
                    field.put("description", description);
                }

                properties.put(name, field);

                // 3. 默认将所有参数视为必需（或者根据注解判断）
                requiredFields.add(name);
            }

            // 4. 构建标准的 JSON Schema 根对象
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("type", "object");
            parameters.put("properties", properties);
            parameters.put("required", requiredFields); // 哪怕是空数组也传进去

            LlmFunction function = new LlmFunction();
            function.setName(tool.getName());
            function.setDescription(tool.getDescription());
            function.setParameters(parameters);

            list.add(function);
        }
        System.out.printf("Generated Function Schema: %s\n", JSON.toJSONString(list));
        return list;
    }

    public String generate(String userMessage, ToolCall toolCall, Object result) {

        String prompt = String.format(llmSysPrompt,
                userMessage,
                toolCall.getName(),
                JSON.toJSONString(result)
        );

        return chat(prompt);
    }

    public String chat(String content) {

        Map<String, String> msg = Map.of(
                "role", "user",
                "content", content
        );

        LlmRequest req = new LlmRequest();
        req.setModel(llmModelName);
        req.setMessages(List.of(msg));

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(llmModelKey);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<LlmRequest> entity = new HttpEntity<>(req, headers);

        ResponseEntity<LlmResponse> resp =
                restTemplate.postForEntity(llmModelBaseUrl, entity, LlmResponse.class);

        if (resp.getBody() != null) {
            return resp.getBody()
                    .getChoices().getFirst()
                    .getMessage()
                    .getContent();
        }
        return "智能助手无法识别该请求";
    }

    public String generateFinal(String message, Map<String, Object> result) {

        String prompt = String.format("""
                用户问题：
                %s
                
                执行结果：
                %s
                
                请生成最终用户回答：
                """, message, JSON.toJSONString(result));

        return chat(prompt);
    }
}
