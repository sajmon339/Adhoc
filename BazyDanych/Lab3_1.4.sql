WITH RankedOrders AS (
    SELECT
        YEAR(soh.OrderDate) AS Rok,
        MONTH(soh.OrderDate) AS Miesiąc,
        soh.SalesOrderID,
        soh.TotalDue,
        soh.CustomerID,
        s.Name AS StoreName,
        RANK() OVER (
            PARTITION BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)
            ORDER BY soh.TotalDue DESC
        ) AS PozycjaRankingowa
    FROM Sales.SalesOrderHeader soh
    LEFT JOIN Sales.Customer c
        ON soh.CustomerID = c.CustomerID
    LEFT JOIN Sales.Store s
        ON c.StoreID = s.BusinessEntityID
    WHERE soh.TotalDue > 130000
)
SELECT
    Rok,
    Miesiąc,
    SalesOrderID,
    TotalDue,
    CustomerID,
    StoreName,
    PozycjaRankingowa
FROM RankedOrders
WHERE PozycjaRankingowa <= 3
ORDER BY Rok, Miesiąc, PozycjaRankingowa;
