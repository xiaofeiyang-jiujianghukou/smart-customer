package com.ai.agent.customer.base.framework.config;

import feign.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FeignConfig {
    @Bean
    public Logger.Level feignLoggerLevel() {
        // FULL 会打印请求头、请求体、响应头、响应体，调试必备！
        return Logger.Level.FULL;
    }
}
