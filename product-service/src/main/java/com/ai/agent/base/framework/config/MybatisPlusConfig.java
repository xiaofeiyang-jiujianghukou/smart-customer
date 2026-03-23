package com.ai.agent.base.framework.config;

import com.ai.agent.base.framework.util.OrderSnUtil;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Configuration
@MapperScan("com.ai.agent.mapper")
public class MybatisPlusConfig {

    @Autowired
    private OrderSnUtil orderSnUtil;

    /**
     * 配置 MyBatisPlus 分页插件
     * 针对 PostgreSQL 优化
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 添加分页拦截器，指定数据库类型为 POSTGRE_SQL
        PaginationInnerInterceptor paginationInterceptor = new PaginationInnerInterceptor(DbType.POSTGRE_SQL);

        // 设置最大单页限制数量，默认 500 条，-1 不受限制
        paginationInterceptor.setMaxLimit(500L);
        // 溢出总页数后是否进行处理(默认 false)
        paginationInterceptor.setOverflow(false);

        interceptor.addInnerInterceptor(paginationInterceptor);

        // 如果有其他拦截器 (如乐观锁 OptimisticLockerInnerInterceptor)，可在此添加
        // interceptor.addInnerInterceptor(new OptimisticLockerInnerInterceptor());

        return interceptor;
    }

    /**
     * 配置 TypeHandler 扫描包
     */
    /*@Bean
    public ConfigurationCustomizer mybatisConfigurationCustomizer() {
        return configuration -> {
            // 注册 TypeHandler
            configuration.getTypeHandlerRegistry().register(List.class, PgVectorTypeHandler.class);
        };
    }*/

    /**
     * 事务管理器 (配合全局事务处理)
     */
    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    /**
     * 自动填充处理器 (可选)
     * 用于自动填充 create_time, update_time 等字段
     */
    @Bean
    public MetaObjectHandler metaObjectHandler() {
        return new MetaObjectHandler() {
            @Override
            public void insertFill(org.apache.ibatis.reflection.MetaObject metaObject) {
                // 示例：自动填充 createdAt
                // this.strictInsertFill(metaObject, "createdAt", java.time.Instant::now, java.time.Instant.class);

                // 当检测到实体类有 orderSn 属性且值为空时，自动填充
                Object orderSn = getFieldValByName("orderSn", metaObject);
                if (orderSn == null) {
                    setFieldValByName("orderSn", orderSnUtil.generateOrderSn(), metaObject);
                }
            }

            @Override
            public void updateFill(org.apache.ibatis.reflection.MetaObject metaObject) {
                // 示例：自动填充 updatedAt
                // this.strictUpdateFill(metaObject, "updatedAt", java.time.Instant::now, java.time.Instant.class);
            }
        };
    }
}