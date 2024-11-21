USE AdventureWorks2019
go

CREATE FUNCTION dbo.AnnualProductStatistics
(
    @ProductID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        YEAR(soh.OrderDate) AS Year,
        COUNT(sod.SalesOrderID) AS OrderCount,
        COUNT(DISTINCT soh.CustomerID) AS UniqueCustomerCount
    FROM
        Sales.SalesOrderDetail sod
    INNER JOIN
        Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    WHERE
        sod.ProductID = @ProductID
        AND soh.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY
        YEAR(soh.OrderDate)
)
GO

SELECT *
FROM dbo.AnnualProductStatistics(707, '2010-01-01', '2024-01-01');

