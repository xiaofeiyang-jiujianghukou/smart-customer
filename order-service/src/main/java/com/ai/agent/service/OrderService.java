package com.ai.agent.service;

import com.ai.agent.entity.OrderDO;
import com.ai.agent.mapper.OrderMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.constraints.NotBlank;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 订单主表 服务实现类
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-22
 */
@Service
public class OrderService extends ServiceImpl<OrderMapper, OrderDO> {

    public OrderDO getByCode(@NotBlank(message = "编号不能为空") String code) {
        return this.lambdaQuery()
                .eq(OrderDO::getOrderSn, code)
                .one();
    }

    public List<OrderDO> queryOrders(Long userId) {
        return this.lambdaQuery().eq(OrderDO::getUserId, userId)
                .orderByDesc(OrderDO::getCreateTime)
                .last("LIMIT 10")
                .list();
    }

    public OrderDO getOrderDetail(String orderSn) {
        return this.lambdaQuery().eq(OrderDO::getOrderSn, orderSn).one();
    }
}
