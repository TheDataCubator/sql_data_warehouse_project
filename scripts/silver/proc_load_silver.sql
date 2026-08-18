/*
==========================================================
Stored Procedure: Load Silver Layer (Bronze => Silver)
==========================================================
Script Purpose:
  This stored procedure performs the ETL (Extract, Transform, Load) process to populate the 'silver' schema tables from the 'bronze' schema.
Actions Performed:
  -Truncates Silver Tables.
  -Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC Silver.load_silver;
===========================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	BEGIN TRY
		DECLARE @start_time DATETIME, @end_time DATETIME;
		PRINT '============================================';
		PRINT 'Loading Silver Layer';
		PRINT '============================================';
	
	
		--added title in result to show the tables were from CRM
		PRINT '--------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------';

			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.crm_cust_info';
			TRUNCATE TABLE silver.crm_cust_info;
			PRINT '>> Inserting Data Into: silver.crm_cust_info';
			--insert data into silver.crm_cust_info
			INSERT INTO silver.crm_cust_info
			(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gender,
			cst_create_date
			)

			SELECT 
			cst_id,
			cst_key,
			TRIM(cst_firstname) AS cst_firstname,
			TRIM(cst_lastname) AS cst_lastname,
			CASE
				WHEN UPPER(TRIM(cst_marital_status))='M'THEN 'Married'
				WHEN UPPER(TRIM(cst_marital_status))='S'THEN 'Single'
				ELSE 'n/a'
			END cst_marital_status,
			CASE
				WHEN UPPER(TRIM(cst_gender))='M' THEN 'Male'
				WHEN UPPER(TRIM(cst_gender))='F' THEN 'Female'
				ELSE 'n/a'
			END cst_gender,
			cst_create_date
			FROM 
			(
			SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
			FROM bronze.crm_cust_info WHERE cst_id IS NOT NULL
			)t
			WHERE flag_last=1;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';

			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.crm_prd_info';
			TRUNCATE TABLE silver.crm_prd_info;
			PRINT '>> Inserting Data Into: silver.crm_prd_info';
			--insert data into silver.crm_prd_info

			INSERT INTO silver.crm_prd_info
			(
			prd_id,
			cat_id,
			prd_key,
			prd_name,
			prd_cost,
			prd_line,
			prd_start_date,
			prd_end_date
			)
			SELECT
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
			SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
			prd_name,
			--changed NULL to 0
			ISNULL(prd_cost,0) AS prd_cost,
			CASE
				WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
				WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
				WHEN UPPER(TRIM(prd_line))='S' THEN 'Other Sales'
				WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
				ELSE 'n/a'
			END prd_line,
			CAST(prd_start_date AS DATE) AS prd_start_date,
			CAST(LEAD(prd_start_date) OVER(PARTITION BY prd_key ORDER BY prd_start_date)-1 AS DATE) AS prd_end_date
			FROM bronze.crm_prd_info;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';

			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.crm_sales_info';
			TRUNCATE TABLE silver.crm_sales_info;
			PRINT '>> Inserting Data Into: silver.crm_sales_info';
			--insert data into silver.crm_sales_info

			INSERT INTO silver.crm_sales_info
			(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,	
			sls_quantity,	
			sls_price
			)

			SELECT
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE
				WHEN sls_order_dt=0 OR LEN(sls_order_dt) != 8 THEN NULL
				--change to VARCHAR to DATE
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
			END sls_order_dt,
			--change to VARCHAR to DATE
			CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) AS sls_ship_dt,
			--change to VARCHAR to DATE
			CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) AS sls_due_dt,
			CASE
				WHEN sls_sales IS NULL
				OR sls_sales <= 0
				OR sls_sales != sls_quantity * ABS(sls_price)
				THEN ABS(sls_price)*sls_quantity
				ELSE sls_sales
			END AS sls_sales,
			sls_quantity,
			CASE 
				WHEN sls_price IS NULL 
				OR sls_price <=0
				THEN sls_sales/NULLIF(sls_quantity,0)
				ELSE sls_price
			END AS sls_price
			FROM bronze.crm_sales_info;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';

			--added title in result to show the tables were from ERP
			PRINT '--------------------------------------------';
			PRINT 'Loading ERP Tables';
			PRINT '--------------------------------------------';

			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.erp_cust_az12';
			TRUNCATE TABLE silver.erp_cust_az12;
			PRINT '>> Inserting Data Into: silver.erp_cust_az12';
			--insert data into silver.erp_cust_az12

			INSERT INTO silver.erp_cust_az12
			(
			cust_id,
			b_date,
			gender
			)

			SELECT
			CASE
				WHEN cust_id LIKE 'NAS%' THEN SUBSTRING(cust_id,4,10)
				ELSE cust_id
			END cust_id,
			CASE
				WHEN b_date > GETDATE() THEN NULL
				ELSE b_date
			END b_date,
			CASE
				WHEN UPPER(TRIM(gender)) IN ('M','MALE') THEN 'Male'
				WHEN UPPER(TRIM(gender)) IN ('F','FEMALE') THEN 'Female'
				ELSE 'n/a'
			END gender
			FROM bronze.erp_cust_az12;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';
	
			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.erp_loc_info';
			TRUNCATE TABLE silver.erp_loc_info;
			PRINT '>> Inserting Data Into: silver.erp_loc_info';
			--insert data into silver.erp_loc_info

			INSERT INTO silver.erp_loc_info
			(
			cust_id,
			country
			)
			SELECT 
			REPLACE(cust_id,'-','')cust_id,
			CASE
				WHEN TRIM(country) IN ('USA','US') THEN 'United States'
				WHEN TRIM(country)='DE' THEN 'Germany'
				WHEN TRIM(country)='' OR country IS NULL THEN 'n/a'
				ELSE TRIM(country)
			END	country 
			FROM bronze.erp_loc_info;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';

			SET @start_time=GETDATE();
			--truncate table before inserting data to avoid duplication
			PRINT '>> Truncating Table: silver.erp_prod_cat_info';
			TRUNCATE TABLE silver.erp_prod_cat_info;
			PRINT '>> Inserting Data Into: silver.erp_prod_cat_info';
			--insert data into silver.erp_prod_cat_info

			INSERT INTO silver.erp_prod_cat_info
			(
			prod_id,
			category,
			subcategory,
			maintenance)

			SELECT * FROM bronze.erp_prod_cat_info;
			SET @end_time=GETDATE();
			PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
			PRINT '>>  -----------------';
	END TRY
	BEGIN CATCH
		PRINT '==================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Érror Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==================================================';
	END CATCH
END
