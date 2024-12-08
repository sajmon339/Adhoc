WITH ProductSales AS (
    SELECT
        sod.SalesOrderID,
        sod.ProductID,
        p.Name AS ProdName,
        sod.OrderQty,
        sod.LineTotal,
        AVG(sod.UnitPrice) OVER (PARTITION BY sod.ProductID) AS ŚredniaCena,
        SUM(sod.LineTotal) OVER (PARTITION BY sod.ProductID) AS WartośćPerProdukt,
        COUNT(*) OVER (PARTITION BY sod.ProductID) AS LiczbaLiniiPerProdukt
    FROM Sales.SalesOrderDetail sod
    INNER JOIN Production.Product p
        ON sod.ProductID = p.ProductID
)
SELECT *
FROM ProductSales
WHERE LiczbaLiniiPerProdukt > 1000
  AND ŚredniaCena < 20;
