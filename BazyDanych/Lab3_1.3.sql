WITH RankedOrders AS (
    SELECT
        YEAR(soh.OrderDate) AS Rok,
        soh.SalesOrderID,
        soh.TotalDue,
        soh.CustomerID,
        s.Name AS StoreName, -- Fetch store name from the correct table
        RANK() OVER (PARTITION BY YEAR(soh.OrderDate) ORDER BY soh.TotalDue DESC) AS PozycjaRankingowa
    FROM Sales.SalesOrderHeader soh
    LEFT JOIN Sales.Customer c
        ON soh.CustomerID = c.CustomerID
    LEFT JOIN Sales.Store s
        ON c.StoreID = s.BusinessEntityID
)
SELECT
    Rok,
    SalesOrderID,
    TotalDue,
    CustomerID,
    StoreName,
    PozycjaRankingowa
FROM RankedOrders
WHERE PozycjaRankingowa <= 3
ORDER BY Rok, PozycjaRankingowa;
