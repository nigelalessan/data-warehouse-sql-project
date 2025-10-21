/*

Bulk Insert CSV from files to the table
==================================================================

Script Purpose: 
	Script ini digunakan untuk melakukan bulk insert data dari data
	csv menuju tabel tujuan yang berada pada schema bronze dengna menggunakan stored procedure

Usage:
	EXEC bronze.load_bronze;
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_bulk DATETIME, @end_time_bulk DATETIME;
	BEGIN TRY
		SET @start_time_bulk = GETDATE()
		PRINT '************************************************************'
		PRINT '                   Loading Bronze Layer                     '
		PRINT '************************************************************'
		PRINT '............................................................'
		PRINT '............................................................'
		PRINT '============================================================'
		PRINT '                    Loading CRM Tables                      '
		PRINT '============================================================'

		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.crm_cust_info --'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '-- Inserting Bulk Data Into: bronze.crm_cust_info --'
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============================================================'

		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.crm_prd_info --'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '-- Inserting Bulk Data Into: bronze.crm_prd_info --'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============================================================'
		
		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.crm_sales_details --'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '-- Inserting Bulk Data Into: bronze.crm_sales_details --'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '............................................................'

		PRINT '============================================================'
		PRINT '                    Loading ERP Tables                      '
		PRINT '============================================================'

		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.erp_cust_az12 --'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '-- Inserting Bulk Data Into: bronze.erp_cust_az12 --'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============================================================'
		
		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.erp_loc_a101 --'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '-- Inserting Bulk Data Into: bronze.erp_loc_a101 --'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============================================================'

		SET @start_time = GETDATE();
		PRINT '-- Truncate Table: bronze.erp_px_cat_g1v2 --'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '-- Inserting Bulk Data Into: bronze.erp_px_cat_g1v2 --'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Misc\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============================================================'
		PRINT '************************************************************'
		PRINT '           Loading Bronze Layer is Completed                '
		PRINT '************************************************************'
		SET @end_time_bulk = GETDATE();
		PRINT 'Total Duration: ' + CAST(DATEDIFF(second, @start_time_bulk, @end_time_bulk) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED : ' + ERROR_MESSAGE();
		PRINT 'ERROR OCCURED : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR OCCURED : ' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END
