/*
==================================================
Function: dbo.GetCustomerOrders
Purpose : Returns all sales orders of a given customer
Input   : @CustomerID (INT)
Output  : TABLE (SalesOrderID, OrderDate, TotalDue)
==================================================
*/
CREATE FUNCTION dbo.GetCustomerOrders (@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE CustomerID = @CustomerID
);
GO

-- Example usage:
-- SELECT * FROM dbo.GetCustomerOrders(11000);
