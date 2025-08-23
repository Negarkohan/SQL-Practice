/*
==================================================
INNER JOIN Example
Purpose : Return all sales orders along with the customer full name
Tables  : Sales.SalesOrderHeader, Sales.Customer, Person.Person
==================================================
*/
SELECT 
    soh.SalesOrderID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    soh.OrderDate,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;
