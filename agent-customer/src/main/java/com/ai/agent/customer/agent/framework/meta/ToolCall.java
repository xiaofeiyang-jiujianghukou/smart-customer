package com.ai.agent.customer.agent.framework.meta;

import lombok.Data;

import java.util.Map;

@Data
public class ToolCall {
    private String name;
    private Map<String, Object> args;
}
