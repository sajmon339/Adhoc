USE AdventureWorks2019
go
WITH SalesByMonth AS (
    SELECT
        MONTH(soh.OrderDate) AS Month,
        YEAR(soh.OrderDate) AS Year,
        SUM(sod.LineTotal) AS TotalSales
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY MONTH(soh.OrderDate), YEAR(soh.OrderDate)
)
SELECT
    Month,
    ISNULL([2011], 0) AS Y2011,
    ISNULL([2012], 0) AS Y2012,
    ISNULL([2013], 0) AS Y2013,
    ISNULL([2014], 0) AS Y2014
FROM SalesByMonth
PIVOT (
    SUM(TotalSales) FOR Year IN ([2011], [2012], [2013], [2014])
) AS PivotTable
ORDER BY Month;
