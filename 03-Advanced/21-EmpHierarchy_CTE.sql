-- =============================================
-- Author: Negar Kohansal
-- Demonstrate the use of a Common Table Expression (CTE)
-- to display employees in a simple hierarchical structure.
-- Here, we use the OrganizationLevel column as an approximation
-- of the hierarchy, since OrganizationNode may not be populated.
-- Each level of the hierarchy is represented by indentation.
-- =============================================

WITH EmpHierarchy AS
(
    -- Anchor: Select all employees with their name, job title, and organization level
    -- This is the "temporary result set" created by the CTE.
    SELECT 
        e.BusinessEntityID,
        p.FirstName + ' ' + p.LastName AS EmployeeName,
        e.JobTitle,
        e.OrganizationLevel AS EmpLevel  -- Use OrganizationLevel for approximate hierarchy
    FROM HumanResources.Employee e
    JOIN Person.Person p 
        ON e.BusinessEntityID = p.BusinessEntityID
)
-- Final SELECT: Use the CTE result to display a simple hierarchy
SELECT 
    REPLICATE('   ', EmpLevel) + EmployeeName AS EmployeeHierarchy,  -- Indent employee names
    JobTitle
FROM EmpHierarchy
ORDER BY EmpLevel, EmployeeName;  -- Order by level and name for clarity
