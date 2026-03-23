package com.ai.agent.customer.agent.framework.executor;

import com.ai.agent.customer.agent.framework.annotations.ToolParam;
import com.ai.agent.customer.agent.framework.meta.ToolMeta;
import com.ai.agent.customer.agent.framework.registry.ToolRegistry;
import com.alibaba.fastjson2.util.TypeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Map;

@Component
public class ToolExecutor {

    @Autowired
    private ToolRegistry toolRegistry;

    public Object execute(String name, Map<String, Object> params) {

        ToolMeta meta = toolRegistry.get(name);
        if (meta == null) {
            throw new RuntimeException("Tool not found: " + name);
        }

        try {
            Method method = meta.getMethod();
            Object bean = meta.getBean();

            // 参数自动匹配（简化版）
            Object[] args = buildArgs(method, params);

            return method.invoke(bean, args);

        } catch (Exception e) {
            throw new RuntimeException("Tool execute error", e);
        }
    }

    private Object[] buildArgs(Method method, Map<String, Object> params) {

        Parameter[] parameters = method.getParameters();
        Object[] args = new Object[parameters.length];

        for (int i = 0; i < parameters.length; i++) {
            Parameter p = parameters[i];
            ToolParam annotation = p.getAnnotation(ToolParam.class);

            String paramName = annotation != null ? annotation.value() : p.getName();
            Object rawValue = params.get(paramName);

            // 核心修复：根据方法参数的实际类型进行强制转换
            args[i] = TypeUtils.cast(rawValue, p.getType());
        }

        /*for (int i = 0; i < parameters.length; i++) {
            ToolParam annotation = parameters[i].getAnnotation(ToolParam.class);

            String paramName = annotation != null
                    ? annotation.value()
                    : parameters[i].getName();

            args[i] = params.get(paramName);
        }*/
        /*for (int i = 0; i < parameters.length; i++) {
            args[i] = params.get(parameters[i].getName());
        }*/

        return args;
    }
}
