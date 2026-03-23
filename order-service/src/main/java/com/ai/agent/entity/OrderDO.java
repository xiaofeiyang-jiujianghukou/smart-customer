package com.ai.agent.entity;

import com.ai.agent.enums.PayStatusEnum;
import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 订单主表
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Getter
@Setter
@ToString
@TableName("t_order")
public class OrderDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 订单编号
     */
    @TableField(fill = FieldFill.INSERT)
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
    @JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private PayStatusEnum status;

    private LocalDateTime createTime;
}
