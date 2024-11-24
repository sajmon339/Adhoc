USe AdventureWorks2019
go



DECLARE @MyTable TABLE
(
    SalesOrderId INT,
    RevisionNumbr int,
    OrderDate datetime
)
/*[S0001][102] Line 9: Incorrect syntax near '@MyTable'.*/
select SalesorderId,RevisionNumber,OrderDate
INTO @MyTable
FROM Sales.SalesOrderHeader
GO

DECLARE @MyTable TABLE
(
    SalesOrderId INT,
    RevisionNumbr int,
    OrderDate datetime
)
INSERT INTO  @MyTable
    (SalesOrderId, RevisionNumbr, OrderDate)
select SalesorderId,RevisionNumber,OrderDate
FROM Sales.SalesOrderHeader

DROP TABLE IF EXISTS  dbo.MyTable

SELECT
    *
Into dbo.MyTable
FROM @MyTable


SELECT * FROM dbo.MyTable