package com.ai.agent.customer.feign;

import com.ai.agent.customer.base.framework.common.Result;
import com.ai.agent.customer.pojo.dto.OrderDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.awt.color.ICC_Profile;
import java.util.List;

//@FeignClient(name = "order-service", url = "http://127.0.0.1:8082")
@FeignClient(name = "order-service", url = "http://order-service:8080")
public interface OrderFeignClient {

    @PostMapping("/orders/queryOrders")
    Result<List<OrderDTO>> queryOrders(@RequestParam("userId") Long userId);

    @PostMapping("/orders/getOrderDetail")
    Result<OrderDTO> getOrderDetail(@RequestParam("orderSn") String orderSn);
}
