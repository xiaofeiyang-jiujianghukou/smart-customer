package com.ai.agent.customer.agent.framework.tool;

import com.ai.agent.customer.agent.framework.annotations.AgentTool;
import com.ai.agent.customer.agent.framework.annotations.ToolMethod;
import com.ai.agent.customer.agent.framework.annotations.ToolParam;
import com.ai.agent.customer.agent.framework.service.VectorStoreService;
import org.springframework.beans.factory.annotation.Autowired;

@AgentTool("KnowledgeBase")
public class KnowledgeTool {

    @Autowired
    private VectorStoreService vectorStore; // 比如接入了 Milvus 或 Pinecone

    @ToolMethod(name = "queryPolicy", description = "查询公司的业务政策、常见问题解答(FAQ)、退换货规则等非结构化文档。")
    public String queryPolicy(@ToolParam(value = "question", description = "用户提出的问题") String question) {
        // 1. 将问题向量化 2. 检索 top-k 文档片段 3. 返回拼接后的文本
        return vectorStore.similaritySearch(question);
    }
}
