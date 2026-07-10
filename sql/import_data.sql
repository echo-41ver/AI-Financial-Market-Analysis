-- =================================
-- Import Financial Data
-- =================================



-- =================================
-- 1. 导入股票行情数据
-- =================================


LOAD DATA LOCAL INFILE '../data/market_data.csv'

INTO TABLE market_data

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
date,
stock_code,
stock_name,
industry,
open_price,
close_price,
high_price,
low_price,
volume
);



-- =================================
-- 2. 导入交易流水数据
-- =================================


LOAD DATA LOCAL INFILE '../data/transaction_data.csv'

INTO TABLE transaction_record

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
transaction_id,
user_id,
product_id,
amount,
transaction_type,
transaction_date
);



-- =================================
-- 3. 导入理财产品数据
-- =================================


LOAD DATA LOCAL INFILE '../data/product_data.csv'

INTO TABLE financial_product

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS

(
product_id,
product_name,
risk_level,
annual_return,
category
);