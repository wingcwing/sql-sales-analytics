/*==================================================================================================
Customer Recency Analysis
===================================================================================================

Purpose:
Analyze customer activity status based on recency relative to the latest order date in the dataset.

Business Questions:
    1. Which customers have not purchased recently relative to the latest order date in the dataset?

Segments:
Active = last order within 6 months compared to the latest order date in the dataset 
Inactive = last order more than 6 months ago compared to the latest order date in the dataset 
Very Inactive = last order more than 12 months ago compared to the latest order date in the dataset 

==================================================================================================*/
WITH basic_info AS (
SELECT 
    fs.order_number,
    dc.customer_key, 
    dc.customer_id,
    CONCAT(dc.first_name, ' ' , dc.last_name) AS name, 
    fs.order_date, 
    MAX(fs.order_date) OVER() AS reference_date
FROM gold.fact_sales fs LEFT JOIN gold.dim_customers dc
ON fs.customer_key = dc.customer_key
)
, customer_aggregation AS (SELECT 
    customer_key, 
    customer_id, 
    name,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH,MAX(order_date),MAX(reference_date)) AS recency
FROM basic_info
GROUP BY     
    customer_key, 
    customer_id, 
    name,
    reference_date
)
SELECT
    customer_key, 
    customer_id,
    name, 
    last_order_date,
    recency,
    CASE WHEN recency > 12 THEN 'Very Inactive'
         WHEN recency > 6 THEN 'Inactive'
         ELSE 'Active'
    END 'recency_type'
FROM customer_aggregation