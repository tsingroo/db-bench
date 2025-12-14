-- 创建Messages表
CREATE TABLE Messages (
    Id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '消息ID，主键自增',
    SessionId VARCHAR(64) NOT NULL COMMENT '会话ID，用于关联同一会话的多条消息',
    UserId VARCHAR(64) NOT NULL COMMENT '用户ID，标识消息所属用户',
    From TINYINT NOT NULL COMMENT '消息来源：1表示User，2表示Assistant',
    Content TEXT NOT NULL COMMENT '消息内容',
    CreateTime DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，插入时由数据库自动设置',
    UpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，更新时由数据库自动维护',
    DeleteTime DATETIME DEFAULT NULL COMMENT '删除时间，软删除标记，NULL表示未删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表，存储用户与助手之间的对话消息';

-- 创建索引
CREATE INDEX idx_session_id ON Messages(SessionId) COMMENT '会话ID索引，用于按会话查询消息';
CREATE INDEX idx_user_id ON Messages(UserId) COMMENT '用户ID索引，用于按用户查询消息';
CREATE INDEX idx_create_time ON Messages(CreateTime) COMMENT '创建时间索引，用于按时间排序和查询';

-- 创建联合索引
CREATE INDEX idx_user_session_create ON Messages(UserId, SessionId, CreateTime) COMMENT '用户ID+会话ID+创建时间联合索引，用于查询特定用户在特定会话中的消息按时间排序';
