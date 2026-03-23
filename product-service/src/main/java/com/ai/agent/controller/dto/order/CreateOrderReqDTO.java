package com.ai.agent.controller.dto.order;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaofeiyang
 * @since 2025-07-10
 */
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class CreateOrderReqDTO {

    /**
     * 学员编号
     */
    private String studentCode;

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
     * 支付渠道
     */
    private String paymentChannel;

    /**
     * 订单类型
     */
    private String orderType;

}
