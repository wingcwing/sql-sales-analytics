/*===========================================================================
One-Time vs Repeat Customers Analysis
===========================================================================

Purpose:
    Analyze whether customers make repeat purchases or only purchase once.

Business Questions:
    1. How many customers are one-time customers versus repeat customers?
    2. What percentage of customers are repeat customers?

===========================================================================*/
WITH customer_order AS(
SELECT 
    customer_key,
    COUNT(DISTINCT order_number) AS num_orders
FROM gold.fact_sales
GROUP BY customer_key)
, customer_types AS(
SELECT
    CASE WHEN num_orders > 1 THEN 'Repeat Customer'
    ELSE 'One-Time Customer'
    END AS customer_type
FROM customer_order
) SELECT 
    customer_type, 
    COUNT(customer_type) AS num_customers,
    CAST((COUNT(customer_type) * 100.0 / SUM(COUNT(customer_type)) OVER ()) AS DECIMAL(5,2)) AS type_pct
FROM customer_types
GROUP BY customer_type
