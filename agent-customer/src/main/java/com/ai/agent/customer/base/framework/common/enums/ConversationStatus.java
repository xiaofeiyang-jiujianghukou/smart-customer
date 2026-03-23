package com.ai.agent.customer.base.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 会话状态枚举
 */
@Getter
@AllArgsConstructor
public enum ConversationStatus {
    ACTIVE("活跃"),
    ARCHIVED("归档"),
    ERROR("异常");

    private final String description;
}
