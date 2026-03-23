package com.ai.agent.manager;

import cn.hutool.core.bean.BeanUtil;
import com.ai.agent.controller.dto.order.CouponDTO;
import com.ai.agent.entity.CouponDO;
import com.ai.agent.service.CouponService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class CouponManager {

    @Autowired
    private CouponService couponService;

    public List<CouponDTO> getCouponDetail(List<Long> couponIds) {
        List<CouponDO> couponDOS = couponService.listByIds(couponIds);
        return couponDOS.stream()
                .map(m -> BeanUtil.copyProperties(m, CouponDTO.class))
                .toList();
    }
}
