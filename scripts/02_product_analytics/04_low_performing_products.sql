/*===========================================================================
Low-Performing Product Analysis
===========================================================================

Purpose:
	Identify the 5 worst-performing products that generate the lowest revenue.
Business Questions:
    1.  Which 5 products generate the lowest revenue?

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
ORDER BY revenue

-- Method 2: Using DENSE_RANK() to include products with the same revenue ranking
SELECT * FROM (
SELECT 
	fs.product_key AS product_key,
	dp.product_name AS product_name,
	SUM (fs.sales_amount) AS revenue, 
	DENSE_RANK() OVER (ORDER BY SUM(fs.sales_amount)) AS lowest_revenue_rank
FROM gold.fact_sales fs 
LEFT JOIN gold.dim_products dp 
ON fs.product_key = dp.product_key
GROUP BY fs.product_key, dp.product_name) t
WHERE lowest_revenue_rank  <= 5