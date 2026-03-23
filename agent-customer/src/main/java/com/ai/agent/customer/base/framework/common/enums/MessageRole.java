package com.ai.agent.customer.base.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 消息角色枚举
 */
@Getter
@AllArgsConstructor
public enum MessageRole {
    USER("USER", "用户"),
    ASSISTANT("ASSISTANT", "助手/AI"),
    SYSTEM("SYSTEM", "系统提示词");

    private final String code;
    private final String description;
}
