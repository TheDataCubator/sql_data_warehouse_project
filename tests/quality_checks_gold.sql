/*
======================================================
Quality Checks
======================================================
Script Purpose:
  This script performs quality checks to validate the integrity, consistency, and accuracy of the Gold Layer. These checks ensure:
  -uniqueness of surrogate keys in dimension tables.
  -Referential integrity between fact and dimension tables.
  -Validation of relationships in the data model for analytical purposes.

Usage Notes:
  -Run these checks after data loading into the Gold Layer.
  -Investigate and resolve any discrepancies found during the checks.
======================================================
*/

--===================================================
--QUALITY CHECKS FOR DIMENSION VIEWS
--===================================================
--View 1 Quality Checks: gold.dim_customers
--===================================================
--check for uniqueness of customer key in gold.dim_customers
--expectation: No result

SELECT customer_key, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*)>1;

--Data Standardization & Consistency
SELECT DISTINCT gender 
FROM gold.dim_customers;

--===================================================
--View 2 Quality Checks: gold.dim_products
--===================================================
--check for uniqueness of product key in gold.dim_products
--expectation: No result

SELECT product_key, COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*)>1;

--===================================================
--QUALITY CHECKS FOR FACT VIEW
--===================================================
--View 3 Quality Checks: gold.facts_sales
--===================================================
--Check the data model connectivity between fact and dimensions
SELECT * FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON c.customer_key=f.customer_key
	LEFT JOIN gold.dim_products p
	ON p.product_key=f.product_key
WHERE p.product_key IS NULL 
	OR c.customer_key IS NULL;
