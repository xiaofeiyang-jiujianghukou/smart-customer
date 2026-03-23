package com.ai.agent.customer.agent.framework.scan;

import com.ai.agent.customer.agent.framework.annotations.AgentTool;
import com.ai.agent.customer.agent.framework.annotations.ToolMethod;
import com.ai.agent.customer.agent.framework.meta.ToolMeta;
import com.ai.agent.customer.agent.framework.registry.ToolRegistry;
import org.springframework.aop.support.AopUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.lang.reflect.Method;
import java.util.Map;

@Component
public class ToolScanner implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private ToolRegistry toolRegistry;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        // 获取所有标注了 @AgentTool 的 Bean 名
        String[] beanNames = applicationContext.getBeanNamesForType(Object.class);

        for (String beanName : beanNames) {
            // 获取原始类（处理 AOP 代理）
            Class<?> beanType = applicationContext.getType(beanName);
            if (beanType == null) continue;

            // 检查类上是否有 @AgentTool 注解
            AgentTool agentToolAnn = AnnotatedElementUtils.findMergedAnnotation(beanType, AgentTool.class);
            if (agentToolAnn == null) continue;

            // 【核心逻辑】：如果注解没写名字，就用 Spring 的 beanName
            String toolGroupName = StringUtils.hasText(agentToolAnn.value())
                    ? agentToolAnn.value()
                    : beanName;

            // 扫描方法
            Method[] methods = beanType.getDeclaredMethods();
            for (Method method : methods) {
                ToolMethod toolMethodAnn = AnnotatedElementUtils.findMergedAnnotation(method, ToolMethod.class);
                if (toolMethodAnn != null) {

                    // 如果方法注解也没写名字，可以用方法名
                    String toolName = StringUtils.hasText(toolMethodAnn.name())
                            ? toolMethodAnn.name()
                            : method.getName();

                    Object bean = applicationContext.getBean(beanName);
                    ToolMeta meta = new ToolMeta(
                            toolName,
                            toolMethodAnn.description(),
                            bean,
                            method
                    );

                    // 你也可以在 ToolMeta 里增加 toolGroupName 分组信息
                    toolRegistry.register(meta);
                }
            }
        }
    }
}
