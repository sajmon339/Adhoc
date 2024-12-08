WITH RankedOrders AS (
    SELECT
        soh.CustomerID,
        soh.SalesOrderID,
        sod.ProductID,
        sod.UnitPrice,
        ROW_NUMBER() OVER (
            PARTITION BY soh.CustomerID
            ORDER BY sod.UnitPrice DESC
        ) AS RowNum
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
)
SELECT
    CustomerID,
    SalesOrderID,
    ProductID,
    UnitPrice
FROM RankedOrders
WHERE RowNum = 1;
