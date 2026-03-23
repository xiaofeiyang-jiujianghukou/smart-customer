package com.ai.agent.base.framework.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

@Component
public class OrderSnUtil {

    @Autowired
    private StringRedisTemplate redisTemplate;

    // 时间格式化：精确到秒 (14位)
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
    // 日期格式化：用于 Redis Key 分隔 (8位)
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd");

    /**
     * 生成订单号：yyyyMMddHHmmss + 6位流水号
     * 示例：20260322095015000001
     */
    public String generateOrderSn() {
        LocalDateTime now = LocalDateTime.now();

        // 1. 生成时间前缀 (14位)
        String timePrefix = now.format(TIME_FORMATTER);

        // 2. 构造 Redis Key (按天隔离)
        String dateKey = now.format(DATE_FORMATTER);
        String key = "order:sn:" + dateKey;

        // 3. 利用 Redis 原子自增获取流水号
        Long increment = redisTemplate.opsForValue().increment(key);

        // 4. 初次生成时设置 24小时过期，节省 Redis 内存
        if (increment != null && increment == 1) {
            redisTemplate.expire(key, 24, TimeUnit.HOURS);
        }

        // 5. 格式化流水号：不足6位左补0
        // %06d 支持到 999,999，若日订单量超百万，可改为 %07d
        String sequence = String.format("%06d", increment);

        return timePrefix + sequence;
    }
}
