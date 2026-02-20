# Sales Forecasting Dashboard 📊

A machine learning project to **forecast future sales** using historical sales data.
This project includes data exploration, visualization, model training, and deployment through an interactive **Streamlit dashboard**.

---

## 📌 Table of Contents

* [Overview](#overview)
* [Dataset](#dataset)
* [Project Structure](#project-structure)
* [Installation](#installation)
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
* An easy-to-use **Streamlit dashboard** for non-technical users

Technologies used:

* **Python**
* **Streamlit** (for interactive dashboard)
* **scikit-learn / statsmodels** (for forecasting models)
* **Pandas / NumPy** (for data processing)
* **Matplotlib / Seaborn / Plotly** (for visualization)

---

## 📊 Dataset

The dashboard works with your own sales dataset.

* Typical features include: `Date`, `Product`, `Region`, `Units Sold`, `Revenue`.
* Forecasted variable: `Sales` or `Revenue`.

> 📁 Sample dataset is included in the `data/` folder for testing purposes.

---

## 📂 Project Structure

```
sales-forecasting-dashboard/
│── app/               # Main Streamlit app
│── dashboards/        # Visualization and UI components
│── data/              # Sample sales datasets
│── database/          # Database scripts
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
* Predicted future sales using **[your model type]**
* Helps businesses plan inventory, marketing campaigns, and staffing
  
- Forecast accuracy (R²): 0.3031  
- RMSE: $710.48  
- MAE: $468.90  

- Interpretation:
  - R² of 0.3031 means the model explains ~30% of the variance in sales.
  - On average, the prediction is off by $468.90.


---

## 🚀 Future Improvements

* Deploy dashboard on **Heroku / Render / Streamlit Cloud**
* Add multiple forecasting models and allow comparison
* Include automatic anomaly detection in sales data
* Integrate real-time data streaming from a database

---

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.
