-- 创建系统用户表
CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码（明文存储）',
  `status` INT DEFAULT 1 COMMENT '帐号状态：1正常，0禁用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

-- 插入默认管理员账号密码（用户名: admin, 密码: admin123）
INSERT INTO `sys_user` (`username`, `password`, `status`) 
VALUES ('admin', 'admin123', 1)
ON DUPLICATE KEY UPDATE `password` = VALUES(`password`);
