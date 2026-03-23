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
 * 订单商品详情(多对多中间表)
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Getter
@Setter
@ToString
@TableName("t_order_item")
public class OrderItemDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 关联 t_order.id
     */
    private Long orderId;

    /**
     * 商品ID
     */
    private Long productId;

    /**
     * 下单时商品名快照
     */
    private String productName;

    /**
     * 下单时单价
     */
    private BigDecimal price;

    /**
     * 购买数量
     */
    private Integer quantity;
}
