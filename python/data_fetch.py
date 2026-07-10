import yfinance as yf
import pandas as pd
import os


stock_pool = {
    "AAPL": "Apple",
    "MSFT": "Microsoft",
    "NVDA": "NVIDIA",
    "TSLA": "Tesla",
    "SPY": "S&P500 ETF",
    "QQQ": "NASDAQ ETF"
}


def fetch_market_data():

    all_data = []

    print("开始获取金融市场数据...")


    for code, name in stock_pool.items():

        print(f"正在获取: {name} {code}")

        try:

            df = yf.download(
                code,
                start="2025-01-01",
                end="2026-01-01",
                progress=False
            )

            df = df.reset_index()

            df["stock_code"] = code
            df["stock_name"] = name

            all_data.append(df)


        except Exception as e:

            print(
                f"{name} 获取失败:",
                e
            )


    market_data = pd.concat(
        all_data,
        ignore_index=True
    )


    return market_data



def save_data(df):

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


    path = os.path.join(
        data_dir,
        "raw_market_data.csv"
    )


    df.to_csv(
        path,
        index=False,
        encoding="utf-8-sig"
    )


    print("====================")
    print("数据保存完成")
    print(path)
    print("数据量:", len(df))



if __name__ == "__main__":

    data = fetch_market_data()

    print(data.head())

    save_data(data)