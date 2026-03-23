package com.ai.agent.controller;

import com.ai.agent.base.framework.common.Result;
import com.ai.agent.controller.dto.order.CouponDTO;
import com.ai.agent.controller.dto.order.CreateOrderReqDTO;
import com.ai.agent.controller.dto.order.ProductDTO;
import com.ai.agent.manager.CouponManager;
import com.ai.agent.service.CouponService;
import com.ai.agent.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 优惠券规则表 前端控制器
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-23
 */
@RestController
@RequestMapping("/agent/coupon")
@Tag(name = "优惠券管理", description = "订单的增删改查接口")
public class CouponController {

    @Autowired
    private CouponManager couponManager;

    @PostMapping("getCouponDetail")
    @Operation(summary = "查询优惠券详情")
    public Result<List<CouponDTO>> getCouponDetail(@RequestParam("couponIds") List<Long> couponIds) {
        return Result.success(couponManager.getCouponDetail(couponIds));
    }
}
