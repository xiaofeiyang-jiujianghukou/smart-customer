package com.ai.agent.customer.agent.framework.meta;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class AgentMemory {

    private Map<String, Object> data = new HashMap<>();

    public void put(String key, Object value) {
        data.put(key, value);
    }

    public Object get(String key) {
        return data.get(key);
    }
}
