package com.ai.agent.customer.base.framework.common.enums;


import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 消息类型枚举
 */
@Getter
@AllArgsConstructor
public enum MessageType {
    USER_INPUT("用户输入"),
    AI_RESPONSE("AI 响应"),
    SYSTEM_ERROR("系统错误"),
    SYSTEM_NOTICE("系统通知");

    private final String description;
}
