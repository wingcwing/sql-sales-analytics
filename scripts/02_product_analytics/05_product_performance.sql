/*===========================================================================
Product Performance Analysis
===========================================================================

Purpose:
    Analyze yearly product sales performance by comparing each product's annual
    sales against its average sales and previous year's sales.

Business Questions:
    1. Which products perform above or below their average yearly sales?
    2. How does each product's yearly sales change compared to the previous year?
    3. Which products show increasing or decreasing sales trends over time?

===========================================================================*/

WITH yearly_product_sales AS (
SELECT
	fc.product_key,
	YEAR(fc.order_date) AS order_year,
	dp.product_name,
	SUM(fc.sales_amount) AS current_sales
FROM gold.fact_sales fc LEFT JOIN gold.dim_products dp
ON fc.product_key =  dp.product_key
WHERE fc.order_date IS NOT NULL
GROUP BY fc.product_key,dp.product_name,YEAR (fc.order_date))
SELECT 
	*,
	AVG (current_sales) OVER (PARTITION BY product_name) AS avg_sales,
	current_sales - AVG (current_sales) OVER (PARTITION BY product_name) AS diff_from_avg_sales,
	CASE WHEN current_sales - AVG (current_sales) OVER (PARTITION BY product_name)  > 0 THEN 'Above Average'
		 WHEN current_sales - AVG (current_sales) OVER (PARTITION BY product_name)  < 0 THEN 'Below Average'
			  ELSE 'Average'
		END avg_performance_status, 
	-- Year-over-year Analysis
	LAG(current_sales, 1, NULL) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,
	current_sales - LAG(current_sales, 1, NULL) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_from_previous_year, 
	CASE WHEN current_sales - LAG(current_sales, 1, NULL) OVER (PARTITION BY product_name ORDER BY order_year)  > 0 THEN 'Increase'
		 WHEN current_sales - LAG(current_sales, 1, NULL) OVER (PARTITION BY product_name ORDER BY order_year)  < 0 THEN 'Decrease'
			  ELSE 'Same'
		END previous_year_change
FROM yearly_product_sales
ORDER BY product_name, order_year