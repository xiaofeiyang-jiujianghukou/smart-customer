-- init-db.sql
-- 启用 pgvector 扩展 (用于二期 RAG)
CREATE EXTENSION IF NOT EXISTS vector;

-- 创建真维斯初始表结构示例 (用户表)
-- MyBatis-Plus 会自动管理后续的业务表，这里仅做初始化验证
CREATE TABLE IF NOT EXISTS sys_user (
                                        id BIGSERIAL PRIMARY KEY,
                                        username VARCHAR(50) NOT NULL UNIQUE,
                                        password VARCHAR(100) NOT NULL,
                                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sys_user (username, password)
VALUES ('admin', '$2a$10$YourHashedPasswordHere')
ON CONFLICT (username) DO NOTHING;

CREATE EXTENSION IF NOT EXISTS vector;

-- 2. 用户表 (users)
CREATE TABLE IF NOT EXISTS users (
                                     user_id VARCHAR(64) PRIMARY KEY,          -- UUID / Snowflake
                                     username VARCHAR(50) NOT NULL UNIQUE,     -- 唯一用户名
                                     password VARCHAR(255) NOT NULL,      -- BCrypt 密码 (60+ chars)
                                     avatar_url VARCHAR(512),                  -- MinIO 路径或 URL
                                     created_at TIMESTAMPTZ DEFAULT NOW(),
                                     updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 索引：用户名快速查找
CREATE INDEX idx_users_username ON users(username);

-- 3. 会话表 (conversations)
CREATE TABLE IF NOT EXISTS conversations (
                                             conv_id VARCHAR(64) PRIMARY KEY,          -- UUID / Snowflake
                                             user_id VARCHAR(64) NOT NULL,             -- 外键逻辑关联
                                             mode VARCHAR(32) NOT NULL DEFAULT 'DIRECT_LLM', -- DIRECT_LLM, AGENT_PLAN, KB_RAG
                                             title VARCHAR(255),                       -- 会话标题
                                             status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',   -- ACTIVE, ARCHIVED, ERROR
                                             last_active_at TIMESTAMPTZ DEFAULT NOW(),
                                             created_at TIMESTAMPTZ DEFAULT NOW(),

                                             CONSTRAINT fk_conv_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 关键索引：快速拉取用户会话列表 (按最后活跃时间倒序)
CREATE INDEX idx_conv_user_active ON conversations(user_id, last_active_at DESC);

-- 4. 消息表 (messages)
CREATE TABLE IF NOT EXISTS messages (
                                        msg_id VARCHAR(64) PRIMARY KEY,           -- UUID / Snowflake
                                        conv_id VARCHAR(64) NOT NULL,             -- 外键逻辑关联
                                        type VARCHAR(32) NOT NULL,                -- USER_INPUT, AI_RESPONSE, SYSTEM_ERROR
                                        content TEXT,                             -- 消息内容 (支持长文本)
                                        meta_info JSONB,                          -- 扩展字段 (文件引用、Token 用量等)
                                        status VARCHAR(32) NOT NULL DEFAULT 'SENDING', -- SENDING, SENT, STREAMING, COMPLETED, FAILED
                                        is_stream_complete BOOLEAN DEFAULT FALSE, -- 流式传输是否完成
                                        timestamp TIMESTAMPTZ DEFAULT NOW(),

    -- 预留向量字段 (用于二期 RAG)
                                        embedding vector(1536),                   -- 假设使用 1536 维向量

                                        CONSTRAINT fk_msg_conv FOREIGN KEY (conv_id) REFERENCES conversations(conv_id) ON DELETE CASCADE
);

-- 关键索引：分页加载历史消息 (按会话 + 时间)
CREATE INDEX idx_msg_conv_time ON messages(conv_id, timestamp DESC);

-- 向量索引 (二期 RAG 用，初期可注释)
-- CREATE INDEX ON messages USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);

SELECT 'TrueJarvis Database Initialized with Vector Support!' AS status;