/*--Create Tables
Remember to give convention name example in bronze rules- <source.system>_<entity>,here source system is the csv file name(crm)
and entity is customer info.In such way create DDL for every File*/

/* if uh try to edit n run the sql will say the table already exist so we have to use tsql logic.
why?
1. IF EXISTS (SELECT 1 FROM sys.databases WHERE name = '...')
This checks the sys.databases system table — which only lists databases.
It's asking: "does a database with this name exist at the server level?"This only works for checking databases, not tables.

2. IF OBJECT_ID('bronze.crm_customer_info', 'U') IS NOT NULL
OBJECT_ID() is a different, more general-purpose function — it checks whether any object (table, view, procedure, etc.) exists inside the current database. 
The 'U' here specifically means "User Table" (there are other codes like 'V' for view, 'P' for procedure).
It's asking: "does a table called bronze.crm_customer_info exist inside whichever database I'm currently using?"
Databases live at the server level (SQL Server manages a whole list of them in sys.databases), while tables live inside a specific database. 
So checking "does this database exist" and "does this table exist" are fundamentally different questions, checked in different places.
Hence two different techniques.*/

USE DataWarehouse

IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
   DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info(
cst_id INT,
cst_key VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_marital_status VARCHAR(50),
cst_gndr VARCHAR(50),
cst_create_date DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
   DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info(
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),	
prd_start_dt DATETIME,
prd_end_dt DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
 DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details(
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id	INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);
GO

IF OBJECT_ID('bronze.erm_cust_az12','U') IS NOT NULL
   DROP TABLE bronze.erm_cust_az12;
GO

CREATE TABLE bronze.erm_cust_az12(
CID VARCHAR(50),
BDATE DATE,
GEN VARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erm_loc_a101','U') IS NOT NULL 
   DROP TABLE bronze.erm_loc_a101;
GO

CREATE TABLE bronze.erm_loc_a101(
CID VARCHAR(50),
CNTRY VARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erm_px_cat_g1v2','U') IS NOT NULL
DROP TABLE bronze.erm_px_cat_g1v2;
GO

Create TABLE bronze.erm_px_cat_g1v2(
ID VARCHAR(50),
CAT VARCHAR(50),
SUBCAT VARCHAR(50),
MAINTENANCE VARCHAR(50)
);
GO



