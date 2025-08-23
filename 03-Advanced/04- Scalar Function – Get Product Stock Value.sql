/*
==================================================
Function: dbo.GetProductStockValue
Purpose : Returns the total stock value of a product
          (Quantity * StandardCost)
Input   : @ProductID (INT)
Output  : MONEY
==================================================
*/
CREATE FUNCTION dbo.GetProductStockValue (@ProductID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @StockValue MONEY;

    SELECT @StockValue = SUM(pi.Quantity * p.StandardCost)
    FROM Production.ProductInventory pi
    JOIN Production.Product p ON pi.ProductID = p.ProductID
    WHERE pi.ProductID = @ProductID;

    RETURN ISNULL(@StockValue, 0);
END;
GO

-- Example usage:
-- SELECT dbo.GetProductStockValue(776) AS StockValue;
