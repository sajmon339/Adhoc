USE AdventureWorks2019
go

TRUNCATE TABLE dbo.ProductHierarchy;
DELETE FROM dbo.Products;

DECLARE @ProductID INT = 1;

WHILE @ProductID <= 100
BEGIN
    INSERT INTO dbo.Products (ProductID, ProductName)
    VALUES (@ProductID, CONCAT('Product ', @ProductID));

    SET @ProductID = @ProductID + 1;
END;


GO

DECLARE @ParentProductID INT = 1;
DECLARE @ChildProductID INT = 2;

WHILE @ParentProductID <= 50
BEGIN
    IF @ChildProductID <= 100
    BEGIN
        INSERT INTO dbo.ProductHierarchy (ParentProductID, ChildProductID)
        VALUES (@ParentProductID, @ChildProductID);

        SET @ChildProductID = @ChildProductID + 1;
    END
    ELSE
    BEGIN
        SET @ParentProductID = @ParentProductID + 1;
        SET @ChildProductID = @ParentProductID + 1;
    END;
END;


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
    WHERE
        cte.Level < 100
)
SELECT
    ProductID,
    ProductName,
    ParentProductID,
    Level
FROM
    ProductHierarchyCTE
OPTION (MAXRECURSION 100);
