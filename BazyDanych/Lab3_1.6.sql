WITH ProductRanks AS (
    SELECT
        pc.ProductCategoryID,
        pc.Name AS CategoryName,
        p.ProductID,
        p.Name AS ProductName,
        p.ListPrice,
        RANK() OVER (PARTITION BY pc.ProductCategoryID ORDER BY p.ListPrice DESC) AS RankByListPrice,
        DENSE_RANK() OVER (PARTITION BY pc.ProductCategoryID ORDER BY p.ListPrice DESC) AS DenseRankByListPrice
    FROM Production.Product p
    INNER JOIN Production.ProductSubcategory ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
)
SELECT
    ProductCategoryID,
    CategoryName,
    ProductID,
    ProductName,
    ListPrice,
    RankByListPrice,
    DenseRankByListPrice
FROM ProductRanks
WHERE RankByListPrice <> DenseRankByListPrice
ORDER BY ProductCategoryID, RankByListPrice;
