WITH ProductFirstOrder AS (
    SELECT
        sod.SalesOrderID,
        sod.ProductID,
        p.Name AS ProdName,
        sod.OrderQty,
        sod.LineTotal,
        soh.OrderDate,
        ROW_NUMBER() OVER (PARTITION BY sod.ProductID ORDER BY soh.OrderDate ASC) AS Lp
    FROM Sales.SalesOrderDetail sod
    INNER JOIN Production.Product p
        ON sod.ProductID = p.ProductID
    INNER JOIN Sales.SalesOrderHeader soh
        ON sod.SalesOrderID = soh.SalesOrderID
)
SELECT
    SalesOrderID,
    ProductID,
    ProdName,
    OrderQty,
    LineTotal,
    OrderDate,
    Lp
FROM ProductFirstOrder
WHERE Lp = 1;
