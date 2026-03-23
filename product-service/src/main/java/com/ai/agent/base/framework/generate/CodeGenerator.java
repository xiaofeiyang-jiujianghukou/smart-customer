package com.ai.agent.base.framework.generate;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;

import java.io.File;
import java.util.Collections;

public class CodeGenerator {

    public static void main(String[] args) {
        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig.Builder(
                "jdbc:mysql://127.0.0.1:3306/business-product?useSSL=false&useUnicode=true&characterEncoding=utf8",
                "xiaofeiyang", "xfy@930112")
                .build();

        // 代码生成器
        AutoGenerator mpg = new AutoGenerator(dsc);

        // 全局配置
        GlobalConfig gc = new GlobalConfig.Builder()
                .outputDir(System.getProperty("user.dir") + "/src/main/java")
                .author("xiaofeiyang")
                .disableOpenDir()
                .build();
        mpg.global(gc);

        String basePath = System.getProperty("user.dir");
        // 包配置
        PackageConfig pc = new PackageConfig.Builder()
                .moduleName("agent")
                .parent("com.ai")
                .serviceImpl("service")
                .pathInfo(Collections.singletonMap(
                        OutputFile.xml,
                        basePath + File.separator + "src"
                                + File.separator + "main"
                                + File.separator + "resources"
                                + File.separator + "mapper"
                ))
                .build();
        mpg.packageInfo(pc);

        // 策略配置
        StrategyConfig strategy = new StrategyConfig.Builder()
                .addInclude("t_coupon,t_coupon_history,t_product") // 表名
                .addTablePrefix("t_")
                .entityBuilder().formatFileName("%sDO").enableRemoveIsPrefix()
                .enableLombok().enableFileOverride().idType(IdType.AUTO) // 启用Lombok
                .addTableFills()
                .controllerBuilder().enableRestStyle().enableFileOverride() // RestController风格
                .serviceBuilder().enableFileOverride()
                .disableService()
                .convertServiceImplFileName( (entityName) -> {
                    return entityName + "Service";
                })
                .mapperBuilder().enableFileOverride()
                .build();
        mpg.strategy(strategy);

        // 执行生成
        mpg.execute();
    }
}
