package com.ai.agent.service;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.ai.document.Document;
import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class HybridSearchService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private EmbeddingModel embeddingModel;
    @Autowired
    private RerankService rerankerService;

    /**
     * 混合检索
     * @param query 用户查询文本
     * @param topK 返回结果数量
     * @return 检索结果列表
     */
    public List<Document> search(String query, int topK) {
        // 1. 生成查询向量
        float[] queryVector = embeddingModel.embed(query);
        String vectorString = formatVector(queryVector);

        // 2. 关键词策略
        String keywords = query;

        // 3. 执行 RRF 混合检索 SQL
        // 注意：这里 SELECT 了 rrf_score, v_rank, k_rank
        String rrfSql = """
            
                WITH vector_search AS (
                        SELECT
                            id,
                            ROW_NUMBER() OVER (ORDER BY embedding <=> ?::vector) AS v_rank
                        FROM vector_store
                        LIMIT 50
                    ),
                    keyword_search AS (
                        SELECT
                            id,
                            -- 核心修改：计算排名时，优先看元数据，其次看内容
                            ROW_NUMBER() OVER (
                                ORDER BY
                                    CASE
                                        -- 🔥 第一优先级：元数据（chapter 或 section_title）匹配到了
                                        WHEN metadata::text ILIKE CONCAT('%', ?, '%') THEN 1
                                        -- 🔥 第二优先级：只有内容匹配到了
                                        ELSE 2
                                    END ASC,
                                    -- 同优先级内，再按相关度排序
                                    ts_rank(content_tsv, to_tsquery('simple', ?)) DESC
                            ) AS k_rank
                        FROM vector_store
                        WHERE
                            -- 搜索范围：内容 OR 元数据
                            content_tsv @@ to_tsquery('simple', ?)
                            OR metadata::text ILIKE CONCAT('%', ?, '%') -- 简单的包含匹配，也可以用 tsvector
                        LIMIT 50
                    )
                    -- 第一部分：元数据优先
                    SELECT
                        id,
                        1.0 AS rrf_score,
                        NULL AS v_rank, -- 显式补全列，防止 UNION ALL 报错或错位
                        1.0 AS k_rank
                    FROM vector_store
                    WHERE metadata::text ILIKE CONCAT('%', ?, '%')
                    
                    UNION ALL
                    
                    -- 第二部分：普通 RRF
                    SELECT
                        COALESCE(v.id, k.id) AS id,
                        (1.0 / (60 + COALESCE(v.v_rank, 0)) + 1.0 / (60 + COALESCE(k.k_rank, 0))) AS rrf_score,
                        v.v_rank,
                        k.k_rank
                    FROM vector_search v
                    FULL OUTER JOIN keyword_search k ON v.id = k.id
                    WHERE COALESCE(v.id, k.id) NOT IN (
                        SELECT id FROM vector_store WHERE metadata::text ILIKE CONCAT('%', ?, '%')
                    )
            """;

        // 4. 获取候选结果（包含 ID 和 分数）
        // 这里不再用 queryForList，而是用 query 配合 RowMapper 直接封装成临时对象或 Map
        // 为了代码清晰，我们定义一个简单的内部类或者直接用 Map 来承接 SQL 结果
        List<Map<String, Object>> candidateScores = jdbcTemplate.queryForList(rrfSql, vectorString, keywords, keywords, keywords, keywords, keywords, keywords);

        if (candidateScores.isEmpty()) {
            return new ArrayList<>();
        }

        // 提取 ID 列表用于后续查询内容
        List<String> candidateIds = candidateScores.stream()
                .map(m -> m.get("id").toString())
                .collect(Collectors.toList());

        // 5. 根据 ID 批量查询完整 Document 内容
        String fetchSql = "SELECT id, content, metadata FROM vector_store WHERE id IN (" +
                String.join(",", Collections.nCopies(candidateIds.size(), "?::uuid")) + ")";

        Object[] idParams = candidateIds.toArray();

        // 先查出所有文档，建立 id -> document 的映射
        Map<String, Document> docMap = new HashMap<>();
        jdbcTemplate.query(fetchSql, idParams, (rs, rowNum) -> {
            Document doc = Document.builder()
                    .id(rs.getString("id"))
                    .text(rs.getString("content"))
                    .build();

            // 解析原有 metadata
            String metadataJson = rs.getString("metadata");
            if (metadataJson != null && !metadataJson.isEmpty()) {
                JSONObject json = JSON.parseObject(metadataJson);
                for (String key : json.keySet()) {
                    doc.getMetadata().put(key, json.get(key));
                }
            }
            docMap.put(doc.getId(), doc);
            return doc;
        });

        // 6. 将分数回填到 Document 的 metadata 中
        List<Document> candidates = new ArrayList<>();
        for (Map<String, Object> scoreData : candidateScores) {
            String id = scoreData.get("id").toString();
            Document doc = docMap.get(id);

            if (doc != null) {
                // 🔥 1. 获取分数 (注意数据库返回的可能是 BigDecimal 或 Double，需统一转 double)
                Object scoreObj = scoreData.get("rrf_score");
                double rrfScore = (scoreObj instanceof Number) ? ((Number) scoreObj).doubleValue() : 0.0;

                // 🔥 2. 存入 Metadata (代替 setScore)
                // 这样在后续打印日志或调试时，都能看到原始的 RRF 分数
                doc.getMetadata().put("rrf_score", rrfScore);

                // 🔥 2. 安全处理排名 (处理 NULL 值)
                Object vRankObj = scoreData.get("v_rank");
                Object kRankObj = scoreData.get("k_rank");

                if (vRankObj != null) {
                    doc.getMetadata().put("vector_rank", ((Number) vRankObj).longValue());
                } else {
                    doc.getMetadata().put("vector_rank", -1L); // -1 表示未进入向量 Top50
                }

                if (kRankObj != null) {
                    doc.getMetadata().put("keyword_rank", ((Number) kRankObj).longValue());
                } else {
                    doc.getMetadata().put("keyword_rank", -1L); // -1 表示未进入关键词 Top50
                }

                candidates.add(doc);
            }
        }

        // 🔥 4. 【关键】在传给 Rerank 之前，根据 metadata 里的分数手动排序
        // 因为去掉了 setScore，我们需要显式告诉列表怎么排
        candidates.sort((d1, d2) -> {
            double s1 = (double) d1.getMetadata().getOrDefault("rrf_score", 0.0);
            double s2 = (double) d2.getMetadata().getOrDefault("rrf_score", 0.0);
            return Double.compare(s2, s1); // 降序排列
        });

        // 5. 【关键步骤】调用 Rerank 服务进行精排
        // 这步会获取 50 个文档的完整内容，然后用 Cross-Encoder 模型进行深度打分
        List<Document> finalResults = rerankerService.rerank(query, candidates, topK);

        System.out.println("经过 Rerank 精排后，最终返回 " + finalResults.size() + " 条结果");
        System.out.println("Rerank 完成，正在进行规则加权修正...");

        // 🔥 核心逻辑：遍历结果，给“元数据匹配”的文档暴力加分
        for (Document doc : finalResults) {
            // 1. 获取当前的 Rerank 分数 (假设 Rerank 服务已经更新了 score 或者 metadata 里的分数)
            // 注意：这里假设你的 Rerank 服务返回的 Document 里，分数存在 getScore() 或者 metadata 里
            // 如果你的 Rerank 服务只返回了 text，你需要先确保分数被取出来了。
            // 这里假设分数在 metadata 的 "rerank_score" 或 "score" 字段中
            Double currentScore = (Double) doc.getMetadata().getOrDefault("rerank_score", doc.getScore() != null ? doc.getScore() : 0.0);

            // 2. 判断是否命中元数据规则
            // 我们在粗排阶段给元数据匹配的文档打了 "rrf_score" 标签，或者你可以专门设一个 "is_metadata_match" 标签
            boolean isMetadataMatch = doc.getMetadata().containsKey("rrf_score");
            // 或者更精准一点：如果 RRF 分数 > 0.5 (你的 SQL 里元数据匹配是 1.0)
            boolean isHighPriority = (double) doc.getMetadata().getOrDefault("rrf_score", 0.0) == 1.0;

            if (isHighPriority) {
                // 🔥 3. 暴力加分
                // 加上 0.2 ~ 0.5 的权重，通常 Rerank 分数在 0~1 之间
                // 这样能保证只要元数据匹配，排名就会大幅上升
                double newScore = currentScore + 0.5;

                // 4. 存回 Metadata (因为没有 setScore)
                doc.getMetadata().put("final_score", newScore);

                // 如果 Document 类有 getScore() 但没 setScore()，且后续逻辑依赖 getScore()
                // 你可能需要通过反射或者子类处理，但通常我们只改 metadata 就够了
            }
        }

        // 🔥 5. 重新排序 (根据加权后的分数)
        finalResults.sort((d1, d2) -> {
            // 优先取 final_score，如果没有则取 rerank_score
            double s1 = (double) d1.getMetadata().getOrDefault("final_score",
                    (double) d1.getMetadata().getOrDefault("rerank_score", 0.0));
            double s2 = (double) d2.getMetadata().getOrDefault("final_score",
                    (double) d2.getMetadata().getOrDefault("rerank_score", 0.0));
            return Double.compare(s2, s1); // 降序
        });

        // 6. 截取 Top K
        List<Document> topResults = finalResults.stream()
                .limit(topK)
                .collect(Collectors.toList());

        return topResults;
        //return finalResults;
    }

    /**
     * 纯向量检索
     */
    public List<Document> vectorSearch(String query, int topK) {
        float[] queryVector = embeddingModel.embed(query);
        String vectorString = formatVector(queryVector);

        String sql = """
            SELECT id, content, metadata, 1 - (embedding <=> ?::vector) as similarity
            FROM vector_store
            ORDER BY embedding <=> ?::vector
            LIMIT ?
            """;

        return jdbcTemplate.query(sql, new Object[]{vectorString, vectorString, topK},
                (rs, rowNum) -> {
                    Document doc = Document.builder()
                            .id(rs.getString("id"))
                            .text(rs.getString("content"))
                            .score(rs.getDouble("similarity"))
                            .build();

                    String metadataJson = rs.getString("metadata");
                    if (metadataJson != null && !metadataJson.isEmpty()) {
                        JSONObject json = JSON.parseObject(metadataJson);
                        for (String key : json.keySet()) {
                            doc.getMetadata().put(key, json.get(key));
                        }
                    }
                    return doc;
                });
    }

    /**
     * 格式化向量为 PostgreSQL vector 格式
     */
    private String formatVector(float[] vector) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < vector.length; i++) {
            if (i > 0) sb.append(",");
            sb.append(vector[i]);
        }
        sb.append("]");
        return sb.toString();
    }

    /**
     * 提取关键词，转换为 tsquery 格式
     */
    private String extractKeywords(String query) {
        // 移除标点符号
        String cleaned = query.replaceAll("[，,。！？；;\"'（）()【】《》\\s]+", " ");

        // 按空格分词
        String[] words = cleaned.split(" ");

        // 过滤停用词和过短的词
        List<String> validWords = new ArrayList<>();
        for (String word : words) {
            word = word.trim();
            if (word.length() >= 2 && !isStopWord(word)) {
                validWords.add(word);
            }
        }

        // 用 | (OR) 连接
        if (validWords.isEmpty()) {
            return query.length() > 2 ? query : "教育";
        }

        return String.join(" | ", validWords);
    }

    /**
     * 停用词过滤
     */
    private boolean isStopWord(String word) {
        Set<String> stopWords = Set.of("的", "了", "是", "在", "我", "有", "和", "就", "不", "也", "啊", "吗", "呢",
                "什么", "怎么", "为什么", "哪里", "哪个", "哪些", "如何", "能否", "可以",
                "请问", "帮忙", "需要", "想要", "一个", "这个", "那个", "我们", "他们", "你们");
        return stopWords.contains(word);
    }
}