# 智能客服 AI Agent 系统 (Customer Service AI Agent)

[](https://www.google.com/search?q=)
本项目是一款基于大语言模型（LLM）驱动的自动化客户服务系统。通过**意图识别**、**动态任务规划**与**工具链调用**，实现从理解用户复杂需求到执行具体业务逻辑的闭环处理。

## 核心特性 (Phase 1)

  * **大脑中枢 (Brain Context):** 基于主流 LLM 的推理能力，深度理解用户意图，不再局限于关键词匹配。
  * **工具编排 (Tool Orchestration):** 系统能根据任务自动选择并调用外部工具（如数据库查询、订单处理、天气接口等）。
  * **动态规划 (Planning & Execution):** 支持将复杂请求拆解为多个步骤，并生成可执行的任务计划。
  * **自然语言输出:** 执行结果自动转化为温和、专业的人类语言回复用户。

## 系统架构

本阶段实现了经典的 **ReAct (Reasoning and Acting)** 模式架构：

1.  **Input:** 接收用户非结构化文本。
2.  **Reasoning:** LLM 分析上下文，决定下一步动作。
3.  **Action:** 选定对应工具并生成调用参数。
4.  **Observation:** 获取工具返回的原始数据。
5.  **Output:** 将数据整合后进行语言润色输出。

## 技术栈

  * **LLM:** DeepSeek
  * **Framework:** 原生实现
  * **Runtime:** java-25-openjdk-amd64
  * **Interface:** RESTful API 

## 快速开始

### 1\. 环境准备

```bash
git clone https://github.com/xiaofeiyang-jiujianghukou/smart-customer.git
cd smart-customer
docker-compose up -d --build
```

### 2\. 配置文件

在 `.env` 文件中配置你的 API Key：

```env
LLM_MODEL_NAME=your_model_name
LLM_MODEL_API_KEY=your_model_key_here
LLM_MODEL_BASE_URL=your_model_base_url
```

### 3\. 工具定义示例

```java
# 示例：如何向 Agent 注册一个新工具
@AgentTool("ProductTool")
public class ProductTool {

    @Autowired
    @Lazy
    private ProductFeignClient productFeignClient;

    @Autowired
    private JsonMapper jsonMapper;

    @ToolMethod(name = "getCouponDetail", description = "根据具体的优惠券ID列表获取优惠券详细信息（含优惠类型、使用门槛、有效时间）。")
    public List<CouponDTO> getCouponDetail(
            @ToolParam(value = "couponIds", description = "优惠券的唯一标识ID列表") List<Long> couponIds) {
        List<CouponDTO> data = productFeignClient.getCouponDetail(couponIds).getData();
        System.out.printf("ProductTool getCouponDetail req:%s, res:%s", couponIds, jsonMapper.writeValueAsString(data));
        return data;
    }
}
```

## 运行演示

> **User:** 我想知道用户888最近的一个订单的订单详情以及购买的商品和优惠情况。
>
> **Agent Thought:** 用户询问订单状态 -\> 调用 `get_order_status` 工具 -\> 参数: `order_id="SN-12345"`
> **Tool Observation:** "Status: Pending, Expected shipping: Tomorrow"
> **Agent Final Response:**
> 根据查询结果，用户888最近的一个订单详情如下：

**订单概览**
*   **订单号**：SN20260321888
*   **下单时间**：2026-03-21 13:58:28
*   **订单状态**：待支付
*   **订单总额**：9898.00元
*   **实付金额**：9348.00元

**购买商品**
1.  **商品名称**：iPhone 15 Pro
    *   **商品ID**：1
    *   **单价**：7999.00元
    *   **库存状态**：上架
2.  **商品名称**：AirPods Pro 2
    *   **商品ID**：2
    *   **单价**：1899.00元
    *   **库存状态**：上架

**优惠情况**
*   **优惠总金额**：550.00元
*   **使用优惠券**：
    *   `数码品类满5000减500` (券ID: 101)，面额500.00元。
    *   `全场通用红包` (券ID: 102)，面额50.00元。

**金额汇总**
*   商品总价：7999.00 + 1899.00 = 9898.00元
*   优惠抵扣：550.00元
*   最终应付：9898.00 - 550.00 = **9348.00元**

该订单目前状态为“待支付”，请及时完成支付。

-----

## 路线图 (Roadmap)

  - [x] **Phase 1:** 核心推理引擎与工具链基础实现。
  - [ ] **Phase 2:** 引入 **长短期记忆 (Memory)** 模块，支持多轮对话上下文。
  - [ ] **Phase 3:** 增加 **多模态 (Multimodal)** 支持，处理用户发送的图片或截图。
  - [ ] **Phase 4:** 引入 **自我反思 (Self-Reflection)** 机制，提高复杂任务的成功率。
