package com.ai.agent.customer.service;

import com.ai.agent.customer.agent.framework.client.LlmClient;
import com.ai.agent.customer.agent.framework.executor.AgentExecutor;
import com.ai.agent.customer.agent.framework.meta.AgentPlan;
import com.ai.agent.customer.agent.framework.plan.Planner;
import com.ai.agent.customer.agent.framework.registry.ToolRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AiPlanService {

    @Autowired
    private Planner planner;

    @Autowired
    private AgentExecutor executor;

    @Autowired
    private LlmClient llm;

    @Autowired
    private ToolRegistry toolRegistry;

    public String chat(Long userId, String message) {

        // 1️⃣ 生成执行计划
        AgentPlan plan = planner.plan(message, toolRegistry.list());

        // 2️⃣ 执行计划
        Map<String, Object> result = executor.execute(plan, userId);

        // 3️⃣ 最终总结
        return llm.generateFinal(message, result);
    }
}
