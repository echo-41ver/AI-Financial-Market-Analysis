import pandas as pd
import os



def clean_data():

    current_dir = os.path.dirname(
        os.path.abspath(__file__)
    )


    raw_path = os.path.join(
        current_dir,
        "..",
        "data",
        "raw_market_data.csv"
    )


    output_path = os.path.join(
        current_dir,
        "..",
        "data",
        "clean_market_data.csv"
    )


    print("开始数据清洗...")


    df = pd.read_csv(
        raw_path,
        header=[0,1]
    )


    # 展开yfinance多层表头
    df.columns = [
        "_".join(col).strip()
        if isinstance(col, tuple)
        else col
        for col in df.columns
    ]


    # 日期处理
    if "Date_" in df.columns:

        df.rename(
            columns={
                "Date_":"Date"
            },
            inplace=True
        )


    # 删除空数据
    df.dropna(
        how="all",
        inplace=True
    )


    # 保存

    df.to_csv(
        output_path,
        index=False,
        encoding="utf-8-sig"
    )


    print("================")
    print("清洗完成")
    print(output_path)
    print("数据量:",len(df))



if __name__=="__main__":

    clean_data()