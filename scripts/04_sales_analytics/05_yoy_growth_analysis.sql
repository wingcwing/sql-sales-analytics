/*===========================================================================
Year-over-Year (YoY) Growth Analysis
===========================================================================

Purpose:
    Analyze year-over-year growth of yearly sales revenue.

Business Questions:
    1. How does annual sales revenue change compared to the previous year?
===========================================================================*/

-- 1. YoY Growth of yearly sales revenue
WITH yearly_sales AS (
SELECT 
    YEAR (order_date) AS current_year,
    SUM (sales_amount) AS current_year_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR (order_date)
)
, yearly_growth AS (
SELECT  
    current_year, 
    current_year_sales,
    LAG(current_year_sales) OVER(ORDER BY current_year) AS previous_year_sales
FROM yearly_sales
)
SELECT 
    current_year, 
    current_year_sales,
    previous_year_sales, 
    CAST((current_year_sales - previous_year_sales) * 100.0 / NULLIF(previous_year_sales,0) AS decimal(10,2)) AS yoy_growth_pct
FROM yearly_growth
ORDER BY current_year;