-- Use the database
USE Pizza_DB;
GO
-- Drop the existing table if it exists
IF OBJECT_ID('pizza_sales_v2', 'U') IS NOT NULL
    DROP TABLE pizza_sales_v2;
GO

-- Create the new table with the correctly formatted dates
CREATE TABLE pizza_sales_v2 (
    order_id INT PRIMARY KEY,
    pizza_id INT,
    pizza_name_id VARCHAR(255),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(20),
    pizza_ingredients VARCHAR(100),
    pizza_name VARCHAR(255)
);
GO

-- Set the date format to DMY
SET DATEFORMAT DMY;
GO

-- Insert data into the new table, handling duplicates
;WITH CTE AS (
    SELECT 
        order_id,
        pizza_id,
        pizza_name_id,
        quantity,
        CONVERT(DATE, order_date, 103) AS order_date, -- 103 is the style code for 'dd/mm/yyyy'
        order_time,
        unit_price,
        total_price,
        pizza_size,
        pizza_category,
        pizza_ingredients,
        pizza_name,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY (SELECT NULL)) AS rn
    FROM 
        pizza_sales
)
INSERT INTO pizza_sales_v2 (
    order_id,
    pizza_id,
    pizza_name_id,
    quantity,
    order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name)
SELECT 
    order_id,
    pizza_id,
    pizza_name_id,
    quantity,
    order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
FROM CTE
WHERE rn = 1;
GO

-- Check the new table
SELECT * FROM pizza_sales_v2;
GO