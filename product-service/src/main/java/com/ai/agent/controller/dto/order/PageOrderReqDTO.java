package com.ai.agent.controller.dto.order;

import com.ai.agent.base.framework.common.dto.BasePageReqDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class PageOrderReqDTO extends BasePageReqDTO {

    /**
     * 订单编号
     */
    private String code;

    /**
     * 学员编号
     */
    private String studentCode;

    /**
     * 支付渠道
     */
    private String paymentChannel;

    /**
     * 订单类型
     */
    private String orderType;

    /**
     * 状态 0无效 1有效
     */
    private Integer status;

    /**
     * 创建时间
     */
    private LocalDate createStarTime;

    /**
     * 创建时间
     */
    private LocalDate createEndTime;

    /**
     * 创建人
     */
    private String createBy;

}
