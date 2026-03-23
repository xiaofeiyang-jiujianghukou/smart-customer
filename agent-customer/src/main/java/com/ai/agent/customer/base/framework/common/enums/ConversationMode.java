package com.ai.agent.customer.base.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 会话模式枚举
 * MVP 阶段仅使用 DIRECT_LLM
 */
@Getter
@AllArgsConstructor
public enum ConversationMode {
    DIRECT_LLM("直接对话"),
    AGENT_PLAN("Agent 规划"),
    KB_RAG("知识库检索");

    private final String description;
}
