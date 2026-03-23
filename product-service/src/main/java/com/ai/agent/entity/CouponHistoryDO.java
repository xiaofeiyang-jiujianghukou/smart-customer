package com.ai.agent.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 用户领券记录表
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-23
 */
@Getter
@Setter
@ToString
@TableName("t_coupon_history")
public class CouponHistoryDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 关联 t_coupon.id
     */
    private Long couponId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 使用状态：0->未使用；1->已使用；2->已过期
     */
    private Byte useStatus;

    /**
     * 关联使用的订单ID
     */
    private Long orderId;

    /**
     * 使用时间
     */
    private LocalDateTime useTime;

    private LocalDateTime createTime;
}
