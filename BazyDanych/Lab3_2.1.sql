DROP TABLE IF EXISTS #BestProducts
GO

CREATE TABLE #BestProducts (
    IDProduktu INT PRIMARY KEY,
    Nazwa VARCHAR(20),
    Ilosc INT,
    Wartosc DECIMAL(10, 2)
);


DECLARE @ProductID INT, @ProdName VARCHAR(20), @Ilosc2012 INT, @Wartosc2012 DECIMAL(10, 2);

DECLARE ProductCursor CURSOR FOR
SELECT
    p.ProductID,
    p.Name AS ProdName,
    SUM(sod.OrderQty) AS Ilosc2012,
    SUM(sod.LineTotal) AS Wartosc2012
FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
    ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN Production.Product p
    ON sod.ProductID = p.ProductID
WHERE YEAR(soh.OrderDate) = 2012
GROUP BY p.ProductID, p.Name;

OPEN ProductCursor;

FETCH NEXT FROM ProductCursor INTO @ProductID, @ProdName, @Ilosc2012, @Wartosc2012;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Ilosc2012 > 100
    BEGIN
        INSERT INTO #BestProducts (IDProduktu, Nazwa, Ilosc, Wartosc)
        VALUES (@ProductID, @ProdName, @Ilosc2012, @Wartosc2012);
    END;

    FETCH NEXT FROM ProductCursor INTO @ProductID, @ProdName, @Ilosc2012, @Wartosc2012;
END;

CLOSE ProductCursor;
DEALLOCATE ProductCursor;

-- Query the final result
SELECT * FROM #BestProducts;
