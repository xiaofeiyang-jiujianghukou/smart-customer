package com.ai.agent.customer.agent.framework.annotations;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component // 让 Spring 能够扫描到这个 Bean
public @interface AgentTool {
    /**
     * 工具组名称，如果不填则默认为 Bean 的名称
     */
    String value() default "";
}
