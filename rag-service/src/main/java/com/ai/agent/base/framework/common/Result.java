package com.ai.agent.base.framework.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 统一 API 响应结果封装
 *
 * @param <T> 数据 payload 的类型
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 状态码：200 表示成功，其他表示失败
     */
    private Integer code;

    /**
     * 响应消息
     */
    private String message;

    /**
     * 数据载体
     */
    private T data;

    /**
     * 成功响应 (无数据)
     */
    public static <T> Result<T> success() {
        return new Result<>(200, "操作成功", null);
    }

    /**
     * 成功响应 (带数据)
     */
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "操作成功", data);
    }

    /**
     * 成功响应 (自定义消息 + 数据)
     */
    public static <T> Result<T> success(String message, T data) {
        return new Result<>(200, message, data);
    }

    /**
     * 失败响应 (使用错误码枚举)
     */
    public static <T> Result<T> fail(ErrorCode errorCode) {
        return new Result<>(errorCode.getCode(), errorCode.getMessage(), null);
    }

    /**
     * 失败响应 (自定义消息)
     */
    public static <T> Result<T> fail(String message) {
        return new Result<>(500, message, null);
    }

    /**
     * 失败响应 (自定义状态码 + 消息)
     */
    public static <T> Result<T> fail(Integer code, String message) {
        return new Result<>(code, message, null);
    }
}