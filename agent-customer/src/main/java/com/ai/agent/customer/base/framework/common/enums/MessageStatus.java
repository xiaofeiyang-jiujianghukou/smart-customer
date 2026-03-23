package com.ai.agent.customer.base.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 消息状态枚举
 */
@Getter
@AllArgsConstructor
public enum MessageStatus {
    SENDING("发送中"),
    SENT("已发送"),
    STREAMING("流式生成中"),
    COMPLETED("已完成"),
    FAILED("失败");

    private final String description;
}
