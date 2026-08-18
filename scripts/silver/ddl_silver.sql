/*
===============================================================
DDL Script: Create Silver Layer
===============================================================
Script Purpose:
	This script creates tables in the 'silver' schema, dropping existing tables if they already exist.
	Run this script to re-defined the DDL structure of 'bronze' Tables
===============================================================
*/

--create Silver Layer table with 1 metadata

--CREATE CRM TABLE
--Table 1:create silver.crm_cust_info table
IF OBJECT_ID ('silver.crm_cust_info','U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info
(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gender NVARCHAR(50),
	cst_create_date  DATE,
--create 1 metadata column
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

--Table 2:create silver.crm_prd_info table
IF OBJECT_ID ('silver.crm_prd_info','U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info
(
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_name NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_date DATE,
	prd_end_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

--Table 3:create silver.crm_sales_info table
IF OBJECT_ID ('silver.crm_sales_info','U') IS NOT NULL
	DROP TABLE silver.crm_sales_info;
GO

CREATE TABLE silver.crm_sales_info
(
	sls_ord_num	NVARCHAR(50),
	sls_prd_key	NVARCHAR(50),
	sls_cust_id	INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,	
	sls_quantity INT,	
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

--CREATE ERP TABLE
	
--Table 4:create silver.erp_cust_az12 table
IF OBJECT_ID ('silver.erp_cust_az12','U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
GO

CREATE  TABLE silver.erp_cust_az12
(
	cust_id NVARCHAR(50),
	b_date DATE,
	gender NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

--Table 5:create silver.erp_loc_info table
IF OBJECT_ID ('silver.erp_loc_info','U') IS NOT NULL
	DROP TABLE silver.erp_loc_info;
GO

CREATE TABLE silver.erp_loc_info
(
	cust_id NVARCHAR(50),
	country NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

--Table 6:create silver.erp_prod_cat_info table
IF OBJECT_ID ('silver.erp_prod_cat_info','U') IS NOT NULL
	DROP TABLE silver.erp_prod_cat_info;
GO

CREATE TABLE silver.erp_prod_cat_info
(
	prod_id NVARCHAR(50),
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
