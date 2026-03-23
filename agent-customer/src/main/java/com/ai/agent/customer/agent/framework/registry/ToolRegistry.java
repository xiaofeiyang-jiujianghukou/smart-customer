package com.ai.agent.customer.agent.framework.registry;

import com.ai.agent.customer.agent.framework.meta.ToolMeta;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ToolRegistry {

    private Map<String, ToolMeta> toolMap = new HashMap<>();

    public void register(ToolMeta meta) {
        toolMap.put(meta.getName(), meta);
    }

    public ToolMeta get(String name) {
        return toolMap.get(name);
    }

    public List<ToolMeta> list() {
        return new ArrayList<>(toolMap.values());
    }
}
