package com.ai.agent.customer.service;

import com.ai.agent.customer.agent.framework.client.LlmClient;
import com.ai.agent.customer.agent.framework.executor.ToolExecutor;
import com.ai.agent.customer.agent.framework.meta.ToolCall;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class AiService {

    @Autowired
    private ToolExecutor toolExecutor;

    @Autowired
    private LlmClient llm;

    public String chat(Long userId, String message) {

        // 1. AI决定调用哪个Tool
        ToolCall toolCall = llm.decide(message);

        if (toolCall == null) {
            return "AI未选择任何工具";
        }

        // 2. 注入上下文参数（非常关键）
        if (toolCall.getArgs() == null) {
            toolCall.setArgs(new HashMap<>());
        }
        toolCall.getArgs().put("userId", userId);

        // 3. 执行 Tool
        Object result = toolExecutor.execute(
                toolCall.getName(),
                toolCall.getArgs()
        );

        /*// 4. 返回（先简单）
        return "调用工具：" + toolCall.getName()
                + "\n结果：" + JSON.toJSONString(result);*/
        return llm.generate(message, toolCall, result);
    }
}
