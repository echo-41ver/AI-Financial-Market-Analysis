-- Run with: mysql --local-infile=1 -u root -p financial_analysis < sql/import_data.sql
-- The mysql client must permit LOCAL INFILE. Paths use forward slashes, which MySQL
-- accepts on Windows and which avoids backslash escaping issues.
USE financial_analysis;

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/market_data.csv'
INTO TABLE market_data
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`date`, stock_code, stock_name, industry, open_price, close_price, high_price, low_price, volume);

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/transaction_data.csv'
INTO TABLE transaction_record
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(transaction_id, user_id, product_id, amount, transaction_type, transaction_date);

LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/product_data.csv'
INTO TABLE financial_product
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(product_id, product_name, risk_level, annual_return, category);

-- The project contains stock_analysis_result.csv (not risk_analysis_result.csv).
-- id is intentionally omitted, so MySQL generates AUTO_INCREMENT values.
LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/stock_analysis_result.csv'
INTO TABLE risk_analysis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(stock_code, stock_name, industry, total_return, volatility, max_drawdown, risk_level)
SET analysis_date = CURDATE();

-- id is intentionally omitted, so MySQL generates AUTO_INCREMENT values.
LOAD DATA LOCAL INFILE 'D:/gitsyf/AI-Financial-Market-Analysis/data/ai_risk_prediction.csv'
INTO TABLE ai_risk_prediction
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(stock_code, stock_name, industry, total_return, volatility, max_drawdown, risk_level, ai_risk_prediction)
SET prediction_date = CURDATE();
