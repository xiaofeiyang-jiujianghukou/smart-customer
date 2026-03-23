package com.ai.agent.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 订单优惠券关联表(多对多中间表)
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Getter
@Setter
@ToString
@TableName("t_order_coupon")
public class OrderCouponDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 关联 t_order.id
     */
    private Long orderId;

    /**
     * 优惠券ID
     */
    private Long couponId;

    /**
     * 优惠券类型: FULL_REDUCTION, RED_PACKET, etc.
     */
    private String couponType;

    /**
     * 该张券抵扣的具体金额
     */
    private BigDecimal discountAmount;
}
