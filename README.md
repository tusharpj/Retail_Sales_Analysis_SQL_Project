# Retail Sales Analysis SQL Project

## Project Overview

**Project Title:** Retail Sales Analysis  
**Database:** `retail_sales_analysis_sql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.  
2. **Data Cleaning:** Identify and remove any records with missing or null values.  
3. **Exploratory Data Analysis (EDA):** Perform basic exploratory data analysis to understand the dataset.  
4. **Business Analysis:** Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation:** The project starts by creating a database named `retail_sales_analysis_sql_project`.  
- **Table Creation:** A table named `retail_sales` is created to store the sales data.

```sql
CREATE DATABASE retail_sales_analysis_sql_project;

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
```

### 2. Data Exploration & Cleaning

**Record Count**
```sql
SELECT COUNT(*) FROM retail_sales;
```

**Customer Count**
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

**Category Count**
```sql
SELECT DISTINCT category FROM retail_sales;
```

**Null Value Check**
```sql
SELECT *
FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

**Delete Records With Null Values**
```sql
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

## Data Analysis & Business Queries

Below are the **10 business SQL queries**, formatted and ready to copy.

### 1️⃣ WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
```sql
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';
```

### 2️⃣ WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 3 IN THE MONTH OF NOV-2022
```sql
SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND quantity > 3
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-11-30';
```

### 3️⃣ WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY
```sql
SELECT category,
       SUM(total_sales) AS Total_Sales
FROM retail_sales
GROUP BY 1;
```

### 4️⃣ WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM 'BEAUTY' CATEGORY
```sql
SELECT category,
       ROUND(AVG(age), 2) AS avg_age_of_customers
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1;
```

### 5️⃣ WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000
```sql
SELECT * 
FROM retail_sales
WHERE total_sales > 1000;
```

### 6️⃣ WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS(transaction_id) MADE BY EACH GENDER IN EACH CATEGORY
```sql
SELECT category,
       gender,
       COUNT(*) AS Transaction_records
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

### 7️⃣ WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR.
```sql
SELECT yearr,
       monthh,
       average_sale
FROM (
    SELECT YEAR(sale_date) AS yearr,
           MONTH(sale_date) AS monthh,
           AVG(total_sales) AS average_sale,
           RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sales) DESC) AS rankk
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE rankk = 1;
```

### 8️⃣ WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
```sql
SELECT customer_id,
       SUM(total_sales) AS Highest_Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Highest_Total_Sales DESC
LIMIT 5;
```

### 9️⃣ WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEM FROM EACH CATEGORY
```sql
SELECT category,
       COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales
GROUP BY category;
```

### 🔟 WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS
```sql
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
SELECT shifts,
       COUNT(*) AS order_count
FROM Orders
GROUP BY shifts;
```

## Findings

- Customer demographics insights  
- High-value transactions  
- Sales trend patterns  
- Customer behavior analytics

## Report

- Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
- Trend Analysis: Insights into sales trends across different months and shifts.
- Customer Insights: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## END OF PROJECT

## Credit 
## Zero Analyst(Github : https://github.com/najirh)

