-- =================================
-- AI Financial Market Analysis
-- Database Design
-- =================================


-- 删除旧表

DROP TABLE IF EXISTS market_data;

DROP TABLE IF EXISTS transaction_record;

DROP TABLE IF EXISTS financial_product;

DROP TABLE IF EXISTS risk_analysis;



-- =================================
-- 1. 股票行情表
-- =================================

CREATE TABLE market_data (

    id INT PRIMARY KEY AUTO_INCREMENT,

    date DATE,

    stock_code VARCHAR(20),

    stock_name VARCHAR(50),

    industry VARCHAR(50),

    open_price DECIMAL(10,2),

    close_price DECIMAL(10,2),

    high_price DECIMAL(10,2),

    low_price DECIMAL(10,2),

    volume BIGINT

);



-- =================================
-- 2. 用户交易流水表
-- =================================

CREATE TABLE transaction_record (

    transaction_id INT PRIMARY KEY,

    user_id INT,

    product_id VARCHAR(20),

    amount DECIMAL(12,2),

    transaction_type VARCHAR(10),

    transaction_date DATE

);



-- =================================
-- 3. 理财产品表
-- =================================

CREATE TABLE financial_product (

    product_id VARCHAR(20) PRIMARY KEY,

    product_name VARCHAR(100),

    risk_level VARCHAR(20),

    annual_return DECIMAL(5,4),

    category VARCHAR(50)

);



-- =================================
-- 4. 风险分析结果表
-- =================================

CREATE TABLE risk_analysis (

    id INT PRIMARY KEY AUTO_INCREMENT,

    stock_code VARCHAR(20),

    stock_name VARCHAR(50),

    volatility DECIMAL(8,4),

    max_drawdown DECIMAL(8,4),

    risk_level VARCHAR(20),

    analysis_date DATE

);