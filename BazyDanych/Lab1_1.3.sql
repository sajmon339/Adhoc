USE AdventureWorks2019
GO


WITH QuarterlySales AS (
    SELECT
        p.ProductID,
        p.Name,
        DATEPART(QUARTER, soh.OrderDate) AS SalesQuarter,
        SUM(sod.OrderQty) AS TotalSold
    FROM
        Sales.SalesOrderHeader soh
    JOIN
        Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN
        Production.Product p ON sod.ProductID = p.ProductID
    WHERE
        YEAR(soh.OrderDate) = 2012
    GROUP BY
        p.ProductID, p.Name, DATEPART(QUARTER, soh.OrderDate)
)
SELECT
    PivotTable.ProductID,
    PivotTable.Name,
    ISNULL([1], 0) AS Q1_2012,
    ISNULL([2], 0) AS Q2_2012,
    ISNULL([3], 0) AS Q3_2012,
    ISNULL([4], 0) AS Q4_2012,
    ROUND((ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0)) / 4.0, 2) AS AverageQuarterlySales,
    pi.Quantity AS CurrentStockLevel,
    CASE
        WHEN ROUND((ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0)) / 4.0, 2) - pi.Quantity > 0
        THEN ROUND((ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0)) / 4.0, 2) - pi.Quantity
        ELSE 0
    END AS SuggestedReorderQuantity
FROM
    (SELECT ProductID, Name, SalesQuarter, TotalSold FROM QuarterlySales) AS SourceTable
PIVOT
    (SUM(TotalSold) FOR SalesQuarter IN ([1], [2], [3], [4])) AS PivotTable
JOIN
    Production.ProductInventory pi ON PivotTable.ProductID = pi.ProductID
ORDER BY
    SuggestedReorderQuantity DESC;
