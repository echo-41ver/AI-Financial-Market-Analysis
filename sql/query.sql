-- Compatibility entry point for the requested query.sql file.
-- The same MySQL 8.0 queries are also kept in analysis_queries.sql.
USE financial_analysis;

SELECT stock_code, stock_name, industry,
       MAX(close_price) / NULLIF(MIN(close_price), 0) - 1 AS return_rate
FROM market_data
GROUP BY stock_code, stock_name, industry
ORDER BY return_rate DESC;

SELECT industry, AVG(close_price) AS avg_price, AVG(volume) AS avg_volume
FROM market_data
GROUP BY industry;

SELECT user_id, SUM(amount) AS total_amount
FROM transaction_record
GROUP BY user_id
ORDER BY total_amount DESC;

SELECT transaction_type, COUNT(*) AS transaction_count, SUM(amount) AS total_amount
FROM transaction_record
GROUP BY transaction_type;

SELECT product_id, product_name, risk_level, annual_return
FROM financial_product
WHERE risk_level = 'High';

SELECT stock_code, stock_name, volatility, max_drawdown, risk_level
FROM risk_analysis
ORDER BY volatility DESC;
