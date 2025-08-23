/*
==================================================
LEFT JOIN Example
Purpose : Return all customers and their orders if they exist
Tables  : Sales.Customer, Sales.SalesOrderHeader
==================================================
*/
SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName,
    soh.SalesOrderID,
    soh.TotalDue
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;
