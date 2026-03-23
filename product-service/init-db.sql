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

SELECT 'TrueJarvis Database Initialized with Vector Support!' AS status;