/*
=========================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=========================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  -Truncates the bronze tables before loading data.
  -Uses the 'BULK INSERT' command to load data from csv files to Bronze tables.

Parameters:
  None
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
=========================================================================================
*/

--save frequently used SQL code in stored procedure in database
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================================';

		--added title in result to show the tables were from CRM
		PRINT '--------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------';
		
		SET @start_time=GETDATE();
		--make table empty
		PRINT '>> Truncating Table:bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		--bulk insert data from file
		PRINT '>> Inserting Data Into:bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Inserting Data Into:bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.crm_sales_info';
		TRUNCATE TABLE bronze.crm_sales_info

		PRINT '>> Inserting Data Into:bronze.crm_sales_info';
		BULK INSERT bronze.crm_sales_info
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';

		--added title in result to show the tables were from ERP
		PRINT '--------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------';
	
		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting Data Into:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_loc_info';
		TRUNCATE TABLE bronze.erp_loc_info

		PRINT '>> Inserting Data Into:bronze.erp_loc_info';
		BULK INSERT bronze.erp_loc_info
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_prod_cat_info';
		TRUNCATE TABLE bronze.erp_prod_cat_info

		PRINT '>> Inserting Data Into:bronze.erp_prod_cat_info';
		BULK INSERT bronze.erp_prod_cat_info
		FROM 'C:\Users\musme\Downloads\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'second';
		PRINT '>>  -----------------';
	END TRY
	--the Catch will be executed only if the SQL failed to run the TRY
	--to define the SQL what to do if there is an error
	BEGIN CATCH
		PRINT '==================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Érror Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==================================================';
	END CATCH
END
