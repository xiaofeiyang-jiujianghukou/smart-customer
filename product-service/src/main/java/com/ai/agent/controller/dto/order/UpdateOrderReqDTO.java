package com.ai.agent.controller.dto.order;

import lombok.*;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class UpdateOrderReqDTO extends CreateOrderReqDTO {

    /**
     * 订单编码
     */
    private String code;
}
