/*===========================================================================
Running Total Analysis
===========================================================================

Purpose:
    Analyze cumulative monthly sales revenue within each year.

Business Questions:
	1. How does the running total of monthly sales evolve within each year?

===========================================================================*/

-- Calculate the total sales per month and the running total of sales over time
SELECT 
	order_date,
	total_sales,
	SUM (total_sales) OVER(PARTITION BY DATETRUNC(YEAR, order_date) ORDER BY order_date) AS running_total_sales
	FROM ( SELECT 
				DATETRUNC(MONTH, order_date) AS order_date,
				SUM (sales_amount) AS total_sales
			FROM gold.fact_sales
			WHERE order_date IS NOT NULL
			GROUP BY DATETRUNC(MONTH, order_date)) t 