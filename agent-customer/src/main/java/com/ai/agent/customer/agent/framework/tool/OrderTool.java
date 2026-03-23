package com.ai.agent.customer.agent.framework.tool;

import com.ai.agent.customer.agent.framework.annotations.AgentTool;
import com.ai.agent.customer.agent.framework.annotations.ToolMethod;
import com.ai.agent.customer.agent.framework.annotations.ToolParam;
import com.ai.agent.customer.feign.OrderFeignClient;
import com.ai.agent.customer.pojo.dto.OrderDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import tools.jackson.databind.json.JsonMapper;

import java.util.List;

@Slf4j
@AgentTool("OrderTool")
public class OrderTool {

    @Autowired
    @Lazy
    private OrderFeignClient orderFeignClient;

    @Autowired
    private JsonMapper jsonMapper;

    // 调整：查询列表应该针对“用户”，且参数名和描述要统一
    @ToolMethod(name = "queryOrders", description = "获取当前用户的所有订单简列表。当用户想看'我的订单'、'最近买了什么'时调用。")
    public List<OrderDTO> queryOrders(
            @ToolParam(value = "userId", description = "用户的唯一标识ID") Long userId) {
        List<OrderDTO> data = orderFeignClient.queryOrders(userId).getData();
        System.out.printf("OrderTool queryOrders req:%s, res:%s", userId, jsonMapper.writeValueAsString(data));

        // 即使全局关闭了缩进，这段代码也会输出美化后的内容
        String prettyJson = jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(data);
        log.info("OrderTool queryOrders prettyJson：\n{}", prettyJson);
        return data;
    }

    // 调整：获取详情必须针对具体的“订单号”
    @ToolMethod(name = "getOrderDetail", description = "根据具体的订单编号获取订单详细信息（含商品清单、物流、优惠券）。")
    public OrderDTO getOrderDetail(
            @ToolParam(value = "orderSn", description = "具体的订单编号，通常是一串长数字或字母组合") String orderSn) {
        OrderDTO orderDetail = orderFeignClient.getOrderDetail(orderSn).getData();
        System.out.printf("OrderTool getOrderDetail req:%s, res:%s", orderSn, jsonMapper.writeValueAsString(orderDetail));
        return orderDetail;
    }
}