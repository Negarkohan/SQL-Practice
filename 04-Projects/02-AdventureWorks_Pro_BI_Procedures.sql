USE AdventureWorks2019;
GO

-- =============================================
-- Author:        Negar Kohansal
-- Description:   Returns daily, monthly, and yearly sales KPIs including total sales, total orders, average order amount
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetSalesKPI
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Aggregate daily sales
    SELECT 
        CONVERT(DATE, soh.OrderDate) AS SalesDate,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
        AVG(sod.LineTotal) AS AvgOrderAmount,
        'Daily' AS KPILevel
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY CONVERT(DATE, soh.OrderDate)
    ORDER BY SalesDate;

    -- Aggregate monthly sales
    SELECT 
        YEAR(soh.OrderDate) AS SalesYear,
        MONTH(soh.OrderDate) AS SalesMonth,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
        AVG(sod.LineTotal) AS AvgOrderAmount,
        'Monthly' AS KPILevel
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)
    ORDER BY SalesYear, SalesMonth;

    -- Aggregate yearly sales
    SELECT 
        YEAR(soh.OrderDate) AS SalesYear,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
        AVG(sod.LineTotal) AS AvgOrderAmount,
        'Yearly' AS KPILevel
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY YEAR(soh.OrderDate)
    ORDER BY SalesYear;
END;
GO

-- =============================================
-- Description:   Returns top N customers and low performing customers based on total sales amount
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetCustomerPerformance
    @StartDate DATE,
    @EndDate DATE,
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Top N customers
    SELECT TOP(@TopN)
        c.CustomerID,
        CONCAT(p.FirstName, ' ', p.LastName) AS CustomerName,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Sales.Customer AS c
        ON soh.CustomerID = c.CustomerID
    INNER JOIN Person.Person AS p
        ON c.PersonID = p.BusinessEntityID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY c.CustomerID, p.FirstName, p.LastName
    ORDER BY TotalSalesAmount DESC;

    -- Low performing customers (bottom N)
    SELECT TOP(@TopN)
        c.CustomerID,
        CONCAT(p.FirstName, ' ', p.LastName) AS CustomerName,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Sales.Customer AS c
        ON soh.CustomerID = c.CustomerID
    INNER JOIN Person.Person AS p
        ON c.PersonID = p.BusinessEntityID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY c.CustomerID, p.FirstName, p.LastName
    ORDER BY TotalSalesAmount ASC;
END;
GO

-- =============================================
-- Description:   Returns product stock, total sales, and alerts if stock is below threshold
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetInventoryAlerts
    @StockThreshold INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        SUM(pi.Quantity) AS TotalStock,
        CASE 
            WHEN SUM(pi.Quantity) <= @StockThreshold THEN 'Low Stock'
            ELSE 'OK'
        END AS StockStatus
    FROM Production.Product AS p
    LEFT JOIN Production.ProductInventory AS pi
        ON p.ProductID = pi.ProductID
    GROUP BY p.ProductID, p.Name
    ORDER BY StockStatus DESC, TotalStock ASC;
END;
GO

-- =============================================
-- Description:   Returns combined product performance with sales, stock, discount, and category filter
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetAdvancedProductPerformance
    @StartDate DATE,
    @EndDate DATE,
    @CategoryName NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        pc.Name AS CategoryName,
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
    INNER JOIN Production.ProductSubcategory AS ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
      AND (@CategoryName IS NULL OR pc.Name = @CategoryName)
    GROUP BY p.ProductID, p.Name, pc.Name
    ORDER BY TotalSalesAmount DESC;
END;
GO
