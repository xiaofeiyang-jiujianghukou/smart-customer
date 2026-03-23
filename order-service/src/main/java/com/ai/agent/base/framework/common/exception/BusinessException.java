package com.ai.agent.base.framework.common.exception;

import com.ai.agent.base.framework.common.ErrorCode;
import lombok.Getter;

/**
 * 自定义业务异常
 * 用于在业务逻辑层主动抛出，携带特定的错误码和消息
 */
@Getter
public class BusinessException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    /**
     * 错误码
     */
    private final Integer code;

    /**
     * 错误消息
     */
    private final String message;

    /**
     * 构造方法：直接使用 ErrorCode 枚举
     * 示例：throw new BusinessException(ErrorCode.USER_NOT_FOUND);
     */
    public BusinessException(ErrorCode errorCode) {
        super(errorCode.getMessage()); // 设置异常默认消息
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }

    /**
     * 构造方法：使用 ErrorCode + 自定义详细消息
     * 示例：throw new BusinessException(ErrorCode.USER_NOT_FOUND, "用户 ID 9527 不存在");
     * 此时返回给前端的 message 将是自定义的详细消息，但 code 保持枚举定义的值
     */
    public BusinessException(ErrorCode errorCode, String detailMessage) {
        super(detailMessage);
        this.code = errorCode.getCode();
        this.message = detailMessage;
    }

    /**
     * 构造方法：完全自定义 code 和 message
     * 示例：throw new BusinessException(400, "参数格式不对");
     */
    public BusinessException(Integer code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    /**
     * 构造方法：带 Cause (保留原始异常堆栈，方便调试)
     */
    public BusinessException(ErrorCode errorCode, Throwable cause) {
        super(errorCode.getMessage(), cause);
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }

    /**
     * 构造方法：完全自定义 code 和 message
     * 示例：throw new BusinessException(400, "参数格式不对");
     */
    public BusinessException(String message) {
        super(message);
        this.code = ErrorCode.INTERNAL_SERVER_ERROR.getCode();
        this.message = message;
    }
}