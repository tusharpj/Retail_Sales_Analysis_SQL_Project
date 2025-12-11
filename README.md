Retail Sales Analysis SQL Project

Project Overview

Project Title: Retail Sales Analysis
Database: retail_sales_analysis_sql_project

This project demonstrates essential SQL skills used by data analysts to explore, clean, and analyze retail sales data. It includes database setup, data cleaning, exploratory analysis, and business-focused SQL queries.

Objectives

Database Setup – Create and prepare a retail sales database.

Data Cleaning – Identify and remove missing or invalid records.

Exploratory Data Analysis – Understand customers, sales, and product categories.

Business Insights – Use SQL queries to answer real-world analytical questions.

Project Structure
1. Database Setup

The project begins by creating a database and a retail_sales table.

CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sales FLOAT
);

2. Data Exploration & Cleaning
Record Count
SELECT COUNT(*) FROM retail_sales;

Unique Customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

Categories
SELECT DISTINCT category FROM retail_sales;

Null Value Check
SELECT *
FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

Delete Records With Null Values
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

3. Data Analysis & Business Queries

Below are the 10 business SQL queries, rewritten using your exact queries.

1️⃣ Retrieve all sales made on 2022-11-05
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

2️⃣ Retrieve all Clothing transactions with quantity > 3 in Nov-2022
SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND quantity > 3
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-11-30';

3️⃣ Total sales for each category
SELECT 
    category,
    SUM(total_sales) AS Total_Sales
FROM retail_sales
GROUP BY 1;

4️⃣ Average age of customers who purchased Beauty items
SELECT 
    category,
    ROUND(AVG(age), 2) AS avg_age_of_customers
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1;

5️⃣ All transactions where total_sales > 1000
SELECT * 
FROM retail_sales
WHERE total_sales > 1000;

6️⃣ Total number of transactions by gender in each category
SELECT 
    category,
    gender,
    COUNT(*) AS Transaction_records
FROM retail_sales
GROUP BY gender, category
ORDER BY category;

7️⃣ Best-selling month each year (based on average sale)
SELECT 
    yearr,
    monthh,
    average_sale
FROM
(
    SELECT 
        YEAR(sale_date) AS yearr,
        MONTH(sale_date) AS monthh,
        AVG(total_sales) AS average_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sales) DESC) AS rankk
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE rankk = 1;

8️⃣ Top 5 customers based on total sales
SELECT 
    customer_id,
    SUM(total_sales) AS Highest_Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Highest_Total_Sales DESC
LIMIT 5;

9️⃣ Number of unique customers per category
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales
GROUP BY category;

🔟 Create shifts and count number of orders per shift
WITH Orders AS
(
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) <= 12 THEN 'Morning Shift'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
            ELSE 'Evening Shift'
        END AS shifts
    FROM retail_sales
)
SELECT 
    shifts,
    COUNT(*) AS order_count
FROM Orders
GROUP BY shifts;

Findings

Significant variation in monthly sales helps identify peak selling periods.

Clothing and Beauty categories have high customer engagement.

High-value transactions (sales > 1000) show premium customers.

Shifts reveal busiest times of the day.

Top 5 customers contribute major revenue.

Conclusion

This project is an excellent beginner-friendly SQL portfolio project, covering:

Database creation

Data cleaning

Exploratory analysis

Real-world business queries

These insights help businesses understand customer behavior, sales trends, and category performance.
