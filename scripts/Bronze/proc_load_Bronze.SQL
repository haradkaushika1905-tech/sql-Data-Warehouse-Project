--LOADING OF DATA VIA BULK Method
/*SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'crm_cust_info'
USE CTRL+SHIFT+C FOR COPYING PATH
**DROP TABLE*** — completely deletes the table itself (structure and all). 
After this, the table doesn't exist anymore at all — no columns, no rows, nothing. 
You use this when you're about to recreate the table, possibly with a different structure (like when we just changed cst_key from 
VARCHAR(50) to VARCHAR(100)).
***TRUNCATE TABLE*** — keeps the table structure exactly as-is, just empties out all the rows/data inside it.
The table still exists afterward, same columns, same data types — just zero rows. 
You use this when the table structure is already correct and you just want to reload fresh data into it.(WITHOUT TRUNCATE COLUMN WILL BE DOUBLE)
give duration as it can help uh to understand how much time it takes place n also*/
--STORE THE PROCEDURE

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
 DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
 BEGIN TRY

PRINT'===================================================================================================================================='
PRINT'LOADING BRONZE LAYER'
PRINT'===================================================================================================================================='

PRINT '-----------------------------------------------------------------------------------------------------------------------------------'
PRINT'LOADING crm TABLES'
PRINT '-----------------------------------------------------------------------------------------------------------------------------------'

SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.crm_cust_info <<'
TRUNCATE TABLE bronze.crm_cust_info;

PRINT'>> INSERTING TABLE:bronze.crm_cust_info <<'
BULK INSERT bronze.crm_cust_info FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT'>>Load Duration:'+  CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) +' seconds';
PRINT'>>============='


SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.crm_prd_info <<'
TRUNCATE TABLE bronze.crm_prd_info;

PRINT'>> INSERTING TABLE:bronze.crm_prd_info <<'
BULK INSERT bronze.crm_prd_info FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT'>>Load Duration:'+  CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) +' seconds';
PRINT'>>============='




SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.crm_prd_info <<'
TRUNCATE TABLE bronze.crm_sales_details;

PRINT'>> INSERTING TABLE:bronze.crm_sales_details <<'
BULK INSERT bronze.crm_sales_details FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT'>>Load Duration:'+  CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) +' seconds';
PRINT'>>============='




SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.erm_cust_az12 <<'
TRUNCATE TABLE bronze.erm_cust_az12;

PRINT'>> INSERTING TABLE:bronze.erm_cust_az12 <<'
BULK INSERT bronze.erm_cust_az12 FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>>Load Duration:' +  CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) +' seconds';
PRINT'>>============='




SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.erm_loc_a101 <<'
TRUNCATE TABLE bronze.erm_loc_a101;

PRINT'>> INSERTING TABLE:bronze.erm_loc_a101 <<'
BULK INSERT bronze.erm_loc_a101 FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
PRINT'>>============='


SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE:bronze.erm_px_cat_g1v2 <<'
TRUNCATE TABLE bronze.erm_px_cat_g1v2;

PRINT'>> INSERTING TABLE:bronze.erm_px_cat_g1v2 <<'
BULK INSERT bronze.erm_px_cat_g1v2 FROM "C:\sql data nalytics project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
SET @end_time = GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
PRINT'>>============='

SET @batch_end_time=GETDATE();
PRINT'=================================================================================================================================================='
PRINT'=================================================================================================================================================='
PRINT'LOADING BRONZE LAYER COMPLETED';
PRINT'TOTAL Load Duration:'+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS VARCHAR)+ 'seconds';
PRINT'=================================================================================================================================================='
PRINT'=================================================================================================================================================='

END TRY
BEGIN CATCH
 PRINT'================================================================================================================================================='
 PRINT 'ERROR OCCURED DURING LOADING'
 PRINT 'Error Message'+ ERROR_MESSAGE();
 PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS VARCHAR);
 PRINT'================================================================================================================================================='
END CATCH 
END
***--VALIDATE THE DATA LOADED***
