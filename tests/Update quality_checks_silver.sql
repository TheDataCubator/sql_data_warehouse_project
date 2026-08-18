/*
=====================================================================================
Quality Checks
=====================================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy, and standardization across the 'silver' schemas. It includes checks for:
  - Null or duplicate primary keys
  - Unwanted spaces in string fields
  - Data standardization and consistency
  - Invalid date ranges  and orders
  - Data consistency between related fields

Usage notes:
  -Run these checks after data loading the Silver Layer.
  -Investigate and resolve any discrepancies found during the checks.
=====================================================================================
*/

--=====================================================
--DATA QUALITY CHECKS FOR CRM
--=====================================================
--Table 1:silver.crm_cust_info
--=====================================================
--check for Nulls or Duplicates in Primary Key
--expectation: No Results
SELECT 
	cst_id,
	COUNT(*) AS number_of_id
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id IS NULL;

--check for unwanted spaces for Silver Data
--expectation: No Results
SELECT 
	cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
	cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

--Data Standardization & Consistency
SELECT DISTINCT 
	cst_gender
FROM silver.crm_cust_info;

--=====================================================
--Table 2:silver.crm_prd_info
--=====================================================
--checks for Nulls or Duplicates in Primary Key
--expectation: No Results
SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id IS NULL;

--check for unwanted spaces
--expectation: No Results
SELECT 
	prd_name
FROM silver.crm_prd_info
WHERE prd_name!=TRIM(prd_name);

--check for NULLs or negative numbers
--expectation: No Results
SELECT 
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost<0 OR prd_cost is NULL

--data standardization & consistency
SELECT DISTINCT 
	prd_line
FROM silver.crm_prd_info;

--check for invalid date orders
SELECT * FROM silver.crm_prd_info
WHERE prd_end_date<prd_start_date;

--=====================================================
--Table 3:crm_sales_info
--=====================================================
--check for invalid date orders
SELECT * FROM silver.crm_sales_info
WHERE 
	sls_order_dt>sls_ship_dt 
	OR sls_order_dt>sls_due_dt;

--check data consistency: between sales,quantity and price
-->> sales:quantity*price
-->> values must not be NULL,zero or negative
SELECT DISTINCT
	sls_sales,
	sls_quantity,	
	sls_price
FROM silver.crm_sales_info
WHERE 
	sls_price*sls_quantity != sls_sales
	OR sls_sales IS NULL
	OR sls_quantity IS NULL
	OR sls_price IS NULL
	OR sls_sales <=0
	OR sls_quantity <= 0
	OR sls_price <= 0;

--=====================================================
--DATA QUALITY CHECKS FOR ERP
--=====================================================
--Tables 4:silver.erp_cust_az12
--=====================================================
--Identify out of range dates
SELECT DISTINCT
	b_date
FROM silver.erp_cust_az12
WHERE b_date<'1924-01-01' OR b_date>GETDATE();

--Data standardization and consistency
SELECT DISTINCT 
	gender
FROM silver.erp_cust_az12;

--=====================================================
--Table 5:silver.erp_loc_info
--=====================================================
--Data standardization and consistency
SELECT DISTINCT 
	country
FROM silver.erp_loc_info;

--=====================================================
--Table 6:silver.erp_prod_cat_info
--=====================================================
--check for unwanted spaces
SELECT * FROM silver.erp_prod_cat_info
WHERE category != TRIM(category)
OR subcategory != TRIM(subcategory)
OR maintenance != TRIM(maintenance);

--Data standardization and consistency
SELECT DISTINCT
	category
FROM silver.erp_prod_cat_info;

SELECT DISTINCT
	subcategory
FROM silver.erp_prod_cat_info;

SELECT DISTINCT
	maintenance
FROM silver.erp_prod_cat_info;

