/*
    Author: Negar Kohnesal
    Description: Useful views for AdventureWorks2019 database
    Created for portfolio and GitHub showcase
*/

-------------------------------------------------
-- 1. Sales by Year and Territory
-------------------------------------------------
CREATE OR ALTER VIEW vw_SalesByYearAndTerritory AS
SELECT 
    YEAR(soh.OrderDate) AS OrderYear,
    st.Name AS Territory,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY YEAR(soh.OrderDate), st.Name;
GO

-------------------------------------------------
-- 2. Top Customers by Sales
-------------------------------------------------
CREATE OR ALTER VIEW vw_TopCustomers AS
SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    SUM(soh.TotalDue) AS TotalSpent
FROM Sales.Customer c
    INNER JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName;
GO

-------------------------------------------------
-- 3. Product Sales Performance
-------------------------------------------------
CREATE OR ALTER VIEW vw_ProductSalesPerformance AS
SELECT 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
    INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name;
GO

-------------------------------------------------
-- 4. Employee Sales Summary
-------------------------------------------------
CREATE OR ALTER VIEW vw_EmployeeSalesSummary AS
SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName + ' ' + p.LastName AS SalesPersonName,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesPerson sp
    INNER JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
    INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
GROUP BY sp.BusinessEntityID, p.FirstName, p.LastName;
GO

-------------------------------------------------
-- 5. Inventory Status
-------------------------------------------------
CREATE OR ALTER VIEW vw_InventoryStatus AS
SELECT 
    p.Name AS ProductName,
    SUM(pi.Quantity) AS TotalStock
FROM Production.ProductInventory pi
    INNER JOIN Production.Product p ON pi.ProductID = p.ProductID
GROUP BY p.Name;
GO
