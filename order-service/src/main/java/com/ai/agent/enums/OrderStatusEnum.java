package com.ai.agent.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrderStatusEnum {
    PENDING_PAYMENT(100, "待付款"),
    PENDING_DELIVERY(200, "待发货"),
    SHIPPED(300, "已发货"),
    COMPLETED(400, "已完成"),
    CANCELLED(500, "已关闭"),
    REFUNDING(600, "退款中");

    private final Integer code;
    private final String desc;
}
