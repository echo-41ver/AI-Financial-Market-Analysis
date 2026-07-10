import pandas as pd
import numpy as np
import os
from datetime import datetime


# 股票池
stocks = [
    {
        "code": "AAPL",
        "name": "Apple",
        "industry": "Technology"
    },
    {
        "code": "MSFT",
        "name": "Microsoft",
        "industry": "Technology"
    },
    {
        "code": "NVDA",
        "name": "NVIDIA",
        "industry": "Technology"
    },
    {
        "code": "TSLA",
        "name": "Tesla",
        "industry": "Automobile"
    },
    {
        "code": "SPY",
        "name": "S&P500 ETF",
        "industry": "ETF"
    },
    {
        "code": "QQQ",
        "name": "NASDAQ ETF",
        "industry": "ETF"
    }
]


def generate_market_data():

    print("生成股票行情数据...")


    dates = pd.date_range(
        start="2025-01-01",
        end="2025-12-31",
        freq="B"
    )


    all_data = []


    for stock in stocks:


        price = np.random.uniform(
            50,
            300
        )


        for date in dates:


            change = np.random.normal(
                0,
                0.02
            )


            open_price = price

            close_price = (
                price *
                (1 + change)
            )


            high_price = max(
                open_price,
                close_price
            ) * np.random.uniform(
                1.00,
                1.03
            )


            low_price = min(
                open_price,
                close_price
            ) * np.random.uniform(
                0.97,
                1.00
            )


            volume = np.random.randint(
                1000000,
                10000000
            )


            all_data.append(
                {
                    "date":date,
                    "stock_code":stock["code"],
                    "stock_name":stock["name"],
                    "industry":stock["industry"],
                    "open":round(open_price,2),
                    "close":round(close_price,2),
                    "high":round(high_price,2),
                    "low":round(low_price,2),
                    "volume":volume
                }
            )


            price = close_price



    df = pd.DataFrame(all_data)


    return df



def generate_transaction_data():

    print("生成交易流水数据...")


    data=[]


    for i in range(10000):


        stock = np.random.choice(
            stocks
        )


        data.append(
            {
                "transaction_id":i+1,
                "user_id":np.random.randint(
                    1000,
                    2000
                ),
                "product_id":stock["code"],
                "amount":round(
                    np.random.uniform(
                        1000,
                        100000
                    ),
                    2
                ),
                "transaction_type":np.random.choice(
                    [
                        "BUY",
                        "SELL"
                    ]
                ),
                "date":np.random.choice(
                    pd.date_range(
                        "2025-01-01",
                        "2025-12-31"
                    )
                )
            }
        )


    return pd.DataFrame(data)




def generate_product_data():

    print("生成理财产品数据...")


    products=[]


    for i in range(50):


        products.append(
            {
                "product_id":
                    f"P{i+1:03}",

                "product_name":
                    f"Financial Product {i+1}",

                "risk_level":
                    np.random.choice(
                        [
                            "Low",
                            "Medium",
                            "High"
                        ]
                    ),

                "annual_return":
                    round(
                        np.random.uniform(
                            0.02,
                            0.12
                        ),
                        4
                    ),

                "category":
                    np.random.choice(
                        [
                            "Fund",
                            "Stock",
                            "Bond"
                        ]
                    )
            }
        )


    return pd.DataFrame(products)



def save_data(df, filename):


    current_dir = os.path.dirname(
        os.path.abspath(__file__)
    )


    data_dir = os.path.join(
        current_dir,
        "..",
        "data"
    )


    os.makedirs(
        data_dir,
        exist_ok=True
    )


    path=os.path.join(
        data_dir,
        filename
    )


    df.to_csv(
        path,
        index=False,
        encoding="utf-8-sig"
    )


    print(
        "保存完成:",
        path
    )



if __name__=="__main__":


    market = generate_market_data()

    transaction = generate_transaction_data()

    product = generate_product_data()


    save_data(
        market,
        "market_data.csv"
    )


    save_data(
        transaction,
        "transaction_data.csv"
    )


    save_data(
        product,
        "product_data.csv"
    )


    print("================")
    print("全部金融数据生成完成")
    print(
        "行情数据:",
        len(market)
    )

    print(
        "交易流水:",
        len(transaction)
    )

    print(
        "产品数据:",
        len(product)
    )