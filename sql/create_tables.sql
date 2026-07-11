-- MySQL 8.0 schema for the AI Financial Market Analysis project.
CREATE DATABASE IF NOT EXISTS financial_analysis
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE financial_analysis;

DROP TABLE IF EXISTS ai_risk_prediction;
DROP TABLE IF EXISTS risk_analysis;
DROP TABLE IF EXISTS transaction_record;
DROP TABLE IF EXISTS financial_product;
DROP TABLE IF EXISTS market_data;

CREATE TABLE market_data (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    stock_code VARCHAR(20) NOT NULL,
    stock_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    open_price DECIMAL(12, 2) NOT NULL,
    close_price DECIMAL(12, 2) NOT NULL,
    high_price DECIMAL(12, 2) NOT NULL,
    low_price DECIMAL(12, 2) NOT NULL,
    volume BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    KEY idx_market_data_stock_date (stock_code, `date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE transaction_record (
    transaction_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    amount DECIMAL(14, 2) NOT NULL,
    transaction_type VARCHAR(10) NOT NULL,
    transaction_date DATE NOT NULL,
    PRIMARY KEY (transaction_id),
    KEY idx_transaction_record_user (user_id),
    KEY idx_transaction_record_product (product_id),
    KEY idx_transaction_record_date (transaction_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE financial_product (
    product_id VARCHAR(20) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    annual_return DECIMAL(8, 4) NOT NULL,
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE risk_analysis (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    stock_code VARCHAR(20) NOT NULL,
    stock_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    total_return DECIMAL(10, 4) NOT NULL,
    volatility DECIMAL(10, 4) NOT NULL,
    max_drawdown DECIMAL(10, 4) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    analysis_date DATE NOT NULL,
    PRIMARY KEY (id),
    KEY idx_risk_analysis_stock (stock_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ai_risk_prediction (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    stock_code VARCHAR(20) NOT NULL,
    stock_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    total_return DECIMAL(10, 4) NOT NULL,
    volatility DECIMAL(10, 4) NOT NULL,
    max_drawdown DECIMAL(10, 4) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    ai_risk_prediction VARCHAR(20) NOT NULL,
    prediction_date DATE NOT NULL,
    PRIMARY KEY (id),
    KEY idx_ai_risk_prediction_stock (stock_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
