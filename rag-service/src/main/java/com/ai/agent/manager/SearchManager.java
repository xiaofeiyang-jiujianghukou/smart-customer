package com.ai.agent.manager;

import com.ai.agent.service.HybridSearchService;
import com.ai.agent.service.RerankService;
import org.jspecify.annotations.NonNull;
import org.springframework.ai.document.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchManager {

    @Autowired
    private HybridSearchService searchService;

    @Autowired
    private RerankService rerankService;

    public @NonNull String hybridSearch(String q, int topK) {
        List<Document> results = searchService.search(q, topK);

        if (results.isEmpty()) {
            return "未找到相关内容\n\n💡 提示：请尝试使用更具体的关键词，如'唯寻师资力量'或'AI战略'";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("🔍 混合检索结果 (RRF 融合算法)\n");
        sb.append("查询: ").append(q).append("\n");
        sb.append("=".repeat(60)).append("\n\n");

        for (int i = 0; i < results.size(); i++) {
            Document doc = results.get(i);

            sb.append(i + 1).append(". ");
            sb.append("[综合分: ").append(String.format("%.4f", doc.getMetadata().get("rerank_score"))).append("]");

            Long vRank = (Long) doc.getMetadata().get("vector_rank");
            Long kRank = (Long) doc.getMetadata().get("keyword_rank");
            if (vRank != null) sb.append(" 向量排名:").append(vRank);
            if (kRank != null) sb.append(" 关键词排名:").append(kRank);
            sb.append("\n");

            // 显示内容预览
            String content = doc.getText();
            if (content != null) {
                content = content.replaceAll("\\s+", " ").trim();
                if (content.length() > 300) {
                    content = content.substring(0, 300) + "...";
                }
                sb.append("   ").append(content).append("\n");
            }
            sb.append("\n");
        }

        return sb.toString();
    }

    public @NonNull String vectorSearch(String q, int topK) {
        // 纯向量检索（用于对比）
        List<Document> results = searchService.vectorSearch(q, topK);

        // 2. 调用 DashScope Rerank 精排
        List<Document> finalResults = rerankService.rerank(q, results, 5);

        StringBuilder sb = new StringBuilder();
        sb.append("🔍 纯向量检索结果\n");
        sb.append("查询: ").append(q).append("\n");
        sb.append("=".repeat(60)).append("\n\n");

        sb.append("🔍 Rerank 精排前结果\n");
        for (int i = 0; i < results.size(); i++) {
            Document doc = results.get(i);
            sb.append(i + 1).append(". [相似度: ").append(String.format("%.4f", doc.getScore())).append("]\n");
            String content = doc.getText();
            if (content != null && content.length() > 300) {
                content = content.substring(0, 300) + "...";
            }
            sb.append("   ").append(content).append("\n\n");
        }

        sb.append("=".repeat(60)).append("\n\n");
        sb.append("🔍 Rerank 精排后结果\n");
        for (int i = 0; i < finalResults.size(); i++) {
            Document doc = finalResults.get(i);
            sb.append(i + 1).append(". [相似度: ").append(String.format("%.4f", doc.getScore())).append("]\n");
            String content = doc.getText();
            if (content != null && content.length() > 300) {
                content = content.substring(0, 300) + "...";
            }
            sb.append("   ").append(content).append("\n\n");
        }

        return sb.toString();
    }
}
