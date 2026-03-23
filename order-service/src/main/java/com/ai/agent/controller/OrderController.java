package com.ai.agent.controller;

import com.ai.agent.base.framework.common.Result;
import com.ai.agent.base.framework.common.dto.BasePageResDTO;
import com.ai.agent.base.framework.common.dto.CodeReqDTO;
import com.ai.agent.controller.dto.order.*;
import com.ai.agent.manager.OrderManager;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaofeiyang
 * @since 2025-07-10
 */
@RestController
@RequestMapping("/orders")
@Tag(name = "订单管理", description = "订单的增删改查接口")
public class OrderController {

    @Autowired
    private OrderManager orderManager;

    @PostMapping("create")
    @Operation(summary = "创建订单")
    public Result<Boolean> create(@RequestBody CreateOrderReqDTO input) {
        return Result.success(orderManager.create(input));
    }

    @PostMapping("detail")
    @Operation(summary = "订单详情")
    public Result<OrderDetailResDTO> detail(@Validated @RequestBody CodeReqDTO input) {
        orderManager.checkCodeValid(input.getCode());
        return Result.success(orderManager.detail(input));
    }

    @PostMapping("pay")
    @Operation(summary = "更新订单")
    public Result<Boolean> pay(@Validated @RequestBody CodeReqDTO input) {
        orderManager.checkCodeValid(input.getCode());
        return Result.success(orderManager.pay(input));
    }

    @PostMapping("queryOrders")
    @Operation(summary = "查询订单")
    public Result<List<OrderDTO>> queryOrders(@RequestParam("userId") Long userId) {
        return Result.success(orderManager.queryOrders(userId));
    }

    @PostMapping("getOrderDetail")
    @Operation(summary = "查询订单")
    public Result<OrderDTO> getOrderDetail(@RequestParam("orderSn") String orderSn) {
        return Result.success(orderManager.getOrderDetail(orderSn));
    }
}
