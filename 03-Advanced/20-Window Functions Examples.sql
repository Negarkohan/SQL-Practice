/*
    Author: Negar Kohansal
    This script demonstrates common SQL Server window functions
    using the AdventureWorks2019 sample database.
*/

------------------------------------------------------------
-- 1. ROW_NUMBER()
-- Assigns a unique sequential number to rows within a partition.
------------------------------------------------------------
SELECT 
    SalesOrderID,
    OrderDate,
    CustomerID,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RowNum
FROM Sales.SalesOrderHeader;

------------------------------------------------------------
-- 2. RANK() and DENSE_RANK()
-- RANK: Gives the same rank to equal values but skips the next rank.
-- DENSE_RANK: Gives the same rank to equal values without skipping.
------------------------------------------------------------
SELECT 
    BusinessEntityID,
    Rate,
    RANK() OVER (ORDER BY Rate DESC) AS RankOrder,
    DENSE_RANK() OVER (ORDER BY Rate DESC) AS DenseRankOrder
FROM HumanResources.EmployeePayHistory;

------------------------------------------------------------
-- 3. NTILE(n)
-- Divides rows into n roughly equal groups.
-- Example: Split employees' pay rates into 4 quartiles.
------------------------------------------------------------
SELECT 
    BusinessEntityID,
    Rate,
    NTILE(4) OVER (ORDER BY Rate DESC) AS Quartile
FROM HumanResources.EmployeePayHistory;

------------------------------------------------------------
-- 4. SUM() with OVER()
-- Calculates total sales per customer but shows it on each row.
------------------------------------------------------------
SELECT 
    SalesOrderID,
    CustomerID,
    TotalDue,
    SUM(TotalDue) OVER (PARTITION BY CustomerID) AS TotalCustomerSales
FROM Sales.SalesOrderHeader;

------------------------------------------------------------
-- 5. AVG() with OVER()
-- Calculates average order amount per customer per year.
------------------------------------------------------------
SELECT 
    CustomerID,
    YEAR(OrderDate) AS OrderYear,
    TotalDue,
    AVG(TotalDue) OVER (PARTITION BY CustomerID, YEAR(OrderDate)) AS AvgPerYear
FROM Sales.SalesOrderHeader;
