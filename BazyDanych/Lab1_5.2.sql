USE AdventureWorks2019
GO

DROP TABLE IF EXISTS dbo.ProductHierarchy
GO
DROP TABLE IF EXISTS dbo.Products


CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL
)
GO
CREATE TABLE dbo.ProductHierarchy (
    ParentProductID INT,
    ChildProductID INT,
    FOREIGN KEY (ParentProductID) REFERENCES dbo.Products(ProductID),
    FOREIGN KEY (ChildProductID) REFERENCES dbo.Products(ProductID)
)
GO

INSERT INTO dbo.Products (ProductID, ProductName)
VALUES
(1, 'Rower'),
(2, 'Rama'),
(3, 'Koło'),
(4, 'Kierownica'),
(5, 'Siodełko'),
(6, 'Zestaw kół');

INSERT INTO dbo.ProductHierarchy (ParentProductID, ChildProductID)
VALUES
(1, 2),
(1, 6),
(6, 3),
(1, 4),
(1, 5);



go


WITH ProductHierarchyCTE AS (
    SELECT
        p.ProductID,
        p.ProductName,
        NULL AS ParentProductID,
        0 AS Level
    FROM
        dbo.Products p
    WHERE
        p.ProductID = 1
    UNION ALL
    SELECT
        p.ProductID,
        p.ProductName,
        ph.ParentProductID,
        cte.Level + 1
    FROM
        dbo.Products p
    INNER JOIN
        dbo.ProductHierarchy ph ON p.ProductID = ph.ChildProductID
    INNER JOIN
        ProductHierarchyCTE cte ON ph.ParentProductID = cte.ProductID
)
SELECT
    ProductID,
    ProductName,
    ParentProductID,
    Level
FROM
    ProductHierarchyCTE;
