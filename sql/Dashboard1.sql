SELECT * FROM pizza_sales

-- 1.	By Total Revenues

select TOP 5 pizza_name, sum(CAST(total_price AS decimal(10,2))) AS Total_Revenue 
from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- 2.	Average order value

select * from pizza_sales select sum(cast(total_price as float)) /  count(distinct order_id) as Avg_Order_Value 
from pizza_sales

-- 3.	Total Pizza sold

SELECT * FROM pizza_sales select sum(cast(quantity as int)) as Total_Orders from pizza_sales

-- 4.	Total orders

SELECT * FROM pizza_sales select count(DISTINCT(order_id)) as Total_Orders from pizza_sales

-- 5.	Average number of Pizza per order

SELECT * FROM pizza_sales
select cast(sum(cast(quantity as decimal(10,2))) /  count(distinct order_id)as decimal(10,2)) as Avg_nber_per_Order from pizza_sales

-- Chart 1: Daily trends for total orders

SELECT
    DATENAME(DW, CAST(order_date AS DATE)) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY 
    DATENAME(DW, CAST(order_date AS DATE));

-- Monthly trend

SELECT
    DATENAME(MONTH, CAST(order_date AS DATE)) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY 
    DATENAME(MONTH, CAST(order_date AS DATE))
ORDER BY DATENAME(MONTH, CAST(order_date AS DATE)) DESC;

-- Check incorrect dates

select order_date
from pizza_sales
where isdate(order_date)=1;

-- We see that incorrect dates is due to incorrect formatting so let us clearly define the datetime format of the dataset

SET DATEFORMAT DMY; -- For day-month-year format
SELECT
    DATENAME(DW, TRY_CAST(order_date AS DATE)) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
-- WHERE ISDATE(order_date) = 1
GROUP BY 
    DATENAME(DW, TRY_CAST(order_date AS DATE));

-- Chart 2: Hourly trend for total orders

SET DATEFORMAT DMY; -- For day-month-year format
SELECT
    DATENAME(HOUR, TRY_CAST(order_time AS DATETIME)) AS order_hourly, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY 
    DATENAME(HOUR, TRY_CAST(order_time AS DATETIME));

-- Chart 3: Calculate the percentage of sales by pizza category

SELECT
    pizza_category, 
    SUM(CAST(total_price AS decimal(10, 2))) AS Total_price, 
    ROUND(SUM(CAST(total_price AS decimal(10, 2))) * 100.0 / total_sales.total_amount, 2) AS percentage_of_sales
FROM 
    pizza_sales,
    (SELECT SUM(CAST(total_price AS decimal(10, 2))) AS total_amount FROM pizza_sales) AS total_sales

GROUP BY 
    pizza_category, 
    total_sales.total_amount
ORDER BY
    percentage_of_sales DESC;

-- Total pizza sold by pizza category

SELECT
    pizza_size, 
    SUM(CAST(total_price AS decimal(10, 2))) AS Total_sales, 
    ROUND(SUM(CAST(total_price AS decimal(10, 2))) * 100.0 / total_sales.total_amount, 2) AS percentage_of_sales
FROM 
    pizza_sales,
    (SELECT SUM(CAST(total_price AS decimal(10, 2))) AS total_amount FROM pizza_sales) AS total_sales
GROUP BY 
    pizza_size, 
    total_sales.total_amount
ORDER BY
    percentage_of_sales DESC;

-- Top five best sellers by Revenue, Total quantity and Total orders
-- By Revenue
SELECT TOP 5
    pizza_name, 
    SUM(CAST(total_price AS decimal(10, 2))) AS Total_sales, 
    ROUND(SUM(CAST(total_price AS decimal(10, 2))) * 100.0 / total_sales.total_amount, 2) AS percentage_of_sales
FROM 
    pizza_sales,
    (SELECT SUM(CAST(total_price AS decimal(10, 2))) AS total_amount FROM pizza_sales) AS total_sales
GROUP BY 
    pizza_name, 
    total_sales.total_amount
ORDER BY
    percentage_of_sales DESC;

-- By total quantity

SELECT TOP 5
    pizza_name, 
    SUM(CAST(quantity AS decimal(10, 2))) AS Total_quantity, 
    ROUND(SUM(CAST(quantity AS decimal(10, 2))) * 100.0 / total_quantity.total_count, 2) AS percentage_of_counts
FROM 
    pizza_sales,
    (SELECT SUM(CAST(quantity AS decimal(10, 2))) AS total_count FROM pizza_sales) AS total_quantity
GROUP BY 
    pizza_name, 
    total_quantity.total_count
ORDER BY
    percentage_of_counts DESC;

-- By Total order

SELECT TOP 5
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_order, 
    ROUND(COUNT(DISTINCT order_id) * 100.0 / total_orders.total_count, 2) AS percentage_of_counts
FROM 
    pizza_sales,
    (SELECT COUNT(DISTINCT order_id) AS total_count FROM pizza_sales) AS total_orders
GROUP BY 
    pizza_name, 
    total_orders.total_count
ORDER BY
    percentage_of_counts DESC;

-- Buttom five sellers by Revenue, Total quantity and Total orders

-- By Revenue
SELECT TOP 5
    pizza_name, 
    SUM(CAST(total_price AS decimal(10, 2))) AS Total_sales, 
    ROUND(SUM(CAST(total_price AS decimal(10, 2))) * 100.0 / total_sales.total_amount, 2) AS percentage_of_sales
FROM 
    pizza_sales,
    (SELECT SUM(CAST(total_price AS decimal(10, 2))) AS total_amount FROM pizza_sales) AS total_sales
GROUP BY 
    pizza_name, 
    total_sales.total_amount
ORDER BY
    percentage_of_sales ASC;

-- By total quantity

SELECT TOP 5
    pizza_name, 
    SUM(CAST(quantity AS decimal(10, 2))) AS Total_quantity, 
    ROUND(SUM(CAST(quantity AS decimal(10, 2))) * 100.0 / total_quantity.total_count, 2) AS percentage_of_counts
FROM 
    pizza_sales,
    (SELECT SUM(CAST(quantity AS decimal(10, 2))) AS total_count FROM pizza_sales) AS total_quantity
GROUP BY 
    pizza_name, 
    total_quantity.total_count
ORDER BY
    percentage_of_counts ASC;

-- By Total order

SELECT TOP 5
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_order, 
    ROUND(COUNT(DISTINCT order_id) * 100.0 / total_orders.total_count, 2) AS percentage_of_counts
FROM 
    pizza_sales,
    (SELECT COUNT(DISTINCT order_id) AS total_count FROM pizza_sales) AS total_orders
GROUP BY 
    pizza_name, 
    total_orders.total_count
ORDER BY
    percentage_of_counts ASC;


-- 

