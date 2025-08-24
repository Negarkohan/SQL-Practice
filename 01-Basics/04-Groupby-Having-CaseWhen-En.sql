-- AdventureWorks2019 SQL Examples - Part 2
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using GROUP BY, HAVING, and CASE WHEN

----------------------------------------------------------
-- Example 5: GROUP BY
-- Count how many addresses exist per city
----------------------------------------------------------
SELECT City, COUNT(AddressID) AS AddressCount
FROM Person.Address
GROUP BY City
ORDER BY AddressCount DESC;

----------------------------------------------------------
-- Example 6: HAVING
-- Retrieve cities with more than 10 addresses
----------------------------------------------------------
SELECT City, COUNT(AddressID) AS AddressCount
FROM Person.Address
GROUP BY City
HAVING COUNT(AddressID) > 10
ORDER BY AddressCount DESC;

----------------------------------------------------------
-- Example 7: CASE WHEN
-- Categorize products based on their ListPrice
----------------------------------------------------------
SELECT Name, ListPrice,
       CASE 
            WHEN ListPrice = 0 THEN 'Free'
            WHEN ListPrice < 1000 THEN 'Low'
            WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Medium'
            ELSE 'High'
       END AS PriceCategory
FROM Production.Product
ORDER BY ListPrice;
