package com.ai.agent.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CouponStatusEnum {
    UNUSED(0, "未使用"),
    USED(1, "已使用"),
    EXPIRED(2, "已过期"),
    LOCKED(3, "锁定中"); // 用户下单但未支付时，优惠券应处于锁定状态

    private final Integer code;
    private final String desc;
}
