USE AdventureWorks2019
GO


SELECT
    p.FirstName + ' ' + p.LastName AS Osoba,
    'Pracownik' AS Rola
FROM
    Person.Person p
WHERE
    EXISTS (
        SELECT 1
        FROM HumanResources.Employee e
        WHERE e.BusinessEntityID = p.BusinessEntityID
    )

UNION ALL


SELECT
    p.FirstName + ' ' + p.LastName AS Osoba,
    'Klient' AS Rola
FROM
    Person.Person p
WHERE
    EXISTS (
        SELECT 1
        FROM Sales.Customer c
        WHERE c.PersonID = p.BusinessEntityID
    )
ORDER BY
    Rola, Osoba;
