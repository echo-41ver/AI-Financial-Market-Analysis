-- Complete MySQL 8.0 database setup for Windows.
-- Run from the project root with:
-- mysql --local-infile=1 -u root -p < sql/setup_database.sql

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
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, `date` DATE NOT NULL,
    stock_code VARCHAR(20) NOT NULL, stock_name VARCHAR(100) NOT NULL, industry VARCHAR(100) NOT NULL,
    open_price DECIMAL(12, 2) NOT NULL, close_price DECIMAL(12, 2) NOT NULL,
    high_price DECIMAL(12, 2) NOT NULL, low_price DECIMAL(12, 2) NOT NULL,
    volume BIGINT UNSIGNED NOT NULL, PRIMARY KEY (id), KEY idx_market_data_stock_date (stock_code, `date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE transaction_record (
    transaction_id BIGINT UNSIGNED NOT NULL, user_id BIGINT UNSIGNED NOT NULL, product_id VARCHAR(20) NOT NULL,
    amount DECIMAL(14, 2) NOT NULL, transaction_type VARCHAR(10) NOT NULL, transaction_date DATE NOT NULL,
    PRIMARY KEY (transaction_id), KEY idx_transaction_record_user (user_id),
    KEY idx_transaction_record_product (product_id), KEY idx_transaction_record_date (transaction_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE financial_product (
    product_id VARCHAR(20) NOT NULL, product_name VARCHAR(100) NOT NULL, risk_level VARCHAR(20) NOT NULL,
    annual_return DECIMAL(8, 4) NOT NULL, category VARCHAR(50) NOT NULL, PRIMARY KEY (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE risk_analysis (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, stock_code VARCHAR(20) NOT NULL, stock_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL, total_return DECIMAL(10, 4) NOT NULL, volatility DECIMAL(10, 4) NOT NULL,
    max_drawdown DECIMAL(10, 4) NOT NULL, risk_level VARCHAR(20) NOT NULL, analysis_date DATE NOT NULL,
    PRIMARY KEY (id), KEY idx_risk_analysis_stock (stock_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ai_risk_prediction (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, stock_code VARCHAR(20) NOT NULL, stock_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL, total_return DECIMAL(10, 4) NOT NULL, volatility DECIMAL(10, 4) NOT NULL,
    max_drawdown DECIMAL(10, 4) NOT NULL, risk_level VARCHAR(20) NOT NULL,
    ai_risk_prediction VARCHAR(20) NOT NULL, prediction_date DATE NOT NULL,
    PRIMARY KEY (id), KEY idx_ai_risk_prediction_stock (stock_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/market_data.csv'
INTO TABLE market_data CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(`date`, stock_code, stock_name, industry, open_price, close_price, high_price, low_price, volume);

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/transaction_data.csv'
INTO TABLE transaction_record CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(transaction_id, user_id, product_id, amount, transaction_type, transaction_date);

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/product_data.csv'
INTO TABLE financial_product CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(product_id, product_name, risk_level, annual_return, category);

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/stock_analysis_result.csv'
INTO TABLE risk_analysis CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(stock_code, stock_name, industry, total_return, volatility, max_drawdown, risk_level)
SET analysis_date = CURDATE();

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/ai_risk_prediction.csv'
INTO TABLE ai_risk_prediction CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(stock_code, stock_name, industry, total_return, volatility, max_drawdown, risk_level, ai_risk_prediction)
SET prediction_date = CURDATE();

-- Test queries after import.
SELECT 'market_data' AS table_name, COUNT(*) AS row_count FROM market_data
UNION ALL SELECT 'transaction_record', COUNT(*) FROM transaction_record
UNION ALL SELECT 'financial_product', COUNT(*) FROM financial_product
UNION ALL SELECT 'risk_analysis', COUNT(*) FROM risk_analysis
UNION ALL SELECT 'ai_risk_prediction', COUNT(*) FROM ai_risk_prediction;

SELECT stock_code, stock_name, volatility, max_drawdown, risk_level
FROM risk_analysis
ORDER BY volatility DESC;
