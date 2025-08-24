-- AdventureWorks2019 SQL Examples - Date Functions
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using common date and time functions

----------------------------------------------------------
-- Example 1: GETDATE
-- Get the current system date and time
----------------------------------------------------------
SELECT GETDATE() AS CurrentDateTime;

----------------------------------------------------------
-- Example 2: SYSDATETIME
-- Get the current system date and time with higher precision
----------------------------------------------------------
SELECT SYSDATETIME() AS CurrentDateTimeHighPrecision;

----------------------------------------------------------
-- Example 3: CURRENT_TIMESTAMP
-- Same as GETDATE()
----------------------------------------------------------
SELECT CURRENT_TIMESTAMP AS CurrentTimeStamp;

----------------------------------------------------------
-- Example 4: DATEPART
-- Extract the year part of the OrderDate
----------------------------------------------------------
SELECT SalesOrderID, DATEPART(YEAR, OrderDate) AS OrderYear
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 5: DATENAME
-- Get the month name of the OrderDate
----------------------------------------------------------
SELECT SalesOrderID, DATENAME(MONTH, OrderDate) AS OrderMonthName
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 6: YEAR, MONTH, DAY
-- Get year, month, and day from the OrderDate
----------------------------------------------------------
SELECT YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth,
       DAY(OrderDate) AS OrderDay
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 7: DATEADD
-- Add 30 days to OrderDate
----------------------------------------------------------
SELECT SalesOrderID, OrderDate,
       DATEADD(DAY, 30, OrderDate) AS Plus30Days
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 8: DATEDIFF
-- Calculate the number of days between OrderDate and ShipDate
----------------------------------------------------------
SELECT SalesOrderID, 
       DATEDIFF(DAY, OrderDate, ShipDate) AS DaysToShip
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 9: EOMONTH
-- Get the last day of the month for each OrderDate
----------------------------------------------------------
SELECT OrderDate, EOMONTH(OrderDate) AS EndOfMonth
FROM Sales.SalesOrderHeader;

----------------------------------------------------------
-- Example 10: SWITCHOFFSET
-- Convert current datetimeoffset to Iran timezone (+03:30)
----------------------------------------------------------
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+03:30') AS IranTime;

----------------------------------------------------------
-- Example 11: TODATETIMEOFFSET
-- Convert a datetime value to datetimeoffset with +02:00 offset
----------------------------------------------------------
SELECT TODATETIMEOFFSET(GETDATE(), '+02:00') AS WithOffset;

----------------------------------------------------------
-- Example 12: SYSUTCDATETIME
-- Get the current UTC time
----------------------------------------------------------
SELECT SYSUTCDATETIME() AS CurrentUTC;

----------------------------------------------------------
-- Example 13: ISDATE
-- Check if a value is a valid date
----------------------------------------------------------
SELECT ISDATE('2025-01-01') AS IsValidDate1; -- returns 1
SELECT ISDATE('2025-13-01') AS IsValidDate2; -- returns 0;
