SELECT
    ORDERHEAD.SalesOrderID,
    PROD.ProductID,
    PROD.Name AS ProdName,
    PROD.ProductNumber,
    ORDDET.OrderQty,
    ORDDET.UnitPrice,
    ORDDET.UnitPriceDiscount,
    ORDDET.LineTotal
FROM Sales.SalesOrderHeader ORDERHEAD
CROSS APPLY (
    SELECT
        ORDD.ProductID,
        ORDD.OrderQty,
        ORDD.UnitPrice,
        ORDD.UnitPriceDiscount,
        ORDD.LineTotal
    FROM Sales.SalesOrderDetail ORDD
    WHERE ORDD.SalesOrderID = ORDERHEAD.SalesOrderID
      AND ORDD.OrderQty > 10
) AS ORDDET
INNER JOIN Production.Product PROD
    ON ORDDET.ProductID = PROD.ProductID
WHERE ORDERHEAD.OrderDate > '2014-01-01';
