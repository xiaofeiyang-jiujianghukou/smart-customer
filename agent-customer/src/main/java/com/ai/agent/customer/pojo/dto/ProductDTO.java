package com.ai.agent.customer.pojo.dto;

import com.ai.agent.customer.enums.ProductStatus;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;

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
    private ProductStatus status;
}
