/*
==================================================
FULL OUTER JOIN Example
Purpose : Return all customers and all orders, matching when possible
Tables  : Sales.Customer, Sales.SalesOrderHeader
==================================================
*/
SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName,
    soh.SalesOrderID,
    soh.TotalDue
FROM Sales.Customer c
FULL OUTER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;
