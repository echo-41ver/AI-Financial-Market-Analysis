-- =================================
-- Financial Market Analysis SQL
-- =================================



-- =================================
-- 1. 股票收益排名
-- 找出表现最好的股票
-- =================================


SELECT

    stock_code,

    stock_name,

    industry,

    (
        MAX(close_price)
        /
        MIN(close_price)
        -1
    ) AS return_rate


FROM market_data


GROUP BY

    stock_code,

    stock_name,

    industry


ORDER BY

    return_rate DESC;



-- =================================
-- 2. 行业平均价格分析
-- 查看行业整体表现
-- =================================


SELECT


    industry,


    AVG(close_price)
    AS avg_price,


    AVG(volume)
    AS avg_volume



FROM market_data



GROUP BY industry;



-- =================================
-- 3. 高交易金额用户排行
-- 用户资金活跃度分析
-- =================================


SELECT


    user_id,


    SUM(amount)
    AS total_amount



FROM transaction_record



GROUP BY user_id



ORDER BY total_amount DESC;



-- =================================
-- 4. 不同交易类型统计
-- 买卖行为分析
-- =================================


SELECT


    transaction_type,


    COUNT(*)
    AS transaction_count,


    SUM(amount)
    AS total_amount



FROM transaction_record



GROUP BY transaction_type;



-- =================================
-- 5. 高风险理财产品查询
-- 风控场景
-- =================================


SELECT


    product_id,


    product_name,


    risk_level,


    annual_return



FROM financial_product



WHERE risk_level='High';



-- =================================
-- 6. 股票风险分析
-- 波动率排名
-- =================================


SELECT


    stock_name,


    volatility,


    max_drawdown,


    risk_level



FROM risk_analysis



ORDER BY volatility DESC;