/*
==================================================
Function: dbo.GetOrderProfit
Purpose : Calculates the total sales, total cost,
          and profit of a given SalesOrderID
Input   : @SalesOrderID (INT)
Output  : TABLE (SalesOrderID, TotalSales, TotalCost, Profit)
==================================================
*/
CREATE FUNCTION dbo.GetOrderProfit (@SalesOrderID INT)
RETURNS @Result TABLE
(
    SalesOrderID INT,
    TotalSales MONEY,
    TotalCost MONEY,
    Profit MONEY
)
AS
BEGIN
    DECLARE @TotalSales MONEY, @TotalCost MONEY;

    -- Calculate total sales amount
    SELECT @TotalSales = SUM(LineTotal)
    FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @SalesOrderID;

    -- Calculate total cost (Qty * StandardCost)
    SELECT @TotalCost = SUM(d.OrderQty * p.StandardCost)
    FROM Sales.SalesOrderDetail d
    JOIN Production.Product p ON d.ProductID = p.ProductID
    WHERE d.SalesOrderID = @SalesOrderID;

    -- Insert result into return table
    INSERT INTO @Result
    VALUES (@SalesOrderID, @TotalSales, @TotalCost, @TotalSales - @TotalCost);

    RETURN;
END;
GO

-- Example usage:
-- SELECT * FROM dbo.GetOrderProfit(43659);
