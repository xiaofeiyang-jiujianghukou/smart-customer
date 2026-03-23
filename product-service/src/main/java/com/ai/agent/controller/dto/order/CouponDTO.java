package com.ai.agent.controller.dto.order;

import com.ai.agent.enums.CouponStatus;
import com.ai.agent.enums.CouponType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@SuperBuilder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CouponDTO {
    private Long id;

    /**
     * 券标题
     */
    private String title;

    /**
     * 券类型: 0->全场赠券; 1->会员赠券; 2->购物赠券; 3->注册赠券
     */
    // 魔法在这里：直接把枚举序列化为对象
    @JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private CouponType type;

    /**
     * 使用门槛(满多少可用)
     */
    private BigDecimal minPoint;

    /**
     * 抵扣金额
     */
    private BigDecimal amount;

    /**
     * 有效期开始时间
     */
    private LocalDateTime startTime;

    /**
     * 有效期结束时间
     */
    private LocalDateTime endTime;

    /**
     * 发行数量
     */
    private Integer publishCount;

    /**
     * 已使用数量
     */
    private Integer useCount;

    /**
     * 1:可用, 0:失效
     */
    // 魔法在这里：直接把枚举序列化为对象
    @JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private CouponStatus status;
}
