import pandas as pd
import os



def load_market_data():

    current_dir = os.path.dirname(
        os.path.abspath(__file__)
    )

    path = os.path.join(
        current_dir,
        "..",
        "data",
        "market_data.csv"
    )

    df = pd.read_csv(path)

    df["date"] = pd.to_datetime(
        df["date"]
    )

    return df



def calculate_indicators(df):

    result = []


    for code, group in df.groupby(
        "stock_code"
    ):


        group = group.sort_values(
            "date"
        )


        # 日收益率

        group["daily_return"] = (
            group["close"]
            .pct_change()
        )


        # 20日均线

        group["MA20"] = (
            group["close"]
            .rolling(20)
            .mean()
        )


        # 累计收益率

        total_return = (
            group["close"].iloc[-1]
            /
            group["close"].iloc[0]
            -1
        )


        # 波动率

        volatility = (
            group["daily_return"]
            .std()
        )


        # 最大回撤

        max_price = (
            group["close"]
            .cummax()
        )


        drawdown = (
            group["close"]
            -
            max_price
        ) / max_price


        max_drawdown = (
            drawdown.min()
        )


        result.append(
            {
                "stock_code":code,

                "stock_name":
                    group["stock_name"].iloc[0],

                "industry":
                    group["industry"].iloc[0],

                "total_return":
                    round(
                        total_return,
                        4
                    ),

                "volatility":
                    round(
                        volatility,
                        4
                    ),

                "max_drawdown":
                    round(
                        max_drawdown,
                        4
                    )
            }
        )


    return pd.DataFrame(result)



def add_risk_level(df):


    def risk(x):

        if x < 0.02:
            return "Low"

        elif x < 0.04:
            return "Medium"

        else:
            return "High"



    df["risk_level"] = (
        df["volatility"]
        .apply(risk)
    )


    return df



def save_result(df):


    current_dir = os.path.dirname(
        os.path.abspath(__file__)
    )


    path = os.path.join(
        current_dir,
        "..",
        "data",
        "stock_analysis_result.csv"
    )


    df.to_csv(
        path,
        index=False,
        encoding="utf-8-sig"
    )


    print(
        "分析结果保存:",
        path
    )



if __name__ == "__main__":


    print(
        "开始金融指标分析..."
    )


    data = load_market_data()


    result = calculate_indicators(
        data
    )


    result = add_risk_level(
        result
    )


    print("================")


    print(result)


    save_result(result)


    print(
        "分析完成"
    )