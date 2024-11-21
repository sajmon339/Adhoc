USE AdventureWorks2019
GO

CREATE FUNCTION [dbo].[udfGetProductsByName]
(
    @name NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        Product.ProductID,
        Product.Name,
        Product.ProductNumber
    FROM
        Production.Product
    WHERE
        Product.Name LIKE '%' + @name + '%'
);

SELECT *
FROM [dbo].[udfGetProductsByName]('bike');

