/*===========================================================================
Category Analysis
===========================================================================

Purpose:
    Analyze sales performance and sold item distribution across product categories
    and sub-categories.

Business Questions:
    1. Which product categories contribute the most to revenue?
	2. Which product categories and sub-categories contribute the most to revenue?
    3. How are sold items distributed across product categories and sub-categories?

===========================================================================*/

-- 1. Revenue contribution by product category 
SELECT 
	dp.category AS category,
	SUM(fs.sales_amount) AS revenue,
    CAST(SUM(fs.sales_amount) * 100.0 / SUM(SUM(fs.sales_amount)) OVER() AS DECIMAL(10,2)) AS revenue_pct
FROM gold.fact_sales fs LEFT JOIN gold.dim_products dp
ON dp.product_key = fs.product_key
GROUP BY dp.category 
ORDER BY revenue DESC

-- 2. Revenue contribution by product category and sub-category
SELECT 
	dp.category AS category,
    dp.sub_category AS sub_category,
	SUM(fs.sales_amount) AS revenue,
    CAST(SUM(fs.sales_amount) * 100.0 / SUM(SUM(fs.sales_amount)) OVER() AS DECIMAL(10,2)) AS revenue_pct
FROM gold.fact_sales fs LEFT JOIN gold.dim_products dp
ON dp.product_key = fs.product_key
GROUP BY dp.category, dp.sub_category 
ORDER BY revenue DESC

-- 3. Sold items distribution by product category and sub-category
SELECT 
	dp.category AS category,
	dp.sub_category AS sub_category,
	SUM(fs.quantity) AS number_sold_items,
	CAST(SUM(fs.quantity) * 100.0 / SUM(SUM(fs.quantity)) OVER() AS DECIMAL(10,2)) AS sold_items_pct
FROM gold.fact_sales fs  
LEFT JOIN gold.dim_products dp 
ON fs.product_key = dp.product_key
GROUP BY dp.category, dp.sub_category
ORDER BY sold_items_pct DESC

