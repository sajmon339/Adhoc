WITH EmployeeRanks AS (
    SELECT
        edh.DepartmentID,
        d.Name AS Department,
        edh.BusinessEntityID AS IDPracownika,
        edh.StartDate AS HireDate,
        RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY edh.StartDate ASC) AS RankByHireDate,
        DENSE_RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY edh.StartDate ASC) AS DenseRankByHireDate
    FROM HumanResources.EmployeeDepartmentHistory edh
    INNER JOIN HumanResources.Department d
        ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL )
SELECT
    DepartmentID,
    Department,
    IDPracownika,
    HireDate,
    RankByHireDate,
    DenseRankByHireDate
FROM EmployeeRanks
WHERE RankByHireDate = DenseRankByHireDate
ORDER BY DepartmentID, RankByHireDate;
