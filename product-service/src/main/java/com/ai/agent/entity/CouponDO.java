package com.ai.agent.entity;

import com.ai.agent.enums.CouponStatus;
import com.ai.agent.enums.CouponType;
import com.ai.agent.enums.ProductStatus;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 优惠券规则表
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-23
 */
@Getter
@Setter
@ToString
@TableName("t_coupon")
public class CouponDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
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
