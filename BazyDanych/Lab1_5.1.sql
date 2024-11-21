USE AdventureWorks2019
GO


WITH TotalSales AS (
    SELECT
        sod.ProductID,
        SUM(soh.TotalDue) AS TotalSalesAmount
    FROM
        Sales.SalesOrderHeader soh
    JOIN
        Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY
        sod.ProductID
    HAVING
        SUM(soh.TotalDue) > 1000000
),
AverageLineTotal AS (
    SELECT
        sod.ProductID,
        AVG(sod.LineTotal) AS AverageLineValue
    FROM
        Sales.SalesOrderDetail sod
    GROUP BY
        sod.ProductID
    HAVING
        AVG(sod.LineTotal) > 3500
)
SELECT
    p.ProductID,
    p.Name AS ProductName,
    ts.TotalSalesAmount AS TotalSales,
    alt.AverageLineValue AS AverageLineValue
FROM
    Production.Product p
LEFT JOIN
    TotalSales ts ON p.ProductID = ts.ProductID
LEFT JOIN
    AverageLineTotal alt ON p.ProductID = alt.ProductID
WHERE
    ts.TotalSalesAmount IS NOT NULL
    AND alt.AverageLineValue IS NOT NULL;
