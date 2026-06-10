/*===========================================================================
Top Product Analysis
===========================================================================

Purpose:
    Identify the top 5 products that generate the highest revenue.

Business Questions:
    1. Which 5 products generate the highest revenue?

===========================================================================*/

-- Method 1: Using TOP 5
SELECT TOP 5
	fs.product_key AS product_key,
	dp.product_name AS product_name,
	SUM (fs.sales_amount) AS revenue
FROM gold.fact_sales fs 
LEFT JOIN gold.dim_products dp 
ON fs.product_key = dp.product_key
GROUP BY fs.product_key, dp.product_name
ORDER BY revenue DESC

-- Method 2: Using ROW_NUMBER()
SELECT * FROM (
SELECT
	fs.product_key AS product_key,
	dp.product_name AS product_name,
	SUM (fs.sales_amount) AS revenue,
	ROW_NUMBER() OVER(ORDER BY SUM (fs.sales_amount) DESC) AS ranking_sales
FROM gold.fact_sales fs 
LEFT JOIN gold.dim_products dp 
ON fs.product_key = dp.product_key
GROUP BY fs.product_key, dp.product_name ) t
WHERE ranking_sales <= 5