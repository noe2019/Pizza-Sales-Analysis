# Pizza-Sales-Analysis
---
## Table of Contents

1. [Introduction](#introduction)
2. [Data Overview](#data-overview)
3. [Project Objectives](#project-objectives)
4. [ETL Process](#etl-process)
   - [Step 1: Data Extraction and Loading](#step-1-data-extraction-and-loading)
   - [Step 2: Data Transformation](#step-2-data-transformation)
5. [SQL Queries](#sql-queries)
6. [DAX Queries](#dax-queries)
7. [Power BI Visualization](#power-bi-visualization)
   - [Summary Dashboard](#summary-dashboard)
   - [Best/Worst Sellers Dashboard](#bestworst-sellers-dashboard)
8. [Insights and Recommendations](#insights-and-recommendations)
9. [Conclusion](#conclusion)
10. [Tools Used](#tools-used)

---

## Introduction

This project analyzes pizza sales data to provide actionable insights for maximizing revenue and improving sales strategies. By leveraging Power BI, the analysis delves into sales trends, top-performing products, and customer preferences, helping the business make informed decisions to enhance profitability.

## Data Overview

- **Dataset**: `pizza_sales.csv`
- **Fields Included**:
  - Order Date, Pizza Size, Pizza Category, Quantity Sold, Revenue, etc.

## Project Objectives

- **Sales Analysis**: Visualize pizza sales across various dimensions such as pizza size, category, and order date.
- **Performance Tracking**: Identify the best and worst-selling pizzas by revenue, quantity, and order count.
- **Actionable Insights**: Provide recommendations for improving sales strategies and maximizing revenue.

## ETL Process

### Step 1: Data Extraction and Loading

- Data was extracted from the pizza sales records and loaded into SQL Server for data integrity and management.
- **Data Exploration**: Initial exploration was conducted to understand the distribution of key features and identify any missing values.

### Step 2: Data Transformation

- **Data Cleaning**: Missing values were handled, and categorical variables were encoded.
- **Feature Engineering**: New features like `Order Day`, `Pizza Category`, and `Pizza Size` were created for better analysis.

## SQL Queries

### 1. **Create Database and Import Data**
   ```sql
   CREATE DATABASE PizzaSales;

   USE PizzaSales;

   CREATE TABLE PizzaSalesData (
       OrderDate DATE,
       PizzaSize VARCHAR(20),
       PizzaCategory VARCHAR(50),
       Quantity INT,
       Revenue DECIMAL(10, 2)
   );

   BULK INSERT PizzaSalesData
   FROM 'path_to_your/pizza_sales.csv'
   WITH (
       FIELDTERMINATOR = ',',
       ROWTERMINATOR = '\n',
       FIRSTROW = 2
   );
   ```

### 2. **Data Exploration**
   - **Check for Missing Values**:
     ```sql
     SELECT 
         SUM(CASE WHEN PizzaSize IS NULL THEN 1 ELSE 0 END) AS PizzaSize_Null,
         SUM(CASE WHEN PizzaCategory IS NULL THEN 1 ELSE 0 END) AS PizzaCategory_Null,
         SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Null,
         SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) AS Revenue_Null
     FROM PizzaSalesData;
     ```

   - **Analyze Sales by Pizza Category**:
     ```sql
     SELECT PizzaCategory, COUNT(*) AS TotalOrders, SUM(Quantity) AS TotalQuantity, SUM(Revenue) AS TotalRevenue
     FROM PizzaSalesData
     GROUP BY PizzaCategory;
     ```

   - **Monthly Sales Trend**:
     ```sql
     SELECT 
         FORMAT(OrderDate, 'yyyy-MM') AS Month, 
         SUM(Quantity) AS TotalPizzasSold, 
         SUM(Revenue) AS TotalRevenue
     FROM PizzaSalesData
     GROUP BY FORMAT(OrderDate, 'yyyy-MM');
     ```

## DAX Queries

### 1. **Total Revenue**
   ```dax
   TotalRevenue = SUM(PizzaSalesData[Revenue])
   ```

### 2. **Total Pizzas Sold**
   ```dax
   TotalPizzasSold = SUM(PizzaSalesData[Quantity])
   ```

### 3. **Average Order Value**
   ```dax
   AvgOrderValue = [TotalRevenue] / COUNTROWS(PizzaSalesData)
   ```

### 4. **Sales by Pizza Category**
   ```dax
   SalesByCategory = SUMMARIZE(
       PizzaSalesData,
       PizzaSalesData[PizzaCategory],
       "TotalRevenue", [TotalRevenue],
       "TotalQuantity", SUM(PizzaSalesData[Quantity])
   )
   ```

## Power BI Visualization

### Summary Dashboard
The summary dashboard provides an overview of the key metrics:

- **Total Revenue**: 808K
- **Average Order Value**: 38.30
- **Total Pizzas Sold**: 48.98K
- **Total Orders**: 21.10K
- **Average Pizzas Per Order**: 2.32

#### Sales Trends
- **Daily Trend for Total Orders**: Orders peak on Thursdays (3.5K orders), with the lowest on Sundays (2.6K orders).
- **Monthly Trend for Total Orders**: January sees the highest number of orders (3,708), followed by July (1,853).

#### Pizza Category & Size Insights
- **Category**: The Classic category contributes the most to both sales and total orders.
- **Size**: Large pizzas account for 45.84% of sales, making it the most popular size.

### Best/Worst Sellers Dashboard
This dashboard highlights the top and bottom-performing pizzas:

- **Top 5 Pizzas by Revenue**: The Thai Chicken Pizza generates the most revenue (43K), while the Classic Deluxe Pizza leads in total quantities sold.
- **Bottom 5 Pizzas by Revenue**: The Brie Carre pizza is the lowest performer in both revenue (12K) and total orders (479).

## Insights and Recommendations

1. **Peak Sales Times**:
   - **Days**: Orders are highest on Fridays and Saturdays, particularly in the evenings.
   - **Months**: January and July see the maximum orders, suggesting these months should be targeted for promotions.

2. **Product Performance**:
   - **Category**: Classic pizzas are the most popular, contributing significantly to both revenue and orders.
   - **Size**: Large pizzas dominate sales, making up nearly half of the total revenue.

3. **Underperforming Products**:
   - **Revenue**: The Brie Carre pizza is the lowest in both revenue and total orders. Consider revisiting this product's recipe or marketing strategy.
   - **Quantity**: Lower demand for small and XX-Large pizzas suggests a potential review of the sizing strategy.

4. **Targeted Promotions**:
   - Focus marketing efforts on underperforming categories and sizes during peak sales times to boost overall performance.

## Conclusion

This project provides a comprehensive analysis of pizza sales, offering insights into customer preferences and product performance. By leveraging these insights, the business can make data-driven decisions to optimize product offerings and maximize revenue.

---

### Tools Used

- **SQL Server**: For data storage and management.
- **Power BI**: For interactive dashboards and data visualization.
- **Python (Jupyter Notebook)**: For advanced data analysis and modeling.

---

By following this project, organizations can gain a deep understanding of their sales performance and take proactive steps to enhance customer satisfaction and increase profitability.
