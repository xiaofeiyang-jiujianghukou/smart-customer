package com.ai.agent.manager;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class OrderManager {

//    @Autowired
//    private OrderService orderService;
//
//    public void checkCodeValid(String code) {
//        OrderDO orderDO = orderService.getByCode(code);
//        if (orderDO == null) {
//            throw new BusinessException("订单不存在");
//        }
//    }
//
//    public boolean create(CreateOrderReqDTO input) {
//        OrderDO orderDO = BeanUtil.copyProperties(input, OrderDO.class);
//        orderDO.setStatus(Byte.valueOf(PayStatusEnum.UNPAID.getCode().toString()));
//        return orderService.save(orderDO);
//    }
//
//    public boolean pay(CodeReqDTO input) {
//        OrderDO orderDO = orderService.getByCode(input.getCode());
//        orderDO.setStatus(Byte.valueOf(PayStatusEnum.UNPAID.getCode().toString()));
//        return orderService.updateById(orderDO);
//    }
//
//    public OrderDetailResDTO detail(CodeReqDTO input) {
//        OrderDO orderDO = orderService.getByCode(input.getCode());
//        return BeanUtil.copyProperties(orderDO, OrderDetailResDTO.class);
//    }
//
//    public List<OrderDTO> queryOrders(Long userId) {
//        List<OrderDO> orderDOS = orderService.queryOrders(userId);
//        return orderDOS.stream().map(m -> BeanUtil.copyProperties(m, OrderDTO.class)).toList();
//    }
//
//    public OrderDTO getOrderDetail(String orderSn) {
//        OrderDO orderDO = orderService.getOrderDetail(orderSn);
//        return BeanUtil.copyProperties(orderDO, OrderDTO.class);
//    }
}
