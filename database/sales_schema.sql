CREATE DATABASE sales_forecasting;
USE sales_forecasting;

CREATE TABLE sales_data (
   Row_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(5, 2),
    Profit DECIMAL(10, 2)
);


USE sales_forecasting;
SHOW TABLES;
DESCRIBE sales_data;

USE sales_forecasting;
SELECT COUNT(*) FROM sales_data;

SELECT * FROM sales_data
LIMIT 10;

-- To Check unique values in important columns
SELECT 
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    COUNT(DISTINCT Product_ID) AS unique_products,
    COUNT(DISTINCT Order_ID) AS unique_orders,
    COUNT(DISTINCT City) AS unique_cities
FROM sales_data;

-- ## Sales Analysis by Category & Segment

-- Total Sales by Category
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    COUNT(*) AS Total_Orders
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Total Sales by Segment
SELECT 
    Segment,
    SUM(Sales) AS Total_Sales,
    COUNT(*) AS Total_Orders
FROM sales_data
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- Sales by Sub-Category
SELECT 
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Category, Sub_Category
ORDER BY Total_Sales DESC;

-- ## Regional Analysis

-- Sales and Profit by Region
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Top 10 Cities by Sales
SELECT 
    City,
    State,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY City, State
ORDER BY Total_Sales DESC
LIMIT 10;

-- Sales by State
SELECT 
    State,
    Region,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY State, Region
ORDER BY Total_Sales DESC;

-- ## Time-Based Analysis

-- Monthly Sales (Year-Month)
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Year_Mon,
    SUM(Sales) AS Monthly_Sales,
    COUNT(*) AS Total_Orders
FROM sales_data
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Year_Mon;

-- Yearly Sales
SELECT 
    YEAR(Order_Date) AS Year,
    SUM(Sales) AS Yearly_Sales,
    SUM(Profit) AS Yearly_Profit
FROM sales_data
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- Sales by Day of Week
SELECT 
    DAYNAME(Order_Date) AS Day_Name,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales
FROM sales_data
GROUP BY DAYNAME(Order_Date)
ORDER BY FIELD(Day_Name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- ## Customer Analysis

-- Top 10 Customers by Total Sales
SELECT 
    Customer_ID,
    Customer_Name,
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Customer_ID, Customer_Name, Segment
ORDER BY Total_Sales DESC
LIMIT 10;

-- Customers with Highest Profit
SELECT 
    Customer_ID,
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- ##  Product Analysis

-- Top 10 Products by Sales
SELECT 
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Quantity) AS Total_Quantity
FROM sales_data
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY Total_Sales DESC
LIMIT 10;

-- Most Profitable Products
SELECT 
    Product_Name,
    Category,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Name, Category
ORDER BY Total_Profit DESC
LIMIT 10;

-- ## Discount & Profit Analysis

-- Sales with Discount vs Without Discount
SELECT 
    CASE 
        WHEN Discount > 0 THEN 'With Discount'
        ELSE 'No Discount'
    END AS Discount_Status,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    AVG(Profit) AS Avg_Profit
FROM sales_data
GROUP BY Discount_Status;

-- Average Discount by Category
SELECT 
    Category,
    AVG(Discount) AS Avg_Discount,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Category
ORDER BY Avg_Discount DESC;

-- Loss Making Products (Negative Profit)
SELECT 
    Product_Name,
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Name, Category
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC
LIMIT 10;

-- ## Shipping Analysis

-- Shipping Mode Analysis
SELECT 
    Ship_Mode,
    COUNT(*) AS Total_Shipments,
    AVG(DATEDIFF(Ship_Date, Order_Date)) AS Avg_Shipping_Days
FROM sales_data
GROUP BY Ship_Mode
ORDER BY Total_Shipments DESC;

-- Orders by Ship Mode and Region
SELECT 
    Ship_Mode,
    Region,
    COUNT(*) AS Total_Orders
FROM sales_data
GROUP BY Ship_Mode, Region
ORDER BY Total_Orders DESC;

-- ## Advanced Analysis (For Forecasting)

-- Daily Sales Aggregated (For Linear Regression Model)
SELECT 
    Order_Date,
    SUM(Sales) AS Daily_Sales,
    SUM(Quantity) AS Total_Quantity,
    SUM(Profit) AS Daily_Profit,
    AVG(Discount) AS Avg_Discount
FROM sales_data
GROUP BY Order_Date
ORDER BY Order_Date;

-- Monthly Aggregated Data (For Forecasting)
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


