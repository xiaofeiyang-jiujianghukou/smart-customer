package com.ai.agent.customer.agent.framework.meta;

import lombok.Data;

import java.util.Map;

@Data
public class AgentStep {

    private String tool;                 // 要调用的Tool
    private Map<String, Object> args;    // 参数
    private String outputKey;            // 结果存储key
}
