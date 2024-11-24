USE AdventureWorks2019
go

WITH SalesByQuarter AS (
    SELECT
        YEAR(soh.OrderDate) AS Year,
        DATEPART(QUARTER, soh.OrderDate) AS Quarter,
        SUM(sod.LineTotal) AS TotalSales
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY YEAR(soh.OrderDate), DATEPART(QUARTER, soh.OrderDate)
)
SELECT
    Year,
    [1] AS Q1,
    [2] AS Q2,
    [3] AS Q3,
    [4] AS Q4
FROM SalesByQuarter
PIVOT (
    SUM(TotalSales) FOR Quarter IN ([1], [2], [3], [4])
) AS PivotTable
ORDER BY Year;
