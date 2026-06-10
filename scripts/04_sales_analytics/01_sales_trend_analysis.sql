/*===========================================================================
Sales Trend Analysis
===========================================================================

Purpose:
    Analyze sales revenue trends across different time periods.

Business Questions:
	1. How does yearly sales revenue trend over time?
	2. How does monthly sales revenue trend over time?

===========================================================================*/

-- 1. Yearly Sales Trend - Method 1: Using YEAR()
SELECT 
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT(customer_key)) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR (order_date)
ORDER BY order_year 

-- 1. Yearly Sales Trend - Method 2: Using DATETRUNC
SELECT 
	DATETRUNC(YEAR, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT(customer_key)) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
ORDER BY order_date

-- 2. Montly Sales Trend - Method 1: Using MONTH()
SELECT 
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT(customer_key)) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR (order_date), MONTH(order_date)
ORDER BY order_year, order_month 

-- 2. Montly Sales Trend - Method 2: Using DATETRUNC
SELECT 
	DATETRUNC(MONTH, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT(customer_key)) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY order_date