/*===========================================================================
Customer Segmentation Analysis
===========================================================================

Purpose:
    Segment customers based on their spending behavior and relationship
    history to identify high-value, regular, and new customers.

Business Questions:
    1. How many customers belong to each customer segment?
    2. Which customers are considered VIP customers?
    3. What proportion of customers are new versus established customers?

Customer Segments:
    - VIP:
        Customers with at least 12 months of history and spending
        more than €5,000.

    - Regular:
        Customers with at least 12 months of history and spending
        €5,000 or less.

    - New:
        Customers with a lifespan of less than 12 months.

===========================================================================*/

WITH customer_spending AS (
    SELECT
        customer_key, 
        SUM(sales_amount) AS total_spending,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales
    GROUP BY customer_key
),
customer_segments AS (
    SELECT
        customer_key,
        CASE 
            WHEN lifespan < 12 THEN 'New'
            WHEN total_spending > 5000 THEN 'VIP'
            ELSE 'Regular'
        END AS customer_segment
    FROM customer_spending
)
SELECT
    customer_segment,
    COUNT(customer_key) AS number_customer,
    CAST((COUNT(customer_key) * 100.0 / SUM(COUNT(customer_key)) OVER()) AS DECIMAL(5,2)) AS segment_pct
FROM customer_segments
GROUP BY customer_segment
ORDER BY number_customer DESC;