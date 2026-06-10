-- Explore All objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_name = 'dim_customers'