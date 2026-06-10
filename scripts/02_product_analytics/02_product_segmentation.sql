/*===========================================================================
Product Segmentation Analysis
===========================================================================

Purpose:
    Segment products into different cost ranges to understand the distribution
    of products across pricing tiers.

Business Questions:
    1. How many products fall into each cost range?
    2. Which cost range contains the most products?

===========================================================================*/

WITH product_segments AS(
SELECT 
	product_key,
	product_name,
	cost, 
	CASE WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 499 THEN '100-499'
		WHEN cost BETWEEN 500 AND 999 THEN '500-999'
		ELSE 'Above 1000'
	END AS cost_range -- Cost ranges are defined based on business-friendly pricing tiers
FROM gold.dim_products
)
SELECT 
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC