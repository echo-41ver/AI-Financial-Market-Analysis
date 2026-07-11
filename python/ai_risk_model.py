import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score


# =========================
# 读取数据
# =========================

input_file = "data/stock_analysis_result.csv"

data = pd.read_csv(input_file)

print("AI Risk Model Started")
print("================")


# =========================
# 特征选择
# =========================

features = [
    "total_return",
    "volatility",
    "max_drawdown"
]


X = data[features]


# 标签

y = data["risk_level"]


# =========================
# 标签编码
# =========================

encoder = LabelEncoder()

y_encoded = encoder.fit_transform(y)


# =========================
# 划分训练测试集
# =========================

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y_encoded,
    test_size=0.3,
    random_state=42
)


# =========================
# AI模型
# =========================

model = RandomForestClassifier(
    n_estimators=100,
    random_state=42
)


model.fit(
    X_train,
    y_train
)

# =========================
# 输出特征重要性
# =========================

importance = pd.DataFrame({
    "feature": features,
    "importance": model.feature_importances_
})


importance = importance.sort_values(
    by="importance",
    ascending=False
)


importance.to_csv(
    "data/feature_importance.csv",
    index=False,
    encoding="utf-8-sig"
)


print("Feature importance saved")


# =========================
# 模型评价
# =========================

prediction = model.predict(X_test)

accuracy = accuracy_score(
    y_test,
    prediction
)


print(
    "Model Accuracy:",
    round(accuracy,4)
)


# =========================
# 全量预测
# =========================

data["AI_Risk_Prediction"] = encoder.inverse_transform(
    model.predict(X)
)


# =========================
# 保存结果
# =========================

output_file = "data/ai_risk_prediction.csv"


data.to_csv(
    output_file,
    index=False,
    encoding="utf-8-sig"
)


print("================")
print("AI Prediction Completed")
print(output_file)