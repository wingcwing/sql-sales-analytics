/*===========================================================================
Country Analysis
===========================================================================

Purpose:
    Analyze sales performance and customer distribution across customer countries.

Business Questions:
    1. Which customer countries generate the most revenue?
    2. How are sold items distributed across customer countries?
    3. Where is the customer base located?

===========================================================================*/

-- 1. Revenue contribution by customer country
SELECT 
	dc.country AS country,
	SUM(fs.sales_amount) AS revenue,
	CAST(SUM(fs.sales_amount) * 100.0 / SUM(SUM(fs.sales_amount)) OVER() AS DECIMAL(10,2)) AS revenue_pct
FROM gold.fact_sales fs LEFT JOIN gold.dim_customers dc
ON dc.customer_key = fs.customer_key
GROUP BY dc.country
ORDER BY revenue_pct DESC

-- 2. Sold items distribution by customer country
SELECT 
	dc.country AS country,
	SUM(fs.quantity) AS number_sold_items,
	CAST(SUM(fs.quantity) * 100.0 / SUM(SUM(fs.quantity)) OVER() AS DECIMAL(10,2)) AS sold_items_pct
FROM gold.fact_sales fs  
LEFT JOIN gold.dim_customers dc 
ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY sold_items_pct DESC

-- 3. Customer distribution by country
SELECT 
	country, 
	COUNT(customer_key) AS num_customers,
	CAST(COUNT(customer_key) * 100.0 / SUM(COUNT(customer_key) ) OVER() AS DECIMAL(10,2)) AS  customer_pct
FROM gold.dim_customers
GROUP BY country
ORDER BY num_customers DESC