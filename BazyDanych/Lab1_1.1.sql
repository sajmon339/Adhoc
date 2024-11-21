USE AdventureWorks2019
GO

SELECT
Sum(CASE WHEN LineCount>1 THEN 1 ELSE 0 END) AS MultiLineOrders,
SUM(CASE WHEN LineCount=1 THEN 1 ELSE 0 END) As SingleLineOrders,
CAST(SUM(CASE WHEN LineCount=1 THEN 1 ELSE 0 END) AS NUMERIC(21,10))/CAST(COUNT(LineCount) AS NUMERIC(21,10))*100 AS SingleLinePercentage,
CAST(SUM(CASE WHEN LineCount>1 THEN 1 ELSE 0 END) AS NUMERIC(21,10))/CAST(COUNT(LineCount) AS NUMERIC(21,10))*100 As MultiLinePercentage
FROM (SELECT SalesOrderNumber,
             COUNT(*) AS LineCount
      FROM Sales.SalesOrderHeader OH WITH (NOLOCK)
               INNER JOIN Sales.SalesOrderDetail OD WITH (NOLOCK) ON OH.SalesOrderID = OD.SalesOrderID
               LEFT JOIN Sales.Customer CUST on OH.CustomerID = CUST.CustomerID
               LEFT JOIn Person.Person PERS on CUST.PersonID = PERS.BusinessEntityID
               LEFT JOIN Sales.Store ST on CUST.StoreID = ST.BusinessEntityID
               LEFT JOIN Production.Product P on P.ProductID = OD.ProductID
      GROUP BY SalesOrderNumber
      )  IQ