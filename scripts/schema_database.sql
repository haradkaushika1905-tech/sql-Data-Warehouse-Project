/*
===============================================================================================================================================
Create Database and Schema
===============================================================================================================================================
Script - At first check or verify if the new database named 'DataWarehouse'exist already.If it exist then it is dropped and recreated.
Also the script sets three schemas within database - 'bronze','silver'and 'gold'.

**Caution**- running this script will permanently delete(drop) entire data present in existing 'DataWarehouse' database.
Proceed with caution and ensure uh have proper backups before running this script*/
-------------------------------------------------------------------------------------------------------------------------------------------------
Use master;
GO

--Drop & Create 'DataWarehouse'

IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWareHouse')
BEGIN
     ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
     DROP DATABASE DataWarehouse;
END;
GO

-- Create database 'DataWarehouse'

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
