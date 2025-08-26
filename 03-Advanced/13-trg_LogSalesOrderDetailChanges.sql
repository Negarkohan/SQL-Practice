USE AdventureWorks2019;
GO

-- =============================================
-- Author:        Negar Kohansal
-- Description:   Logs insert or update operations on SalesOrderDetail for auditing
-- =============================================
--CREATE TABLE dbo.SalesOrderDetail_Log
--(
--    LogID INT IDENTITY(1,1) PRIMARY KEY,
--    SalesOrderID INT,
--    ProductID INT,
--    OrderQty SMALLINT,
--    LineTotal MONEY,
--    ChangeType NVARCHAR(10),
--    ChangeDate DATETIME
--);
-- =============================================
CREATE OR ALTER TRIGGER trg_LogSalesOrderDetailChanges
ON Sales.SalesOrderDetail
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.SalesOrderDetail_Log
    (
        SalesOrderID,
        ProductID,
        OrderQty,
        LineTotal,
        ChangeType,
        ChangeDate
    )
    SELECT 
        i.SalesOrderID,
        i.ProductID,
        i.OrderQty,
        i.LineTotal,
        CASE 
            WHEN u.SalesOrderDetailID IS NULL THEN 'INSERT'
            ELSE 'UPDATE'
        END AS ChangeType,
        GETDATE()
    FROM INSERTED i
    LEFT JOIN DELETED u
        ON i.SalesOrderDetailID = u.SalesOrderDetailID;
END;
GO
