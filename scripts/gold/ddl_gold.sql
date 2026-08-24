/*
==============================================================
DDL Script: Create Gold Views
==============================================================
Script Purpose:
  This script creates views for the Gold Layer in the date warehouse.
  The Gold Layer represents the final dimension and fact tables (Star Schema)

  Each view performs transformations and combines data from the Silver Layer to produce a clean, enriched, and business-ready dataset.

usage:
  -These views can be queried directly for analytics and reporting.
==============================================================
*/


--===================================================
--CREATING DIMENSION VIEWS
--===================================================
--View 1:create gold.dim_customers
--===================================================
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	li.country AS country,
	ci.cst_marital_status AS marital_status,
	CASE
		WHEN ci.cst_gender != 'n/a' THEN ci.cst_gender
		--replacing NULL with n/a
		ELSE COALESCE(ca.gender,'n/a')
	END AS gender,
	ca.b_date AS birth_date,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key=ca.cust_id
LEFT JOIN silver.erp_loc_info li
ON ci.cst_key=li.cust_id;

--===================================================
--View 2:creating gold.dim_products
--===================================================
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY pi.prd_start_date,pi.prd_key) AS product_key,
	pi.prd_id AS product_id,
	pi.prd_key AS product_number,
	pi.prd_name AS product_name,
	pi.cat_id AS category_id,
	pc.category AS category,
	pc.subcategory AS subcategory,
	pc.maintenance AS maintenance,
	pi.prd_cost AS cost,
	pi.prd_line AS product_line,
	pi.prd_start_date AS start_date
FROM silver.crm_prd_info pi
LEFT JOIN silver.erp_prod_cat_info pc
ON pi.cat_id=pc.prod_id
WHERE prd_end_date IS NULL;--Filter out all historical data(filter to find only the current product)

--===================================================
----CREATING FACT VIEW
--===================================================
--View 3:creating gold.facts_sales
--===================================================
CREATE VIEW gold.fact_sales AS
SELECT
	si.sls_ord_num AS order_number,
	pr.product_key,
	cu.customer_key,
	si.sls_order_dt AS order_date,
	si.sls_ship_dt AS shipping_date,
	si.sls_due_dt AS due_date,
	si.sls_sales AS sales_amount,
	si.sls_quantity AS quantity,
	si.sls_price AS price
FROM silver.crm_sales_info si
LEFT JOIN gold.dim_products pr
	ON si.sls_prd_key=pr.product_number
LEFT JOIN gold.dim_customers cu
	ON si.sls_cust_id=cu.customer_id;
