package com.ai.agent.base.framework.config.handler; // 注意：请根据你的实际包名调整，通常是 config 或 handler

import com.ai.agent.base.framework.common.ErrorCode;
import com.ai.agent.base.framework.common.Result;
import com.ai.agent.base.framework.common.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import java.util.stream.Collectors;

/**
 * 全局异常处理器
 * 拦截所有 Controller 抛出的异常，返回统一格式 JSON
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 【新增】专门处理业务异常
     * 优先级最高，直接返回业务定义的 code 和 message
     */
    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e) {
        // 既然是预期的业务异常，日志级别设为 WARN 即可，避免刷屏 ERROR
        log.warn("业务异常: [{}] {}", e.getCode(), e.getMessage());
        return Result.fail(e.getCode(), e.getMessage());
    }

    /**
     * 处理业务逻辑中主动抛出的自定义异常 (可选：你可以创建一个 BusinessException 类)
     * 这里先演示处理 IllegalArgumentException 等常见运行时异常
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public Result<Void> handleIllegalArgument(IllegalArgumentException e) {
        log.warn("参数非法: {}", e.getMessage());
        return Result.fail(ErrorCode.BAD_REQUEST.getCode(), e.getMessage());
    }

    /**
     * 处理 JSR-303/JSR-380 参数校验异常 (@Valid, @RequestBody)
     * 例如：@NotNull, @Size 等注解校验失败
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> handleValidationExceptions(MethodArgumentNotValidException e) {
        // 提取所有字段的错误信息，拼接成字符串
        String errorMessage = e.getBindingResult().getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining("; "));

        log.warn("参数校验失败: {}", errorMessage);
        return Result.fail(ErrorCode.BAD_REQUEST.getCode(), errorMessage);
    }

    /**
     * 处理绑定异常 (GET 请求参数校验失败)
     */
    @ExceptionHandler(BindException.class)
    public Result<Void> handleBindException(BindException e) {
        String errorMessage = e.getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining("; "));
        log.warn("参数绑定失败: {}", errorMessage);
        return Result.fail(ErrorCode.BAD_REQUEST.getCode(), errorMessage);
    }

    /**
     * 处理 404 资源未找到 (Spring Boot 3+/4+ 新特性 NoResourceFoundException)
     */
    @ExceptionHandler(NoResourceFoundException.class)
    public Result<Void> handleNotFound(NoResourceFoundException e) {
        return Result.fail(ErrorCode.NOT_FOUND.getCode(), "接口路径不存在: " + e.getResourcePath());
    }

    /**
     * 处理所有其他未知异常 (兜底策略)
     */
    @ExceptionHandler(Exception.class)
    public Result<Void> handleGlobalException(Exception e) {
        log.error("系统发生未知异常", e);
        // 生产环境建议不要直接返回 e.getMessage()，以免泄露堆栈信息
        return Result.fail(ErrorCode.INTERNAL_SERVER_ERROR.getCode(), "系统繁忙，请稍后再试");
    }
}