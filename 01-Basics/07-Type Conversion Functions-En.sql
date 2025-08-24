-- AdventureWorks2019 SQL Examples - Type Conversion Functions
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using type conversion functions in SQL Server

----------------------------------------------------------
-- Example 1: CAST
-- Convert integer to string
----------------------------------------------------------
SELECT CAST(123 AS VARCHAR(10)) AS CastExample;

-- Convert string to integer
SELECT CAST('456' AS INT) AS CastToInt;

-- Convert datetime to string
SELECT CAST(GETDATE() AS VARCHAR(20)) AS CastDate;

----------------------------------------------------------
-- Example 2: CONVERT
-- Convert integer to string
----------------------------------------------------------
SELECT CONVERT(VARCHAR(10), 789) AS ConvertExample;

-- Convert string to integer
SELECT CONVERT(INT, '321') AS ConvertToInt;

-- Convert datetime to formatted string
SELECT CONVERT(VARCHAR(10), GETDATE(), 23) AS ConvertDate; -- yyyy-mm-dd
SELECT CONVERT(VARCHAR(20), GETDATE(), 120) AS ConvertDateTime; -- yyyy-mm-dd hh:mi:ss

----------------------------------------------------------
-- Example 3: TRY_CAST
-- Returns NULL if conversion fails
----------------------------------------------------------
SELECT TRY_CAST('123' AS INT) AS TryCastValid;
SELECT TRY_CAST('ABC' AS INT) AS TryCastInvalid;

----------------------------------------------------------
-- Example 4: TRY_CONVERT
-- Returns NULL if conversion fails
----------------------------------------------------------
SELECT TRY_CONVERT(INT, '456') AS TryConvertValid;
SELECT TRY_CONVERT(INT, 'XYZ') AS TryConvertInvalid;

----------------------------------------------------------
-- Example 5: PARSE
-- Convert string to datetime or decimal with culture support
----------------------------------------------------------
SELECT PARSE('2025-08-24' AS DATETIME USING 'en-US') AS ParseDate;
SELECT PARSE('1234.56' AS DECIMAL(10,2) USING 'en-US') AS ParseDecimal;

----------------------------------------------------------
-- Example 6: TRY_PARSE
-- Returns NULL if conversion fails
----------------------------------------------------------
SELECT TRY_PARSE('2025-08-24' AS DATETIME USING 'en-US') AS TryParseValid;
SELECT TRY_PARSE('InvalidDate' AS DATETIME USING 'en-US') AS TryParseInvalid;

----------------------------------------------------------
-- Example 7: FORMAT
-- Convert number or datetime to formatted string
----------------------------------------------------------
SELECT FORMAT(12345.67, 'C', 'en-US') AS FormattedCurrency;
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') AS FormattedDateTime;

----------------------------------------------------------
-- Example 8: Combined Examples with AdventureWorks2019
----------------------------------------------------------
-- Convert ListPrice (money) to varchar
SELECT ProductID, CAST(ListPrice AS VARCHAR(20)) AS ListPriceString
FROM Production.Product;

-- Convert OrderDate to formatted string
SELECT SalesOrderID, CONVERT(VARCHAR(20), OrderDate, 120) AS FormattedOrderDate
FROM Sales.SalesOrderHeader;

-- Safely try to convert string to int
SELECT TRY_CAST('999' AS INT) AS ValidConversion,
       TRY_CAST('ABC' AS INT) AS InvalidConversion;
