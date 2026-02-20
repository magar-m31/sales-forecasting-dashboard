# Sales Forecasting Dashboard 📊

A machine learning project to **forecast future sales** using historical sales data.
This project includes **SQL-based data exploration**, Python data processing, model training, and deployment through an interactive **Streamlit dashboard**.

---

## 📌 Table of Contents

* [Overview](#overview)
* [Dataset](#dataset)
* [Project Structure](#project-structure)
* [Installation](#installation)
* [SQL Integration](#sql-integration)
* [Usage](#usage)
* [Results](#results)
* [Future Improvements](#future-improvements)
* [License](#license)

---

## 🔎 Overview

Sales forecasting helps businesses **predict future sales trends** and make better inventory, marketing, and staffing decisions.

This project provides:

* Interactive visualizations of historical sales data
* Forecasting using machine learning models
* SQL-based data exploration for easy querying
* An easy-to-use **Streamlit dashboard** for non-technical users

**Technologies used:**

* **Python**
* **Streamlit** (for interactive dashboard)
* **scikit-learn / statsmodels** (for forecasting models)
* **Pandas / NumPy** (for data processing)
* **Matplotlib / Seaborn / Plotly** (for visualization)
* **MySQL** (for data storage and querying)

---

## 📊 Dataset

The dashboard works with your own sales dataset.

* Typical features include: `Order_ID`, `Order_Date`, `Product`, `Region`, `Units Sold`, `Sales`, `Profit`, `Discount`.
* Forecasted variable: `Sales`.

> 📁 Sample dataset is included in the `data/` folder for testing purposes.

---

## 📂 Project Structure

```
sales-forecasting-dashboard/
│── app/               # Main Streamlit app
│── dashboards/        # Visualization and UI components
│── data/              # Sample sales datasets
│── database/          # SQL scripts and database setup
│── notebooks/         # Jupyter notebooks for EDA & model training
│── requirements.txt   # Python dependencies
│── .gitignore
│── README.md          # Project documentation
```

---

## ⚙️ Installation

Clone this repository and install dependencies:

```bash
git clone https://github.com/magar-m31/sales-forecasting-dashboard.git
cd sales-forecasting-dashboard
pip install -r requirements.txt
```

Make sure MySQL server is installed and running if using SQL queries.

---

## 🗄 SQL Integration

Data can be explored and aggregated **directly using SQL**:

**Example queries used in this project:**

```sql
-- Aggregate monthly sales
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(Quantity) AS Monthly_Quantity,
    AVG(Sales) AS Avg_Order_Value,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM sales_data
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Total sales by region
SELECT Region, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;
```

**Python + SQL Integration:**

```python
import mysql.connector
import pandas as pd

# Connect to MySQL
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='yourpassword',
    database='sales_forecasting'
)
query = "SELECT * FROM sales_data"
df = pd.read_sql(query, conn)
```

This allows **direct querying, aggregation, and joining** from Python for EDA and modeling.

---

## ▶️ Usage

Run the Streamlit app:

```bash
streamlit run app/main.py
```

Open in your browser:

```
http://localhost:8501/
```

Steps:

1. Upload your sales dataset (`CSV` format)
2. Explore sales trends via interactive charts
3. Run the forecasting model to predict future sales
4. Download the forecasted results

---

## 📈 Results

* Visualized historical sales trends by product, region, and time
* Predicted future sales using **Linear Regression**
* SQL queries helped **aggregate monthly and regional sales**
* Helps businesses plan inventory, marketing campaigns, and staffing

- Forecast accuracy (R²): 0.3031
- RMSE: $710.48
- MAE: $468.90

**Interpretation:**

* R² of 0.3031 means the model explains ~30% of the variance in sales.
* On average, the prediction is off by $468.90.

---

## 🚀 Future Improvements

* Deploy dashboard on **Heroku / Render / Streamlit Cloud**
* Add multiple forecasting models and allow comparison
* Include automatic anomaly detection in sales data
* Integrate real-time data streaming from a database
* Add SQL-driven interactive dashboards

---

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.
