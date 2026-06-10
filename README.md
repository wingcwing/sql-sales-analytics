# 📊 SQL Sales Analytics Project

## 🎯 Project Overview

This project focuses on business analytics using SQL to uncover insights from sales, customer, product, and market data.

Built on top of the Gold Layer views created in my [SQL Data Warehouse Project](https://github.com/wingcwing/sql-data-warehouse), this repository demonstrates how SQL can be used to answer real-world business questions through customer segmentation, product performance analysis, market analysis, and sales trend reporting.

The project showcases both foundational and advanced SQL techniques commonly used by Data Analysts and Business Intelligence professionals.

---

## 📦 Data Source

This project uses the Gold Layer views generated from my [SQL Data Warehouse Project](https://github.com/wingcwing/sql-data-warehouse).

The analytics are built on top of the following business-ready views:

* `gold.fact_sales`
* `gold.dim_customers`
* `gold.dim_products`

Data cleansing, transformation, and dimensional modeling were completed in the Data Warehouse project before performing analytics.

---

## 📁 Repository Structure

```text
sql-sales-analytics/
│
├── 01_customer_analytics/
│   ├── 01_customer_report.sql
│   ├── 02_customer_segmentation.sql
│   ├── 03_one_time_vs_repeat_customers.sql
│   ├── 04_customer_recency_analysis.sql
│   └── 05_top_customers.sql
│
├── 02_product_analytics/
│   ├── 01_product_report.sql
│   ├── 02_product_segmentation.sql
│   ├── 03_top_products.sql
│   ├── 04_low_performing_products.sql
│   └── 05_product_performance.sql
│
├── 03_market_analytics/
│   ├── 01_country_analysis.sql
│   └── 02_category_analysis.sql
│
├── 04_sales_analytics/
│   ├── 01_sales_trend_analysis.sql
│   ├── 02_running_total_analysis.sql
│   ├── 03_moving_average_analysis.sql
│   ├── 04_month_over_month_growth.sql
│   └── 05_year_over_year_growth.sql
│
└── 05_exploratory_analysis/
    ├── 01_database_exploration.sql
    ├── 02_dimensions_exploration.sql
    └── 03_measures_exploration.sql
```

---

## 🔍 Analytics Modules

### 👥 Customer Analytics

Analyze customer behavior and purchasing patterns.

Key analyses include:

* Customer Segmentation (VIP, Regular, New)
* Customer Recency Analysis
* One-Time vs Repeat Customer Analysis
* Top Customers by Revenue
* Customer Performance Reporting

Business questions answered:

* Which customers generate the most revenue?
* Are customers returning?
* How many customers belong to each segment?
* Which customers have become inactive?

---

### 📦 Product Analytics

Analyze product performance and revenue contribution.

Key analyses include:

* Product Performance Report
* Product Segmentation by Cost Range
* Top Performing Products
* Low Performing Products
* Year-over-Year Product Performance Analysis

Business questions answered:

* Which products generate the most revenue?
* Which products are underperforming?
* How are products distributed across cost ranges?
* How does product performance change over time?

---

### 🌍 Market Analytics

Analyze sales performance across countries and product categories.

Key analyses include:

* Revenue by Country
* Customer Distribution by Country
* Revenue Contribution by Category
* Sold Item Distribution Analysis

Business questions answered:

* Which countries generate the most revenue?
* Where are customers located?
* Which product categories drive business growth?
* How are sales distributed across markets?

---

### 📈 Sales Analytics

Analyze revenue trends and business growth over time.

Key analyses include:

* Monthly and Yearly Sales Trends
* Running Total Analysis
* Moving Average Analysis
* Month-over-Month (MoM) Growth
* Year-over-Year (YoY) Growth

Business questions answered:

* How does revenue change over time?
* What is the overall sales trend?
* How fast is revenue growing?
* Are there significant increases or declines in sales performance?

---

## 🛠️ SQL Techniques Used

### Aggregation Functions

```sql
SUM()
AVG()
COUNT()
MIN()
MAX()
```

### Window Functions

```sql
ROW_NUMBER()
DENSE_RANK()
LAG()
LEAD()
SUM() OVER()
AVG() OVER()
```

### Common Table Expressions (CTEs)

```sql
WITH ...
```

### Conditional Logic

```sql
CASE WHEN
```

### Time-Series Analysis

```sql
DATETRUNC()
YEAR()
MONTH()
DATEDIFF()
```

### Business KPI Calculations

* Revenue Contribution %
* Customer Segmentation
* Product Segmentation
* Running Totals
* Moving Averages
* MoM Growth %
* YoY Growth %

---

## 📌 Key Business Questions

This project helps answer questions such as:

* Which customers contribute the most revenue?
* Which products are driving business performance?
* Which products are underperforming?
* Which countries and categories contribute most to sales?
* How are customers segmented by spending behavior?
* How do sales trends evolve over time?
* What are the month-over-month and year-over-year growth rates?

---

## 🚀 Future Improvements

Potential future enhancements include:

* Customer Lifetime Value (CLV) Analysis
* Pareto (80/20) Revenue Analysis
* Customer Cohort Analysis
* Power BI Dashboard Integration
* Automated Reporting Pipelines

---

## 👨‍💻 About Me

Hello! I'm **Wing Wong**. I’m passionate about working with data! Let's connect!

---

## 📜 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.
