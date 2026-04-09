package com.ai.agent.service;

import org.springframework.ai.document.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RerankService {

    @Value("${spring.ai.openai.api-key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    public RerankService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Document> rerank(String query, List<Document> candidates, int topK) {
        String url = "https://dashscope.aliyuncs.com/api/v1/services/rerank/text-rerank/text-rerank";

        // 1. 构建请求体
        Map<String, Object> input = new HashMap<>();
        input.put("query", query);
        input.put("documents", candidates.stream()
                .map(Document::getText)
                .collect(Collectors.toList()));

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("return_documents", true);
        parameters.put("top_n", topK);

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", "gte-rerank");
        requestBody.put("input", input);
        requestBody.put("parameters", parameters);

        // 2. 设置请求头
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("Content-Type", "application/json");

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        // 3. 发送请求
        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

        // 4. 解析结果
        Map<String, Object> responseBody = response.getBody();
        Map<String, Object> output = (Map<String, Object>) responseBody.get("output");
        List<Map<String, Object>> results = (List<Map<String, Object>>) output.get("results");

        // 5. 按 Rerank 分数排序返回
        List<Document> reranked = new ArrayList<>();
        for (Map<String, Object> result : results) {
            int index = (int) result.get("index");
            double relevanceScore = (double) result.get("relevance_score");

            // 获取原始文档（包含 id, metadata）
            Document original = candidates.get(index);

            // ⚠️ 修复：构建新文档时，保留所有旧信息，并更新分数
            Document newDoc = Document.builder()
                    .id(original.getId())
                    .text(original.getText())
                    .metadata(new HashMap<>(original.getMetadata())) // ⚠️ 关键：保留元数据
                    .score(relevanceScore) // ⚠️ 更新为 Rerank 的新分数
                    .build();

            // ⚠️ 额外加分项：把新分数也存进 metadata，方便调试
            newDoc.getMetadata().put("rerank_score", relevanceScore);
            reranked.add(newDoc);
        }

        return reranked;
    }
}