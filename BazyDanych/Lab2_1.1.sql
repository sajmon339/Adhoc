Use AdventureWorks2019
go

CREATE TABLE #ParentTable (
    ParentID INT PRIMARY KEY,
    ParentName NVARCHAR(50) NOT NULL
);

CREATE TABLE #ChildTable (
    ChildID INT PRIMARY KEY,
    ParentID INT NOT NULL,
    ChildName NVARCHAR(50) NOT NULL
);

ALTER TABLE #ChildTable
ADD CONSTRAINT FK_ChildTable_ParentTable FOREIGN KEY (ParentID)
REFERENCES #ParentTable (ParentID);

INSERT INTO #ParentTable (ParentID, ParentName)
VALUES (1, 'Elektronika'), (2, 'Meble'), (3, 'Odzież');

INSERT INTO #ChildTable (ChildID, ParentID, ChildName)
VALUES
    (1, 1, 'Smartfon'),
    (2, 1, 'Laptop'),
    (3, 2, 'Stół'),
    (4, 3, 'T-shirt');

SELECT
    p.ParentName AS Category,
    c.ChildName AS Product
FROM
    #ParentTable p
INNER JOIN
    #ChildTable c
ON
    p.ParentID = c.ParentID;
