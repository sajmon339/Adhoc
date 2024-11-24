Use AdventureWorks2019
go

SELECT TOP 5
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold
INTO #TopProducts2014
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
WHERE YEAR(soh.OrderDate) = 2014
GROUP BY p.Name
ORDER BY TotalQuantitySold DESC;

SELECT * FROM #TopProducts2014;
