/*===========================================================================
Moving Average Analysis
===========================================================================

Purpose:
    Analyze smoothed sales revenue trends using moving averages over time.

Business Questions:
    1. What is the 3-month moving average of monthly sales revenue?

===========================================================================*/

-- 1. 3-month moving average of monthly sales revenue
WITH monthly_sales AS (
    SELECT 
        DATETRUNC(MONTH, order_date) AS order_date,
        SUM(sales_amount) AS current_monthly_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
), moving_avg AS (
    SELECT 
        order_date,
        current_monthly_sales,
        AVG(current_monthly_sales) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3_months
    FROM monthly_sales
)   SELECT 
        order_date, 
        current_monthly_sales,
        moving_avg_3_months,
        current_monthly_sales - moving_avg_3_months AS diff_from_moving_avg
    FROM moving_avg
    ORDER BY order_date;