package com.ai.agent.customer.base.framework.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 全局错误码枚举
 */
@Getter
@AllArgsConstructor
public enum ErrorCode {

    // --- 通用错误 (2xx - 5xx) ---
    SUCCESS(200, "操作成功"),

    // 客户端错误 (4xx)
    BAD_REQUEST(400, "请求参数错误"),
    UNAUTHORIZED(401, "未授权，请先登录"),
    FORBIDDEN(403, "拒绝访问，权限不足"),
    NOT_FOUND(404, "资源不存在"),
    METHOD_NOT_ALLOWED(405, "请求方法不支持"),

    // 服务端错误 (5xx)
    INTERNAL_SERVER_ERROR(500, "服务器内部错误"),
    SERVICE_UNAVAILABLE(503, "服务暂时不可用"),

    // --- 业务特定错误 (自定义范围 1000+) ---
    USER_NOT_FOUND(1001, "用户不存在"),
    USER_PASSWORD_ERROR(1002, "用户名或密码错误"),
    TOKEN_EXPIRED(1003, "Token 已过期"),
    TOKEN_INVALID(1004, "Token 无效"),

    FILE_UPLOAD_FAILED(2001, "文件上传失败"),
    FILE_NOT_FOUND(2002, "文件不存在"),

    AI_SERVICE_ERROR(3001, "AI 服务响应异常"),
    AI_STREAM_ERROR(3002, "AI 流式传输中断");

    private final Integer code;
    private final String message;
}