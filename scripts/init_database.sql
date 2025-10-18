/*

Create Database and Schemas
===================================================================================================

Script:
	This script is used to create a database named 'DataWarehouse' and to create a schema using the 
	medallion architecture, which consists of 3 schemas: bronze, silver, and gold. The script first 
	executes a command to switch to the master database and then checks if a database with the name 
	'DataWarehouse' already exists. If it exists, the script will drop the database and then create 
	a new one, and the data within it will also be lost. If it doesn't exist, it will simply create 
	a new one. Subsequently, the script executes commands to create the schemas, namely bronze, 
	silver, and gold.
*/

-- Move to master --

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database if exists --
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO


-- Create Database -- 

CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- Create Medallion Schema --

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
