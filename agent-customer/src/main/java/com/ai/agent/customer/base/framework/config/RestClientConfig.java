package com.ai.agent.customer.base.framework.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJacksonJsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import tools.jackson.databind.json.JsonMapper;

@Configuration
public class RestClientConfig {

    @Autowired
    private JsonMapper jsonMapper;

    @Bean
    public RestTemplate restTemplate() {
        // 生产环境建议设置超时，防止 Agent 调用 LLM 时无限挂起
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectionRequestTimeout(5000); // 5秒连接超时
        factory.setReadTimeout(30000);    // 30秒读取超时（LLM 生成较慢）

        return new RestTemplate(factory);
    }

    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory factory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(factory);

        // 根据你提供的源码，无参构造函数已经设置了：
        // 1. ReaderFeatures: SupportAutoType
        // 2. WriterFeatures: WriteClassName
        // 这正是 Redis 跨对象序列化所需要的。
        //GenericFastJsonRedisSerializer serializer = new GenericFastJsonRedisSerializer();

        // 1. 使用 Jackson 3 对应的 Reader 和 Writer 接口
        // 这些接口是专门为 tools.jackson (Jackson 3) 设计的

        // 2. 使用新一代的序列化器 (GenericJacksonJsonRedisSerializer)
        // 它是 GenericJackson2JsonRedisSerializer 的直接继承者
        GenericJacksonJsonRedisSerializer serializer = new GenericJacksonJsonRedisSerializer(
                jsonMapper
        );

        // 如果你需要额外添加信任的包名（防止序列化漏洞），可以使用 String[] 构造函数
        // String[] acceptNames = {"com.ai.agent.**", "java.util.**"};
        // GenericFastJsonRedisSerializer serializer = new GenericFastJsonRedisSerializer(acceptNames);

        template.setKeySerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());

        template.setValueSerializer(serializer);
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }
}
