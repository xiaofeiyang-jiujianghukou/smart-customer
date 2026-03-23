package com.ai.agent.customer.agent.framework.meta;

import lombok.Data;

import java.util.Map;

@Data
public class LlmFunction {

    private String name;
    private String description;
    private Map<String, Object> parameters;
}