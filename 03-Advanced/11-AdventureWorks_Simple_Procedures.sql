USE AdventureWorks2019;
GO

-- =============================================
-- Author:        Negar Kohansal
-- Description:   Returns total sales amount for each product in a given date range
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetProductSales
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        SUM(sod.LineTotal) AS TotalSalesAmount,
        SUM(sod.OrderQty) AS TotalQuantitySold
    FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Production.Product AS p
        ON sod.ProductID = p.ProductID
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY p.ProductID, p.Name
    ORDER BY TotalSalesAmount DESC;
END;
GO

-- =============================================
-- Author:        Negar Kohnesal
-- Create date:   2025-08-26
-- Description:   Returns current stock quantity for all products
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetProductInventory
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        SUM(ais.Quantity) AS TotalQuantityInStock
    FROM Production.Product AS p
    INNER JOIN Production.ProductInventory AS ais
        ON p.ProductID = ais.ProductID
    GROUP BY p.ProductID, p.Name
    ORDER BY TotalQuantityInStock DESC;
END;
GO

-- =============================================
-- Author:        Negar Kohansal
-- Create date:   2025-08-26
-- Description:   Returns top N customers by total sales amount in a given date range
-- =============================================
CREATE OR ALTER PROCEDURE dbo.usp_GetTopCustomers
    @StartDate DATE,
    @EndDate DATE,
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP(@TopN)
        c.CustomerID,
        CONCAT(p.FirstName, ' ', p.LastName) AS CustomerName,
        SUM(sod.LineTotal) AS TotalSalesAmount
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
END;
GO
