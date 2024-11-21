USE AdventureWorks2019
go
DROP FUNCTION IF EXISTS dbo.GetOrderCount
GO

CREATE FUNCTION dbo.GetOrderCount
(
    @ProductID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @OrderCount INT;

    SELECT
        @OrderCount = COUNT(sod.SalesOrderID)
    FROM
        Sales.SalesOrderDetail sod
    INNER JOIN
        Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    WHERE
        sod.ProductID = @ProductID
        AND soh.OrderDate BETWEEN @StartDate AND @EndDate;

    RETURN @OrderCount;
END
GO

SELECT dbo.GetOrderCount(707, '2010-01-01', '2024-01-01') AS OrderCount;
