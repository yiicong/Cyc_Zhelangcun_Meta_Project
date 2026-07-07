-- ==============================================
-- 核心系统权限与用户表（v1.1 新增模块权限）
-- ==============================================

CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码（明文存储）',
  `permissions` VARCHAR(255) DEFAULT NULL COMMENT '用户权限(模块级逗号分隔,如: INV_MODULE)',
  `status` INT DEFAULT 1 COMMENT '帐号状态：1正常，0禁用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';
-- ==============================================
-- 投资记录模块表结构
-- ==============================================

-- 1. 投资产品/标的表
CREATE TABLE IF NOT EXISTS `inv_product` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `user_id` BIGINT NOT NULL COMMENT '归属用户ID',
  `code` VARCHAR(50) COMMENT '产品代码（选填，如00700）',
  `name` VARCHAR(100) NOT NULL COMMENT '产品名称（如：xx基金，xx股票）',
  `type` VARCHAR(20) NOT NULL COMMENT '产品分类代码（如FUND、STOCK等）',
  `currency` VARCHAR(10) DEFAULT 'CNY' COMMENT '计价币种（CNY/HKD/USD/USDT）',
  `status` TINYINT DEFAULT 1 COMMENT '状态：1-持有中，0-已清仓',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投资产品表';

-- 2. 投资流水/交易记录表
CREATE TABLE IF NOT EXISTS `inv_record` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `user_id` BIGINT NOT NULL COMMENT '归属用户ID',
  `product_id` BIGINT NOT NULL COMMENT '关联产品ID',
  `trade_type` TINYINT NOT NULL COMMENT '交易类型：1-首次买入，2-追加买入，3-卖出赎回，4-分红',
  `price` DECIMAL(15,4) COMMENT '成交单价（选填）',
  `shares` DECIMAL(15,4) COMMENT '成交份额/数量（选填）',
  `amount` DECIMAL(15,2) NOT NULL COMMENT '交易金额',
  `fee` DECIMAL(15,2) COMMENT '交易手续费（选填）',
  `trade_date` DATE NOT NULL COMMENT '交易日期',
  `value_date` DATE COMMENT '起息日/确认日',
  `remark` VARCHAR(255) COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投资流水记录表';

-- 3. 换汇记录表
CREATE TABLE IF NOT EXISTS `inv_exchange` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `user_id` BIGINT NOT NULL COMMENT '归属用户ID',
  `from_currency` VARCHAR(10) NOT NULL COMMENT '原币种（如：CNY）',
  `from_amount` DECIMAL(15,2) NOT NULL COMMENT '原币种金额',
  `to_currency` VARCHAR(10) NOT NULL COMMENT '目标币种（如：HKD）',
  `to_amount` DECIMAL(15,2) NOT NULL COMMENT '换出后金额',
  `exchange_rate` DECIMAL(10,4) COMMENT '汇率（to_amount / from_amount）',
  `exchange_rate_reverse` DECIMAL(10,4) COMMENT '反向汇率（from_amount / to_amount）',
  `exchange_date` DATE NOT NULL COMMENT '换汇日期',
  `remark` VARCHAR(255) COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='换汇记录表';

-- 4. 收益快照表
CREATE TABLE IF NOT EXISTS `inv_profit_snapshot` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `user_id` BIGINT NOT NULL COMMENT '归属用户ID',
  `product_id` BIGINT NOT NULL COMMENT '关联产品ID',
  `snapshot_date` DATE NOT NULL COMMENT '快照日期',
  `total_profit` DECIMAL(15,2) NOT NULL COMMENT '累计收益',
  `daily_profit` DECIMAL(15,2) COMMENT '当日收益',
  `principal` DECIMAL(15,2) COMMENT '累计本金',
  `market_value` DECIMAL(15,2) COMMENT '当日市值',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投资收益快照表';
