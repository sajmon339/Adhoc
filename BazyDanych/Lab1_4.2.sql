USE AdventureWorks2019
go
DROP FUNCTION IF EXISTS dbo.GetUniqueCustomerCount
GO

CREATE FUNCTION dbo.GetUniqueCustomerCount
(
    @ProductID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @UniqueCustomerCount INT;

    SELECT
        @UniqueCustomerCount = COUNT(DISTINCT soh.CustomerID)
    FROM
        Sales.SalesOrderDetail sod
    INNER JOIN
        Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    WHERE
        sod.ProductID = @ProductID
        AND soh.OrderDate BETWEEN @StartDate AND @EndDate;

    RETURN @UniqueCustomerCount;
END
GO
SELECT dbo.GetUniqueCustomerCount(707, '2010-01-01', '2024-01-01') AS UniqueCustomerCount;
