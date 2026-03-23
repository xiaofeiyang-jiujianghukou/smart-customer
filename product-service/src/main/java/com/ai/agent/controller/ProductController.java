package com.ai.agent.controller;

import com.ai.agent.base.framework.common.Result;
import com.ai.agent.controller.dto.order.ProductDTO;
import com.ai.agent.manager.ProductManager;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 商品基础表 前端控制器
 * </p>
 *
 * @author xiaofeiyang
 * @since 2026-03-23
 */
@RestController
@RequestMapping("/agent/product")
@Tag(name = "商品管理", description = "商品的增删改查接口")
public class ProductController {

    @Autowired
    private ProductManager productManager;

    @PostMapping("getProductDetail")
    @Operation(summary = "查询商品详情")
    public Result<List<ProductDTO>> getProductDetail(@RequestParam("productIds") List<Long> productIds) {
        return Result.success(productManager.getProductDetail(productIds));
    }
}
