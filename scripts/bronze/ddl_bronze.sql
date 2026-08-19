/*
=========================================================================================
DDL Script: Create Bronze Tables
=========================================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
Run this script to redefine the DDL structure of 'bronze' Tables
=========================================================================================
*/

--CREATE CRM TABLES
--Table 1: create bronze.crm_cust_info table
--'U' in this command represents a User Table
IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info
(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gender NVARCHAR(50),
cst_create_date  DATE
);
GO

--Table 2:create bronze.crm_prd_info table
IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info
(
prd_id INT,
prd_key NVARCHAR(50),
prd_name NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_date DATETIME,
prd_end_date DATETIME
);
GO

--Table 3:create bronze.crm_sales_info table
IF OBJECT_ID ('bronze.crm_sales_info','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_info;
GO

CREATE TABLE bronze.crm_sales_info
(
sls_ord_num	NVARCHAR(50),
sls_prd_key	NVARCHAR(50),
sls_cust_id	INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,	
sls_quantity INT,	
sls_price INT
);
GO

--CREATE ERP TABLES

--Table 4:create bronze.erp_cust_az12 table
IF OBJECT_ID ('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
GO

CREATE  TABLE bronze.erp_cust_az12
(
cust_id NVARCHAR(50),
b_date DATE,
gender NVARCHAR(50)
);
GO

--Table 5:create bronze.erp_loc_info table
IF OBJECT_ID ('bronze.erp_loc_info','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_info;
GO

CREATE TABLE bronze.erp_loc_info
(
cust_id NVARCHAR(50),
country NVARCHAR(50)
);
GO

--Table 6:create bronze.erp_prod_cat_info table
IF OBJECT_ID ('bronze.erp_prod_cat_info','U') IS NOT NULL
	DROP TABLE bronze.erp_prod_cat_info;
GO

CREATE TABLE bronze.erp_prod_cat_info
(
prod_id NVARCHAR(50),
category NVARCHAR(50),
subcategory NVARCHAR(50),
maintenance NVARCHAR(50),
);
GO
