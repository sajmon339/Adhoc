DROP TABLE IF EXISTS  #CustomerSummary

GO


CREATE TABLE #CustomerSummary (
    CustomerID INT PRIMARY KEY,
    OrderCount2012 INT,
    TotalSales2012 DECIMAL(18, 2),
    OrderCount2013 INT,
    TotalSales2013 DECIMAL(18, 2)
);


INSERT INTO #CustomerSummary (CustomerID, OrderCount2012, TotalSales2012)
SELECT
    soh.CustomerID,
    COUNT(*) AS OrderCount2012,
    SUM(soh.TotalDue) AS TotalSales2012
FROM Sales.SalesOrderHeader soh
WHERE YEAR(soh.OrderDate) = 2012
GROUP BY soh.CustomerID;


MERGE INTO #CustomerSummary AS Target
USING (
    SELECT
        soh.CustomerID,
        COUNT(*) AS OrderCount2013,
        SUM(soh.TotalDue) AS TotalSales2013
    FROM Sales.SalesOrderHeader soh
    WHERE YEAR(soh.OrderDate) = 2013
    GROUP BY soh.CustomerID
) AS Source
ON Target.CustomerID = Source.CustomerID
WHEN MATCHED THEN
    UPDATE SET
        Target.OrderCount2013 = Source.OrderCount2013,
        Target.TotalSales2013 = Source.TotalSales2013
WHEN NOT MATCHED THEN
    INSERT (CustomerID, OrderCount2012, TotalSales2012, OrderCount2013, TotalSales2013)
    VALUES (Source.CustomerID, 0, 0, Source.OrderCount2013, Source.TotalSales2013);



    SELECT * FROM #CustomerSummary