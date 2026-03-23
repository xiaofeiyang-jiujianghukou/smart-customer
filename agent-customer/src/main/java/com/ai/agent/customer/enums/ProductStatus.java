package com.ai.agent.customer.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ProductStatus {
    OFF_SHELF(0, "下架"),
    ON_SHELF(1, "上架"),
    REVIEWS(2, "审核中");


    @EnumValue // MyBatis-Plus 注解
    //@JsonValue // Jackson 注解，让 API 返回时直接显示数字
    //@JSONField(value = true) // 针对 FastJSON2 的“特权”注解
    private final int code;
    private final String desc;

    // 反序列化用
    @JsonCreator
    public static ProductStatus fromCode(int code) {
        for (ProductStatus e : values()) {
            if (e.getCode() == code) return e;
        }
        throw new IllegalArgumentException("Unknown code: " + code);
    }
}
