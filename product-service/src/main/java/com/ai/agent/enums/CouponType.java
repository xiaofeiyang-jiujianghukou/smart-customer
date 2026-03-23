package com.ai.agent.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CouponType {
    GENERAL(0, "全场赠券"),
    MEMBER(1, "会员赠券"),
    PURCHASE(2, "购物赠券"),
    REGISTER(3, "注册赠券");

    @EnumValue // MyBatis-Plus 注解
    //@JsonValue // Jackson 注解，让 API 返回时直接显示数字
    //@JSONField(value = true) // 针对 FastJSON2 的“特权”注解
    private final int code;
    private final String desc;

    // 反序列化用
    @JsonCreator
    public static CouponType fromCode(int code) {
        for (CouponType e : values()) {
            if (e.getCode() == code) return e;
        }
        throw new IllegalArgumentException("Unknown code: " + code);
    }
}
