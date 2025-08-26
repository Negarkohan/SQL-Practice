-- =============================================
-- Author:        Negar Kohansal
-- Description:   Logs low stock alerts whenever ProductInventory is updated
-- =============================================
--CREATE TABLE dbo.ProductInventory_Alerts
--(
--    AlertID INT IDENTITY(1,1) PRIMARY KEY,
--    ProductID INT,
--    Quantity INT,
--    AlertDate DATETIME,
--    AlertMessage NVARCHAR(200)
--);

-- =============================================

CREATE OR ALTER TRIGGER trg_LowStockAlert
ON Production.ProductInventory
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ProductInventory_Alerts
    (
        ProductID,
        Quantity,
        AlertDate,
        AlertMessage
    )
    SELECT 
        i.ProductID,
        i.Quantity,
        GETDATE(),
        'Low stock alert: quantity below threshold (10)'
    FROM INSERTED i
    WHERE i.Quantity <= 10;
END;
GO
