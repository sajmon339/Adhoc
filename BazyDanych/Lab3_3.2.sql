SELECT
    c.CustomerID,
    od.SalesOrderID,
    od.ProductID,
    od.UnitPrice
FROM Sales.Customer c
CROSS APPLY (
    SELECT TOP 1
        soh.SalesOrderID,
        sod.ProductID,
        sod.UnitPrice
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    WHERE soh.CustomerID = c.CustomerID
    ORDER BY sod.UnitPrice DESC
) AS od
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader soh
    WHERE soh.CustomerID = c.CustomerID
);
