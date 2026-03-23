package com.ai.agent.customer.agent.framework.executor;

import com.ai.agent.customer.agent.framework.meta.AgentMemory;
import com.ai.agent.customer.agent.framework.meta.AgentPlan;
import com.ai.agent.customer.agent.framework.meta.AgentStep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class AgentExecutor {

    @Autowired
    private ToolExecutor toolExecutor;

    public Map<String, Object> execute(AgentPlan plan, Long sessionUserId) {

        AgentMemory memory = new AgentMemory();
        // 将当前 session 用户放入 memory，方便 SpEL 引用
        memory.put("sessionUserId", sessionUserId);

        for (AgentStep step : plan.getSteps()) {
            // 1. 合并参数：LLM 提取的参数优先级高于 Session 默认参数
            Map<String, Object> rawArgs = step.getArgs();

            // 2. 解析 SpEL (此时可以解析 ${sessionUserId})
            Map<String, Object> resolved = resolveArgs(rawArgs, memory, sessionUserId);

            // 3. 兜底逻辑：如果全链路都没提到 userId，才用当前登录人
            if (!resolved.containsKey("userId") && !resolved.containsKey("targetUserId")) {
                resolved.put("userId", sessionUserId);
            }

            // 3. 执行
            Object result = toolExecutor.execute(step.getTool(), resolved);
            memory.put(step.getOutputKey(), result);
        }

        return memory.getData();
    }

    private Map<String, Object> resolveArgs(
            Map<String, Object> args,
            AgentMemory memory,
            Long userId
    ) {
        Map<String, Object> resolved = new HashMap<>();

        for (Map.Entry<String, Object> entry : args.entrySet()) {

            Object value = entry.getValue();

            if (value instanceof String str && str.startsWith("${")) {

                // ${orders[0].orderSn}
                Object real = parseExpression(str, memory, userId);

                resolved.put(entry.getKey(), real);
            } else {
                resolved.put(entry.getKey(), value);
            }
        }

        return resolved;
    }

    private Object parseExpression(String expr, AgentMemory memory, Long userId) {
        // 把 ${orders[0].orderSn} -> #orders[0].orderSn
        String spelExpr = expr.replace("${", "#").replace("}", "");

        // 构建动态上下文
        StandardEvaluationContext context = new StandardEvaluationContext();
        for (Map.Entry<String, Object> entry : memory.getData().entrySet()) {
            context.setVariable(entry.getKey(), entry.getValue());
        }
        context.setVariable("userId", userId);

        ExpressionParser parser = new SpelExpressionParser();
        return parser.parseExpression(spelExpr).getValue(context);
    }
}
