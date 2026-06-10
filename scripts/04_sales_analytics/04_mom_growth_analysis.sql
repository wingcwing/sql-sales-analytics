/*===========================================================================
Month-over-Month (MoM) Growth Analysis
===========================================================================

Purpose:
    Analyze month-over-month growth of monthly sales revenue.

Business Questions:
    1. How does monthly sales revenue change compared to the previous month?

===========================================================================*/

-- 1. MoM Growth of monthly sales revenue
WITH monthly_sales AS (
SELECT 
    DATETRUNC (MONTH, order_date) AS current_month,
    SUM (sales_amount) AS current_month_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC (MONTH, order_date)
)
, monthly_growth AS (
SELECT  
    current_month, 
    current_month_sales,
    LAG(current_month_sales) OVER(ORDER BY current_month) AS previous_month_sales
FROM monthly_sales
)
SELECT 
    current_month, 
    current_month_sales,
    previous_month_sales, 
    CAST((current_month_sales - previous_month_sales) * 100.0 / NULLIF(previous_month_sales,0) AS decimal(10,2)) AS mom_growth_pct
FROM monthly_growth
ORDER BY current_month;
