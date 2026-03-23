package com.ai.agent.manager;

import cn.hutool.core.bean.BeanUtil;
import com.ai.agent.base.framework.common.dto.CodeReqDTO;
import com.ai.agent.base.framework.common.exception.BusinessException;
import com.ai.agent.controller.dto.order.CreateOrderReqDTO;
import com.ai.agent.controller.dto.order.OrderDTO;
import com.ai.agent.controller.dto.order.OrderDetailResDTO;
import com.ai.agent.entity.OrderDO;
import com.ai.agent.enums.PayStatusEnum;
import com.ai.agent.service.OrderCouponService;
import com.ai.agent.service.OrderItemService;
import com.ai.agent.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class OrderManager {

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderCouponService orderCouponService;
    @Autowired
    private OrderItemService orderItemService;

    public void checkCodeValid(String code) {
        OrderDO orderDO = orderService.getByCode(code);
        if (orderDO == null) {
            throw new BusinessException("订单不存在");
        }
    }

    public boolean create(CreateOrderReqDTO input) {
        OrderDO orderDO = BeanUtil.copyProperties(input, OrderDO.class);
        orderDO.setStatus(PayStatusEnum.UNPAID);
        return orderService.save(orderDO);
    }

    public boolean pay(CodeReqDTO input) {
        OrderDO orderDO = orderService.getByCode(input.getCode());
        orderDO.setStatus(PayStatusEnum.UNPAID);
        return orderService.updateById(orderDO);
    }

    public OrderDetailResDTO detail(CodeReqDTO input) {
        OrderDO orderDO = orderService.getByCode(input.getCode());
        return BeanUtil.copyProperties(orderDO, OrderDetailResDTO.class);
    }

    public List<OrderDTO> queryOrders(Long userId) {
        List<OrderDO> orderDOS = orderService.queryOrders(userId);
        return orderDOS.stream().map(m -> BeanUtil.copyProperties(m, OrderDTO.class)).toList();
    }

    public OrderDTO getOrderDetail(String orderSn) {
        OrderDO orderDO = orderService.getOrderDetail(orderSn);
        OrderDTO orderDTO = BeanUtil.copyProperties(orderDO, OrderDTO.class);
        orderDTO.setCouponIds(orderCouponService.getOrderCoupon(orderDO.getId()));
        orderDTO.setProductIds(orderItemService.getOrderProduct(orderDO.getId()));
        return orderDTO;
    }

}
