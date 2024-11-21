USE AdventureWorks2019
GO
DROP TABLE IF EXISTS dbo.Audit_SalesOrderDetail
GO

CREATE TABLE dbo.Audit_SalesOrderDetail (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT NOT NULL,
    OldUnitPrice DECIMAL(19,4) NOT NULL,
    NewUnitPrice DECIMAL(19,4) NOT NULL,
    UpdateDate DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedBy NVARCHAR(128) NOT NULL
);

GO
DROP TRIGGER IF EXISTS dbo.TRG_UpdateSalesOrderDetail
GO

CREATE TRIGGER Sales.TRG_UpdateSalesOrderDetail
ON Sales.SalesOrderDetail
FOR UPDATE
AS
BEGIN
    IF UPDATE(UnitPrice)
    BEGIN
        INSERT INTO dbo.Audit_SalesOrderDetail (SalesOrderID, SalesOrderDetailID, OldUnitPrice, NewUnitPrice, UpdateDate, UpdatedBy)
        SELECT
            d.SalesOrderID,
            d.SalesOrderDetailID,
            d.UnitPrice AS OldUnitPrice,
            i.UnitPrice AS NewUnitPrice,
            GETDATE() AS UpdateDate,
            SYSTEM_USER AS UpdatedBy
        FROM deleted d
        JOIN inserted i ON d.SalesOrderDetailID = i.SalesOrderDetailID
        WHERE d.UnitPrice <> i.UnitPrice;
    END;
END
GO

UPDATE Sales.SalesOrderDetail
SET UnitPrice = UnitPrice + 10
WHERE SalesOrderDetailID = 1;
GO

SELECT * FROM dbo.Audit_SalesOrderDetail;
