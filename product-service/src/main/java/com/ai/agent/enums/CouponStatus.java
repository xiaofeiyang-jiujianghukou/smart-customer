package com.ai.agent.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CouponStatus {
    EXPIRED(0, "已失效"),
    ACTIVE(1, "可用"),
    USED(2, "已使用"),
    CLOSED(3, "已撤回/手动禁用");

    @EnumValue // MyBatis-Plus 注解
    //@JsonValue // Jackson 注解，让 API 返回时直接显示数字
    //@JSONField(value = true) // 针对 FastJSON2 的“特权”注解
    private final int code;
    private final String desc;

    // 反序列化用
    @JsonCreator
    public static CouponStatus fromCode(int code) {
        for (CouponStatus e : values()) {
            if (e.getCode() == code) return e;
        }
        throw new IllegalArgumentException("Unknown code: " + code);
    }
}
