SELECT
    p.ProductID AS [@ProductId],
    p.Name AS [ProductName],
    p.ProductNumber AS [ProductNumber],
    p.StandardCost AS [StandardCost],
    p.ListPrice AS [ListPrice],
    ISNULL(pc.Name, 'brak') AS [Kategoryzacja.CategoryName],
    ISNULL(psc.Name, 'brak') AS [Kategoryzacja.SubcategoryName],
    CASE WHEN EXISTS (
        SELECT 1
        FROM Sales.SalesOrderDetail sod
        WHERE sod.ProductID = p.ProductID
    ) THEN 'TAK' ELSE 'NIE' END AS [DaneSprzedazowe.CzyAktywny],
    ISNULL(
        (SELECT COUNT(*)
         FROM Sales.SalesOrderDetail sod
         WHERE sod.ProductID = p.ProductID), 0
    ) AS [DaneSprzedazowe.IleRazyZamowiony]
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
FOR XML PATH('Produkt'), ROOT('BazaProduktowa');
