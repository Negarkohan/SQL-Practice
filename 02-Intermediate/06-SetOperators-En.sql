-- AdventureWorks2019 SQL Examples - Set Operators
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using UNION, UNION ALL, INTERSECT, and EXCEPT

----------------------------------------------------------
-- Example 1: UNION
-- Get all distinct= names from both Address and Customer tables
----------------------------------------------------------
SELECT Name
FROM Person.StateProvince
UNION
SELECT Name
FROM Sales.SalesTerritory;

----------------------------------------------------------
-- Example 2: UNION ALL
-- Get all state/province names including duplicates
----------------------------------------------------------
SELECT Name
FROM Person.StateProvince
UNION ALL
SELECT Name
FROM Sales.SalesTerritory;

----------------------------------------------------------
-- Example 3: INTERSECT
-- States that appear in both tables
----------------------------------------------------------
SELECT Name
FROM Person.StateProvince
INTERSECT
SELECT Name
FROM Sales.SalesTerritory;

----------------------------------------------------------
-- Example 4: EXCEPT
-- States in Person.StateProvince but not in Sales.SalesTerritory
----------------------------------------------------------
SELECT Name
FROM Person.StateProvince
EXCEPT
SELECT Name
FROM Sales.SalesTerritory;
