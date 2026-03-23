package com.ai.agent.customer.agent.framework.dto;

import com.ai.agent.customer.agent.framework.meta.LlmFunction;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
public class LlmRequest {
    private String model;
    private List<Map<String, String>> messages;
    private List<ToolWrapper> tools;

    /**
     * 建议显式设置为 "auto"，告诉模型自动选择是否调用工具
     */
    private String tool_choice = "auto";

    /**
     * 控制生成的随机性。做 Agent 工具调用建议设置低一点（如 0.3），
     * 防止模型在提取参数时产生幻觉（乱编订单号）。
     */
    private Double temperature = 0.3;

    @Data
    @AllArgsConstructor // 方便快速构造
    @NoArgsConstructor
    public static class ToolWrapper {
        private String type = "function";
        private LlmFunction function;
    }
}
