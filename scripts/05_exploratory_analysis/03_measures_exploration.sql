-- PART II: Measures Exploration
/*	Find the total Sales
	Find how many items are sold
	Find the average selling price
	Find the total number of Orders
*/
SELECT 
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_sold_items,
	AVG(price) AS avg_price,
	COUNT(DISTINCT(order_number)) AS total_orders
FROM gold.fact_sales

--	Find the total number of customers
SELECT COUNT (customer_key) AS total_customer FROM gold.dim_customers

-- 	Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT (customer_key)) AS total_customer_orders FROM gold.fact_sales

--	Find the total number of products
SELECT COUNT(product_key) AS total_products FROM gold.dim_products

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Sold Items' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Num Orders' AS measure_name, COUNT(DISTINCT(order_number)) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Num Customers' AS measure_name, COUNT (customer_key) AS measure_value FROM gold.dim_customers
UNION ALL
SELECT 'Total Num Products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.dim_products