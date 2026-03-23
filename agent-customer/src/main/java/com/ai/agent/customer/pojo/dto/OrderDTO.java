package com.ai.agent.customer.pojo.dto;

import com.ai.agent.customer.enums.PayStatusEnum;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@SuperBuilder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderDTO {
    private Long orderId;
    private String orderSn;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 商品总原价
     */
    private BigDecimal totalAmount;

    /**
     * 所有优惠券抵扣总额
     */
    private BigDecimal couponTotalAmount;

    /**
     * 最终实付金额
     */
    private BigDecimal payAmount;

    /**
     * 0:待支付...
     */
    // 魔法在这里：直接把枚举序列化为对象
    //@JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private PayStatusEnum status;

    private LocalDateTime createTime;

    private List<Long> productIds;
    private List<Long> couponIds;
}
