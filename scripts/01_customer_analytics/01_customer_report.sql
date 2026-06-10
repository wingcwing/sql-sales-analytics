/*
==============================================================================
Customer Report
==============================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
==============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS 
WITH basic_info AS (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
SELECT 
	fs.order_number,
	fs.product_key,
	fs.order_date,
	fs.sales_amount,
	fs.quantity,
	dc.customer_key,
	dc.customer_id,
	CONCAT (dc.first_name, ' ', dc.last_name) AS name,
	dc.country,
	DATEDIFF(YEAR, dc.birthday, GETDATE()) AS age,
	dc.gender
FROM gold.fact_sales fs LEFT JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
WHERE order_date IS NOT NULL
) , customer_aggregation AS (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
SELECT 
	customer_key,
	customer_id,
	name,
	country,
	age,
	gender,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH,MIN (order_date),MAX(order_date)) AS lifespan
FROM basic_info
GROUP BY 
	customer_key,
	customer_id,
	name,
	country,
	age,
	gender)
SELECT 
	customer_key,
	customer_id,
	name, 
	country,
	gender,
	age, 
	CASE 
	 WHEN age >= 50 THEN '50 and Above'
	 WHEN age >= 40 THEN '40-49'
	 WHEN age >= 30 THEN '30-39'
	 WHEN age >= 20 THEN '20-29'
	 ELSE 'Below 20'
	END AS age_group,
	CASE WHEN lifespan < 12 THEN 'New'
         WHEN total_sales > 5000 THEN 'VIP'
         ELSE 'Regular'
	END AS customer_segment,
	total_sales,
	total_orders,
	total_quantity,
	total_products,
	lifespan,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
	--average order value
	CAST(total_sales * 1.0 / NULLIF(total_orders,0) AS DECIMAL(10,2)) AS avg_order_value,
	--average monthly spend
	CAST(CASE WHEN lifespan = 0 THEN total_sales
			  ELSE total_sales * 1.0 / lifespan
		 END AS DECIMAL(10,2))
		 AS avg_monthly_spend
FROM customer_aggregation
GO

SELECT * FROM gold.report_customers