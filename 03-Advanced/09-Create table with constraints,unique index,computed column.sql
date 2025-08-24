/*
================================================================================
Author:        Negar Kohnesal
Description:   Create dbo.Customer table with constraints, unique index, and 
               computed column for age.
Target DB:     SQL Server 2019 (AdventureWorks2019 compatible)
================================================================================
*/

USE AdventureWorks2019; 
GO

-- ===========================
-- Check if schema exists
-- ===========================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbo')
BEGIN
    EXEC('CREATE SCHEMA dbo');
END
GO

-- ===========================
-- Create Customer Table
-- ===========================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customer' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.Customer (
        Cus_ID INT IDENTITY(1,1) PRIMARY KEY,           -- Primary key
        Cus_name VARCHAR(50) NOT NULL,                  -- First Name
        Cus_family VARCHAR(50) NOT NULL,                -- Last Name
        Cus_phone VARCHAR(20) NOT NULL,                 -- Phone Number
        Cus_birthdate DATE NOT NULL                     -- Birth Date
    );
END
GO

-- ===========================
-- Create Unique Index on Phone
-- ===========================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Customer_Phone' AND object_id = OBJECT_ID('dbo.Customer'))
BEGIN
    CREATE UNIQUE INDEX IX_Customer_Phone
    ON dbo.Customer(Cus_phone);
END
GO

-- ===========================
-- Add Check Constraint for Birthdate
-- ===========================
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CHK_Customer_BirthDate')
BEGIN
    ALTER TABLE dbo.Customer
    ADD CONSTRAINT CHK_Customer_BirthDate
    CHECK (Cus_birthdate <= GETDATE());
END
GO

-- ===========================
-- Add Computed Column for Age
-- ===========================
IF COL_LENGTH('dbo.Customer', 'Cus_Age') IS NULL
BEGIN
    ALTER TABLE dbo.Customer
    ADD Cus_Age AS 
    (
        CASE 
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, Cus_birthdate, GETDATE()), Cus_birthdate) > GETDATE()
            THEN DATEDIFF(YEAR, Cus_birthdate, GETDATE()) - 1
            ELSE DATEDIFF(YEAR, Cus_birthdate, GETDATE())
        END
    );
END
GO

-- ===========================
-- Notes:
-- 1. Cus_Age is a computed column, cannot be persisted because GETDATE() is 
--    non-deterministic.
-- 2. Script is safe to run multiple times due to IF NOT EXISTS checks.
-- 3. Compatible with SQL Server 2019 and AdventureWorks2019 schema.
-- 4. For indexing Age, consider adding a trigger to update a stored Age column.
-- ===========================
