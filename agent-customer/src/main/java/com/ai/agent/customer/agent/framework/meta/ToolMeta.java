package com.ai.agent.customer.agent.framework.meta;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.lang.reflect.Method;

@Data
@AllArgsConstructor
public class ToolMeta {

    private String name;
    private String description;
    private Object bean;
    private Method method;
}
