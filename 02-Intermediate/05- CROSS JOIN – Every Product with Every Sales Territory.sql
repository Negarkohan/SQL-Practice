/*
==================================================
CROSS JOIN Example
Purpose : Combine every product with every sales territory
Tables  : Production.Product, Sales.SalesTerritory
==================================================
*/
SELECT 
    p.Name AS ProductName,
    st.Name AS TerritoryName
FROM Production.Product p
CROSS JOIN Sales.SalesTerritory st;
