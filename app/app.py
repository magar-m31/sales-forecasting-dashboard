# app.py
import streamlit as st
import pandas as pd
import pickle
import plotly.express as px

# -----------------------------
# Load Model & Data
# -----------------------------
model = pickle.load(open('sales_model.pkl', 'rb'))
summary = pd.read_csv("dashboard_summary.csv")
daily = pd.read_csv("daily_sales_data.csv")
monthly = pd.read_csv("monthly_sales_trend.csv")
daily['Order_Date'] = pd.to_datetime(daily['Order_Date'])

# -----------------------------
# Page Title
# -----------------------------
st.set_page_config(page_title="Sales Forecasting Dashboard", layout="wide")
st.markdown("""
# 🛒 Sales Forecasting Dashboard
This dashboard shows:
- **Historical daily and monthly sales trends**
- **Key performance indicators**
- **Predict sales for a given day using Linear Regression**
""")

# -----------------------------
# Sidebar Inputs for Prediction
# -----------------------------
st.sidebar.header("Input Features for Prediction")
quantity = st.sidebar.slider("Quantity", 1, 200, 50)
profit = st.sidebar.number_input("Profit", value=500)
discount = st.sidebar.slider("Discount", 0.0, 1.0, 0.1)
month = st.sidebar.selectbox("Month", range(1, 13))
day = st.sidebar.number_input("Day", 1, 31, 15)
dayofweek = st.sidebar.selectbox("Day of Week", range(7))

# -----------------------------
# Tabs for Sections
# -----------------------------
tab1, tab2, tab3 = st.tabs(["📊 KPIs", "📈 Sales Trends", "🤖 Predict Sales"])

# -----------------------------
# Tab 1: KPIs
# -----------------------------
with tab1:
    st.subheader("Key Metrics")
    cols = st.columns(4)
    cols[0].metric("💰 Total Sales", f"${summary.Value[0]:,.2f}", delta="+5%")
    cols[1].metric("📈 Total Profit", f"${summary.Value[1]:,.2f}", delta="+3%")
    cols[2].metric("🛒 Total Orders", f"{int(summary.Value[2]):,}")
    cols[3].metric("📦 Avg Order Value", f"${summary.Value[3]:,.2f}")
    st.markdown("---")
    if st.checkbox("Show KPI Summary Table"):
        st.dataframe(summary)

# -----------------------------
# Tab 2: Sales Trends
# -----------------------------
with tab2:
    st.subheader("Daily Sales Trend")
    fig_daily = px.line(daily, x="Order_Date", y="Sales", title="Daily Sales",
                        labels={"Sales": "Sales ($)", "Order_Date": "Date"})
    st.plotly_chart(fig_daily, use_container_width=True)

    st.subheader("Monthly Sales Trend")
    fig_monthly = px.bar(monthly, x="Year_Month", y="Monthly_Sales",
                         title="Monthly Sales", labels={"Monthly_Sales": "Sales ($)", "Year_Month": "Month"})
    st.plotly_chart(fig_monthly, use_container_width=True)

    st.markdown("---")
    if st.checkbox("Show Raw Daily Data"):
        st.dataframe(daily)
    if st.checkbox("Show Raw Monthly Data"):
        st.dataframe(monthly)

# -----------------------------
# Tab 3: Prediction
# -----------------------------
with tab3:
    st.subheader("Predict Daily Sales")
    pred_col, info_col = st.columns([2, 3])

    with pred_col:
        if st.button("Predict Sales"):
            input_data = [[quantity, profit, discount, month, day, dayofweek]]
            prediction = model.predict(input_data)[0]
            st.success(f"Predicted Sales: ${prediction:,.2f}")

    with info_col:
        st.info("""
        This prediction uses a linear regression model trained on historical sales data.
        """)
