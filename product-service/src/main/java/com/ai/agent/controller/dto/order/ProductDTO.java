package com.ai.agent.controller.dto.order;

import com.ai.agent.enums.ProductStatus;
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
public class ProductDTO {
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
     * 1:上架, 0:下架
     */
    // 魔法在这里：直接把枚举序列化为对象
    @JsonFormat(shape = JsonFormat.Shape.OBJECT)
    private ProductStatus status;
}
