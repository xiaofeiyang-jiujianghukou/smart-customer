package com.ai.agent.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CouponTypeEnum {
    CASH(1, "代金券", "直接减免固定金额"),
    DISCOUNT(2, "折扣券", "按订单金额百分比打折"),
    FULL_REDUCTION(3, "满减券", "订单满一定金额后减免"),
    SHIPPING_FREE(4, "运费券", "减免物流费用");

    private final Integer code;
    private final String name;
    private final String remark;
}
