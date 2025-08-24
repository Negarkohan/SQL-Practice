-- AdventureWorks2019 SQL Examples
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using DISTINCT, LIKE, BETWEEN, and IN

----------------------------------------------------------
-- Example 1: DISTINCT
-- Retrieve unique list of cities from Person.Address
----------------------------------------------------------
SELECT DISTINCT City
FROM Person.Address;

----------------------------------------------------------
-- Example 2: LIKE
-- Retrieve people whose last name starts with 'Jo'
----------------------------------------------------------
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE 'Jo%';

----------------------------------------------------------
-- Example 3: BETWEEN
-- Retrieve products with ListPrice between 1000 and 2000
----------------------------------------------------------
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice;

----------------------------------------------------------
-- Example 4: IN
-- Retrieve orders with Status values in (1, 2, 5)
----------------------------------------------------------
SELECT SalesOrderID, Status
FROM Sales.SalesOrderHeader
WHERE Status IN (1, 2, 5);
