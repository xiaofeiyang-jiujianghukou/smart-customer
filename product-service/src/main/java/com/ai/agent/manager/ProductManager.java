package com.ai.agent.manager;

import cn.hutool.core.bean.BeanUtil;
import com.ai.agent.controller.dto.order.ProductDTO;
import com.ai.agent.entity.ProductDO;
import com.ai.agent.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class ProductManager {

    @Autowired
    private ProductService productService;

    public List<ProductDTO> getProductDetail(List<Long> productIds) {
        List<ProductDO> productDOS = productService.listByIds(productIds);
        return productDOS.stream()
                .map(m -> BeanUtil.copyProperties(m, ProductDTO.class))
                .toList();
    }
}
