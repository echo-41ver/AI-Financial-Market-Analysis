-- Post-deployment checks for MySQL 8.0.
USE financial_analysis;

SHOW TABLES;

SELECT 'market_data' AS table_name, COUNT(*) AS row_count FROM market_data
UNION ALL SELECT 'transaction_record', COUNT(*) FROM transaction_record
UNION ALL SELECT 'financial_product', COUNT(*) FROM financial_product
UNION ALL SELECT 'risk_analysis', COUNT(*) FROM risk_analysis
UNION ALL SELECT 'ai_risk_prediction', COUNT(*) FROM ai_risk_prediction;
