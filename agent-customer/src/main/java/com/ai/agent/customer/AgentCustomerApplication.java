package com.ai.agent.customer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.jdbc.autoconfigure.DataSourceAutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@EnableFeignClients(basePackages = "com.ai.agent.customer.feign") // 确保指向你的 Feign 接口包
public class AgentCustomerApplication {

	public static void main(String[] args) {
		SpringApplication.run(AgentCustomerApplication.class, args);
	}

}
