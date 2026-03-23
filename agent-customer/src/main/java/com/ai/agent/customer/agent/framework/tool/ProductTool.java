package com.ai.agent.customer.agent.framework.tool;

import com.ai.agent.customer.agent.framework.annotations.AgentTool;
import com.ai.agent.customer.agent.framework.annotations.ToolMethod;
import com.ai.agent.customer.agent.framework.annotations.ToolParam;
import com.ai.agent.customer.feign.OrderFeignClient;
import com.ai.agent.customer.feign.ProductFeignClient;
import com.ai.agent.customer.pojo.dto.CouponDTO;
import com.ai.agent.customer.pojo.dto.OrderDTO;
import com.ai.agent.customer.pojo.dto.ProductDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import tools.jackson.databind.json.JsonMapper;

import java.util.List;

@Slf4j
@AgentTool("ProductTool")
public class ProductTool {

    @Autowired
    @Lazy
    private ProductFeignClient productFeignClient;

    @Autowired
    private JsonMapper jsonMapper;

    @ToolMethod(name = "getProductDetail", description = "根据具体的商品ID列表获取优惠券详细信息（含商品名称、价格、库存）。")
    public List<ProductDTO> getProductDetail(
            @ToolParam(value = "productIds", description = "商品的唯一标识ID列表") List<Long> productIds) {
        List<ProductDTO> data = productFeignClient.getProductDetail(productIds).getData();
        System.out.printf("OrderTool queryOrders req:%s, res:%s", productIds, jsonMapper.writeValueAsString(data));

        // 即使全局关闭了缩进，这段代码也会输出美化后的内容
        String prettyJson = jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(data);
        System.out.printf("ProductTool getProductDetail prettyJson：\n%s", prettyJson);
        return data;
    }

    @ToolMethod(name = "getCouponDetail", description = "根据具体的优惠券ID列表获取优惠券详细信息（含优惠类型、使用门槛、有效时间）。")
    public List<CouponDTO> getCouponDetail(
            @ToolParam(value = "couponIds", description = "优惠券的唯一标识ID列表") List<Long> couponIds) {
        List<CouponDTO> data = productFeignClient.getCouponDetail(couponIds).getData();
        System.out.printf("ProductTool getCouponDetail req:%s, res:%s", couponIds, jsonMapper.writeValueAsString(data));
        return data;
    }
}