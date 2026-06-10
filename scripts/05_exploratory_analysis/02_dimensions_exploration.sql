-- Dimensions Exploration
-- E.g. All countries that customers come from
SELECT DISTINCT country FROM gold.dim_customers

--Explore all categories, sub category, product of the product
SELECT DISTINCT 
	category, 
	sub_category, 
	product_name FROM gold.dim_products
ORDER BY category,sub_category,product_name

-- Date Exploration
-- E.g Find the date of the first and last order
-- How many years of sales are availabe
SELECT 
	MIN (order_date) AS first_order_date,
	MAX (order_date) AS last_order_date,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- E.g Find the youngest and the older customer
SELECT
	MIN(birthday) AS olderest_birthday,
	DATEDIFF(year,MIN(birthday), GETDATE()) AS oldest_age,
	MAX(birthday) AS youngest_birthday,
	DATEDIFF(year,MAX(birthday), GETDATE()) AS youngest_age
FROM gold.dim_customers