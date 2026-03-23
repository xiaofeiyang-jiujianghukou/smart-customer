package com.ai.agent.customer.agent.framework.processor;

import com.ai.agent.customer.agent.framework.annotations.Prompt;
import com.ai.agent.customer.agent.framework.loader.PromptLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;

@Component
public class PromptInjectionProcessor implements BeanPostProcessor {
    @Autowired
    private PromptLoader promptLoader;

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) {
        ReflectionUtils.doWithFields(bean.getClass(), field -> {
            Prompt promptAnno = field.getAnnotation(Prompt.class);
            if (promptAnno != null) {
                // 1. 获取注解里的文件名（如 "plan-prompt.st"）
                String fileName = promptAnno.value();

                // 2. 从 Loader 的缓存中精准提取
                String content = promptLoader.getRawTemplate(fileName);

                if (content == null) {
                    throw new RuntimeException(String.format(
                            "Bean [%s] 注入失败：在 resources/prompts 下未找到文件 [%s]",
                            beanName, fileName));
                }

                // 3. 反射注入
                field.setAccessible(true);
                field.set(bean, content);
            }
        });
        return bean;
    }
}
