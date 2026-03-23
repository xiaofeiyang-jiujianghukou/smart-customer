package com.ai.agent.service;

import com.ai.agent.entity.OrderCouponDO;
import com.ai.agent.mapper.OrderCouponMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 订单优惠券关联表(多对多中间表) 服务实现类
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Service
public class OrderCouponService extends ServiceImpl<OrderCouponMapper, OrderCouponDO> {

    public List<Long> getOrderCoupon(Long orderId) {
        return this.lambdaQuery().eq(OrderCouponDO::getOrderId, orderId).list()
                .stream().map(OrderCouponDO::getCouponId).toList();
    }
}
