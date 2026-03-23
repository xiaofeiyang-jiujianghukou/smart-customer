package com.ai.agent.base.framework.handler;

import com.ai.agent.base.framework.util.OrderSnUtil;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/*@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Autowired
    private OrderSnUtil orderSnUtil;

    @Override
    public void insertFill(MetaObject metaObject) {
        // 当检测到实体类有 orderSn 属性且值为空时，自动填充
        Object orderSn = getFieldValByName("orderSn", metaObject);
        if (orderSn == null) {
            setFieldValByName("orderSn", orderSnUtil.generateOrderSn(), metaObject);
        }
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        // 更新时通常不需要动订单号
    }
}*/
