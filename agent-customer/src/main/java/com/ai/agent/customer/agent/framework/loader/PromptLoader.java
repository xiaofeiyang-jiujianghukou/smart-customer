package com.ai.agent.customer.agent.framework.loader;

import jakarta.annotation.PostConstruct;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Component;
import org.springframework.util.StreamUtils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class PromptLoader {

    // 缓存：Key 为文件名（不含路径），Value 为文件内容
    private final Map<String, String> promptCache = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() throws IOException {
        // 1. 创建资源路径解析器
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();

        // 2. 扫描 classpath 下 prompts 目录及其子目录下所有以 .st 或 .txt 结尾的文件
        Resource[] resources = resolver.getResources("classpath*:prompts/**/*.*");

        for (Resource resource : resources) {
            String fileName = resource.getFilename();
            if (fileName != null) {
                // 3. 读取内容并存入缓存
                String content = StreamUtils.copyToString(resource.getInputStream(), StandardCharsets.UTF_8);
                promptCache.put(fileName, content);
                System.out.println("[PromptLoader] 已加载模板: " + fileName);
            }
        }
    }

    public String get(String fileName, Object... args) {
        String template = promptCache.get(fileName);
        if (template == null) {
            throw new RuntimeException("未找到 Prompt 模板: " + fileName);
        }
        return args.length > 0 ? String.format(template, args) : template;
    }

    // 新增：供 Processor 直接获取原始模板内容
    public String getRawTemplate(String fileName) {
        return promptCache.get(fileName);
    }
}
