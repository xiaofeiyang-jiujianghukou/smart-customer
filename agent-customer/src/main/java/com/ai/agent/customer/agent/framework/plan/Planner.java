package com.ai.agent.customer.agent.framework.plan;

import com.ai.agent.customer.agent.framework.annotations.Prompt;
import com.ai.agent.customer.agent.framework.client.LlmClient;
import com.ai.agent.customer.agent.framework.meta.AgentPlan;
import com.ai.agent.customer.agent.framework.meta.ToolMeta;
import com.alibaba.fastjson2.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Planner {

    @Autowired
    private LlmClient llm;

    /*@Value("${llm.planPrompt}")
    private String llmPlanPrompt;*/

    @Prompt("plan-prompt.st")
    private String llmPlanPrompt;

    public AgentPlan plan(String message, List<ToolMeta> tools) {

        String toolDesc = tools.stream()
                .map(t -> t.getName() + ":" + t.getDescription())
                .reduce("", (a, b) -> a + "\n" + b);

        String prompt = String.format(llmPlanPrompt, message, toolDesc);

        String response = llm.chat(prompt);

        return JSON.parseObject(response, AgentPlan.class);
    }
}
