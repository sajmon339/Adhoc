Use AdventureWorks2019
go

SELECT *
FROM Sales.SalesOrderDetail sod
WHERE sod.ProductID IN (
    SELECT p.ProductID
    FROM Production.Product p
    JOIN #TopProducts2014 tp
        ON p.Name = tp.ProductName
);
