package com.ai.agent.customer.feign;

import com.ai.agent.customer.base.framework.common.Result;
import com.ai.agent.customer.pojo.dto.CouponDTO;
import com.ai.agent.customer.pojo.dto.OrderDTO;
import com.ai.agent.customer.pojo.dto.ProductDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

//@FeignClient(name = "product-service", url = "http://127.0.0.1:8083")
@FeignClient(name = "product-service", url = "http://product-service:8080")
public interface ProductFeignClient {

    @PostMapping("/agent/product/getProductDetail")
    Result<List<ProductDTO>> getProductDetail(@RequestParam("productIds") List<Long> productIds);

    @PostMapping("/agent/coupon/getCouponDetail")
    Result<List<CouponDTO>> getCouponDetail(@RequestParam("couponIds") List<Long> couponIds);


}
