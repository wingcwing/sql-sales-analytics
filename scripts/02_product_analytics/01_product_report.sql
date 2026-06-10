/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS 
WITH basic_info AS (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
SELECT 
	fs.order_number,
	fs.customer_key,
	dp.product_key,
	dp.product_id,
	dp.product_name,
	dp.category,
	dp.sub_category,
	dp.cost,
	fs.sales_amount, 
	fs.quantity,
	fs.order_date
FROM gold.fact_sales fs LEFT JOIN gold.dim_products dp
ON fs.product_key = dp.product_key 
WHERE order_date IS NOT NULL
)
, product_aggregation AS (SELECT 
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
	product_key,
	product_id,
	product_name,
	category,
	sub_category,
	cost,
	COUNT(DISTINCT(order_number)) AS total_orders,
	SUM(sales_amount) AS total_sales, 
	SUM(quantity) AS total_quantity,
	MAX(order_date) AS last_order_date,
	COUNT(DISTINCT(customer_key)) AS num_unique_customer,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM basic_info
GROUP BY product_key,
		product_id,
		product_name,
		category,
		sub_category,
		cost )
SELECT 	product_key,
	product_id,
	product_name,
	category,
	sub_category,
	cost,
	total_orders,
	total_sales,
	CASE WHEN total_sales > 50000 THEN 'High-Performer'
		 WHEN total_sales >= 10000 THEN 'Mid-Performer'
		 ELSE 'Low-Performer'
	END AS performance_segment,
	total_quantity,
	last_order_date,
	num_unique_customer,
	lifespan, 
	-- recency (months since last sale)
	DATEDIFF (MONTH, last_order_date, GETDATE()) AS recency,
    -- average order revenue (AOR)
	CAST((total_sales* 1.0 / NULLIF(total_orders,0)) AS decimal (10,2)) AS avg_order_revenue,
    -- average monthly revenue
	CAST((CASE WHEN lifespan = 0 THEN total_sales * 1.0
		 ELSE total_sales * 1.0 / lifespan
	END ) AS decimal (10,2)) AS avg_monthly_revenue
	FROM product_aggregation 
GO

SELECT * FROM gold.report_products