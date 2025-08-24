-- AdventureWorks2019 SQL Examples - Advanced DDL
-- Author: Negar Kohnesal
-- Description: Sample SQL queries for altering and dropping tables/columns

----------------------------------------------------------
-- Example 1: ALTER TABLE - Add a column
----------------------------------------------------------
ALTER TABLE Person.Person
ADD MiddleName1 VARCHAR(50);

----------------------------------------------------------
-- Example 2: ALTER TABLE - Modify column type
----------------------------------------------------------
ALTER TABLE Person.Person
ALTER COLUMN MiddleName1 NVARCHAR(100);

----------------------------------------------------------
-- Example 3: ALTER TABLE - Drop a column
----------------------------------------------------------
ALTER TABLE Person.Person
DROP COLUMN MiddleName1;

----------------------------------------------------------
-- Example 4: DROP TABLE
-- Uncomment carefully to drop a test table
----------------------------------------------------------
-- DROP TABLE TestTable;
