/*
==================================================
RIGHT JOIN Example
Purpose : Return all orders even if customer info is missing
Tables  : Sales.SalesOrderHeader, Sales.Customer
==================================================
*/
SELECT 
    soh.SalesOrderID,
    c.CustomerID,
    soh.OrderDate,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
RIGHT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID;
