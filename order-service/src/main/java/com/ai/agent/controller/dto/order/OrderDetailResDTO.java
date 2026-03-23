package com.ai.agent.controller.dto.order;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class OrderDetailResDTO {

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
    private Byte status;

    @JsonFormat(locale="zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDateTime createTime;

}
