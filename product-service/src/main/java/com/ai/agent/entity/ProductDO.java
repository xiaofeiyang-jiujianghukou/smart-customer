package com.ai.agent.entity;

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
 * 商品基础表
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-23
 */
@Getter
@Setter
@ToString
@TableName("t_product")
public class ProductDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 商品名称
     */
    private String name;

    /**
     * 主图URL
     */
    private String pic;

    /**
     * 当前售价
     */
    private BigDecimal price;

    /**
     * 库存数量
     */
    private Integer stock;

    /**
     * 类目ID
     */
    private Long categoryId;

    /**
     * 商品详情
     */
    private String detailHtml;

    /**
     * 1:上架, 0:下架
     */
    // 魔法在这里：直接把枚举序列化为对象
    @JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private ProductStatus status;

    private LocalDateTime createTime;
}
