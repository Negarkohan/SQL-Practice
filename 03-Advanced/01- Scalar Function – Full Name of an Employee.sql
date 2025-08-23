/*
==================================================
Function: dbo.GetEmployeeFullName
Purpose : Returns the full name (First + Last) of an employee
Input   : @BusinessEntityID (INT)
Output  : NVARCHAR(200)
==================================================
*/
CREATE FUNCTION dbo.GetEmployeeFullName (@BusinessEntityID INT)
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @FullName NVARCHAR(200);

    SELECT @FullName = p.FirstName + ' ' + p.LastName
    FROM Person.Person p
    WHERE p.BusinessEntityID = @BusinessEntityID;

    RETURN @FullName;
END;
GO

-- Example usage:
-- SELECT dbo.GetEmployeeFullName(1);
