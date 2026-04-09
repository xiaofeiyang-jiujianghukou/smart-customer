package com.ai.agent.manager;

import com.ai.agent.splitter.FontSizeSplitter;
import com.rometools.utils.Lists;
import org.jspecify.annotations.NonNull;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Service;

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PdfManager {

    private final VectorStore vectorStore;
    private final ResourceLoader resourceLoader;

    public PdfManager(
            VectorStore vectorStore,
            ResourceLoader resourceLoader) {
        this.vectorStore = vectorStore;
        this.resourceLoader = resourceLoader;
    }

    public @NonNull String importPdfs(String folder) {
        try {
            ResourcePatternResolver resolver = (ResourcePatternResolver) resourceLoader;
            Resource[] resources = resolver.getResources(folder + "*.pdf");

            List<Document> allDocuments = new ArrayList<>();

            for (Resource resource : resources) {
                System.out.println("\n📄 正在读取: " + resource.getFilename());

                // 1. 语义分块 - 按语义相似度动态合并
                FontSizeSplitter splitter = new FontSizeSplitter();
                List<Document> finalChunks = splitter.split(resource.getFile());
                System.out.println("   语义分块: " + finalChunks.size() + " 个块");

                // 2. Token 分块 - 确保不超过 token 限制
                /*List<Document> finalChunks = tokenTextSplitter.apply(chunks);
                System.out.println("   Token分块: " + finalChunks.size() + " 个块");*/

                // 4. 清理并存储
                for (Document doc : finalChunks) {
                    String content = doc.getText();
                    if (content != null && !content.trim().isEmpty()) {
                        Document cleanedDoc = cleanDocument(doc);
                        cleanedDoc.getMetadata().put("source", resource.getFilename());
                        allDocuments.add(cleanedDoc);
                    }
                }
                allDocuments.addAll(finalChunks);
            }

            if (allDocuments.isEmpty()) {
                return "⚠️ 没有读取到任何有效文档内容";
            }

            // 分批存入向量库
            int batchSize = 5;
            int totalBatches = (allDocuments.size() + batchSize - 1) / batchSize;
            System.out.println("\n📊 开始存入向量库，共 " + allDocuments.size() + " 个文档，分 " + totalBatches + " 批");

            int successCount = 0;
            for (int i = 0; i < allDocuments.size(); i += batchSize) {
                int end = Math.min(i + batchSize, allDocuments.size());
                List<Document> batch = allDocuments.subList(i, end);
                int batchNum = (i / batchSize) + 1;

                try {
                    vectorStore.add(batch);
                    successCount += batch.size();
                    if (batchNum % 10 == 0) {
                        System.out.println("   ✅ 批次 " + batchNum + "/" + totalBatches + " 成功");
                    }
                } catch (Exception e) {
                    System.err.println("   ❌ 批次 " + batchNum + " 失败: " + e.getMessage());
                    for (int j = 0; j < batch.size(); j++) {
                        try {
                            vectorStore.add(Lists.create(batch.get(j)));
                            System.out.println("   ✅ 批次 " + batchNum + "/" + j + " 成功");
                        } catch (Exception ex) {
                            System.err.println("   ❌ 批次 " + batchNum + "/" + j + " 失败: " + e.getMessage() + " 内容：" + batch.get(j).getText());
                        }
                    }
                }
            }

            return String.format("✅ 成功导入 %d 个文档片段！", successCount);

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ 导入失败: " + e.getMessage();
        }
    }

    /**
     * 清理 Document 的所有内容
     */
    private Document cleanDocument(Document doc) {
        String cleanedText = cleanText(doc.getText());

        Map<String, Object> cleanedMetadata = new HashMap<>();
        for (Map.Entry<String, Object> entry : doc.getMetadata().entrySet()) {
            Object value = entry.getValue();
            if (value instanceof String) {
                cleanedMetadata.put(entry.getKey(), cleanText((String) value));
            } else {
                cleanedMetadata.put(entry.getKey(), value);
            }
        }

        return Document.builder()
                .id(doc.getId())
                .text(cleanedText)
                .metadata(cleanedMetadata)
                .build();
    }

    /**
     * 强力清洗：移除 PostgreSQL 不允许的非法字符
     */
    private String cleanText(String text) {
        if (text == null) return "";

        // 1. 【核心步骤】Unicode 标准化 (NFKC)
        // 原理：它会自动把 "ﬀ" (连字) 拆解为 "ff"
        // 它会自动把全角字符转为半角，把各种花哨的变体转为标准字符
        // 这一步通常就能把 "Oﬀer" 变回 "Offer"
        String normalized = Normalizer.normalize(text, Normalizer.Form.NFKC);

        // 2. 移除 PostgreSQL 严禁的 Null 字节 (0x00)
        // 注意：经过 NFKC 处理后，原本导致乱码的非法字符通常会变成合法字符
        // 这里再补一刀，确保绝对安全
        String noNullBytes = normalized.replace("\u0000", "");

        // 3. (可选) 移除其他不可见的控制符，但保留换行符(\n)和回车(\r)
        // \p{Cntrl} 代表控制字符，&&[^\r\n] 代表排除换行和回车
        return noNullBytes.replaceAll("[\\p{Cntrl}&&[^\r\n]]", "");
    }

}
