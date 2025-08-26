USE AdventureWorks2019;
GO

-- =============================================
-- Author:        Negar Kohansal
-- Description:   Returns total sales and average order amount per product category within a given date range
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetCategorySalesKPI
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        pc.Name AS ProductCategory,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
        AVG(sod.LineTotal) AS AvgOrderAmount
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Production.Product AS p
        ON sod.ProductID = p.ProductID
    INNER JOIN Production.ProductSubcategory AS ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY pc.Name
    ORDER BY TotalSalesAmount DESC;
END;
GO

-- =============================================
-- Author:        Negar Kohansal
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetTopRegions
    @StartDate DATE,
    @EndDate DATE,
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP(@TopN)
        sr.Name AS RegionName,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
        AVG(sod.LineTotal) AS AvgOrderAmount
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Sales.SalesTerritory AS sr
        ON soh.TerritoryID = sr.TerritoryID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY sr.Name
    ORDER BY TotalSalesAmount DESC;
END;
GO

-- =============================================
-- Description:   Returns product sales performance with stock availability and average discount
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetProductPerformance
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        SUM(sod.OrderQty) AS TotalQuantitySold,
        SUM(pi.Quantity) AS TotalStockAvailable,
        AVG(sod.UnitPriceDiscount) AS AvgDiscount
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Production.Product AS p
        ON sod.ProductID = p.ProductID
    LEFT JOIN Production.ProductInventory AS pi
        ON p.ProductID = pi.ProductID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY p.ProductID, p.Name
    ORDER BY TotalSalesAmount DESC;
END;
GO
