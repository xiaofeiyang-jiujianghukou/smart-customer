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
public enum PayStatusEnum {

    UNPAID(0, "待支付"),
    PAYING(1, "支付中"),
    SUCCESS(2, "支付成功"),
    FAILED(3, "支付失败"),
    CLOSED(4, "已关闭");

    @EnumValue // MyBatis-Plus 注解
    //@JsonValue // Jackson 注解，让 API 返回时直接显示数字
    //@JSONField(value = true) // 针对 FastJSON2 的“特权”注解
    private final Integer code;
    private final String desc;

    @JsonCreator
    public static PayStatusEnum fromCode(int code) {
        for (PayStatusEnum e : values()) {
            if (e.getCode() == code) return e;
        }
        throw new IllegalArgumentException("Unknown code: " + code);
    }
}
