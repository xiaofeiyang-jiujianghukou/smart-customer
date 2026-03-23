package com.ai.agent.service;

import com.ai.agent.entity.OrderItemDO;
import com.ai.agent.mapper.OrderItemMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 订单商品详情(多对多中间表) 服务实现类
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Service
public class OrderItemService extends ServiceImpl<OrderItemMapper, OrderItemDO> {

    public List<Long> getOrderProduct(Long orderId) {
        return this.lambdaQuery().eq(OrderItemDO::getOrderId, orderId).list()
                .stream().map(OrderItemDO::getProductId).toList();
    }
}
