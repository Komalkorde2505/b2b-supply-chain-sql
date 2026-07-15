-- 1. Create Database and View Data
CREATE DATABASE supply_chain_db;
USE supply_chain_db;

-- 2. KPI: Total Revenue & Total Orders
SELECT 
    COUNT(order_id) AS total_orders,
    ROUND(SUM(sales_amount), 2) AS total_revenue,
    ROUND(AVG(sales_amount), 2) AS average_order_value
FROM orders;

-- 3. Monthly Revenue Trend (Using Window Function)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    SUM(sales_amount) AS monthly_revenue,
    LAG(SUM(sales_amount), 1) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS previous_month_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- 4. Top 5 Performing Product Categories
SELECT 
    product_category,
    SUM(sales_amount) AS category_revenue,
    COUNT(order_id) AS total_items_sold
FROM orders
GROUP BY product_category
ORDER BY category_revenue DESC
LIMIT 5;

-- 5. Delivery Status Analysis (Delayed vs On-Time)
SELECT 
    delivery_status,
    COUNT(order_id) AS total_orders,
    ROUND((COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders)), 2) AS percentage
FROM orders
GROUP BY delivery_status;
