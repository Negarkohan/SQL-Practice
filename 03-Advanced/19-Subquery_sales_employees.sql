-- Author: Negar Kohansal
-- Description: Find employees who work in the Sales department
--              with average pay rate greater than 20 using a subquery

USE AdventureWorks2019;
GO

SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    e.LoginID,
    e.HireDate
FROM HumanResources.Employee AS e
WHERE e.BusinessEntityID IN (
    -- Subquery: get employees in the 'Sales' department
    -- with average pay rate greater than 20
    SELECT edh.BusinessEntityID
    FROM HumanResources.EmployeeDepartmentHistory AS edh
    JOIN HumanResources.Department AS d
        ON edh.DepartmentID = d.DepartmentID
    JOIN HumanResources.EmployeePayHistory AS eph
        ON edh.BusinessEntityID = eph.BusinessEntityID
    WHERE d.Name = 'Sales'
    GROUP BY edh.BusinessEntityID
    HAVING AVG(eph.Rate) > 20
);
