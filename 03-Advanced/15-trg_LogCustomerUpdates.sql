-- =============================================
-- Author:        Negar Kohansal
-- Description:   Logs updates on Customer table for auditing
-- =============================================
--CREATE TABLE dbo.Customer_Log
--(
--    LogID INT IDENTITY(1,1) PRIMARY KEY,
--    CustomerID INT,
--    PersonID INT,
--    CompanyName NVARCHAR(100),
--    ModifiedDate DATETIME,
--    ChangeDate DATETIME
--);
 -- =============================================
CREATE OR ALTER TRIGGER trg_LogCustomerUpdates
ON Sales.Customer
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Customer_Log
    (
        CustomerID,
        PersonID,
        CompanyName,
        ModifiedDate,
        ChangeDate
    )
    SELECT 
        d.CustomerID,
        d.PersonID,
        d.CompanyName,
        d.ModifiedDate,
        GETDATE()
    FROM DELETED d
    INNER JOIN INSERTED i
        ON d.CustomerID = i.CustomerID
    WHERE d.CompanyName <> i.CompanyName
       OR d.PersonID <> i.PersonID;
END;
GO
