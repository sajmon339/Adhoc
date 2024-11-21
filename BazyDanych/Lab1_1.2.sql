USE AdventureWorks2019
GO

 SELECT
     I.*,
     CAST(LineCount AS NUMERIC(21,10))/ CAST(NumberOfOrders as NUMERIC(21,10)) AS AVGLineCount
FROM (SELECT CONCAT(PERS.FirstName, ' ', PERS.LastName) as CustomerFullName,
             CUST.CustomerID,
             COUNT(DISTINCT SalesOrderNumber)           AS NumberOfOrders,
             COUNT(*)                                   AS LineCount
      FROM Sales.SalesOrderHeader OH WITH (NOLOCK)
               INNER JOIN Sales.SalesOrderDetail OD ON OH.SalesOrderID = OD.SalesOrderID
               INNER JOIN Sales.Customer CUST on OH.CustomerID = CUST.CustomerID
               INNER JOIN Person.Person PERS on CUST.PersonID = PERS.BusinessEntityID
               INNER JOIN Sales.Store ST on CUST.StoreID = ST.BusinessEntityID
               INNER JOIN Production.Product P on P.ProductID = OD.ProductID
      GROUP BY PERS.FirstName, PERS.LastName, CUST.CustomerID) AS I