    DROP TABLE IF EXISTS dbo.Pracownicy
    GO

    CREATE TABLE dbo.Pracownicy (
    prac_id INT PRIMARY KEY,
    prac_imie VARCHAR(20),
    prac_nazwisko VARCHAR(20),
    prac_projekty VARCHAR(30)
    );

    GO
    DROP TABLE IF EXISTS dbo.Projekty
    GO
    CREATE TABLE dbo.Projekty (
    proj_id INT PRIMARY KEY IDENTITY,
    proj_nazwa VARCHAR(20)
    );
    GO
    INSERT INTO Pracownicy (prac_id, prac_imie, prac_nazwisko,
    prac_projekty)
    VALUES
    (1, 'Anna', 'Kowalska', '1,23,34,21,24,56,68'),
    (7, 'Jan', 'Nowak', '2,67'),
    (12, 'Maria', 'Wiśniewska', '73,87,88,91'),
    (40, 'Tomasz', 'Zieliński', '34,56,56,67,98'),
    (41, 'Katarzyna', 'Szymańska', '3'),
    (45, 'Michał', 'Woźniak', null),
    (71, 'Agnieszka', 'Krawczyk', '89,13,76,2'),
    (83, 'Piotr', 'Wójcik', '23,44,77,12'),
    (84, 'Magdalena', 'Nowicka', '8,88'),
    (85, 'Adam', 'Jankowski', '37,78,90');

    GO

    DECLARE @i INT = 1;
    WHILE @i <= 100
    BEGIN
    INSERT INTO dbo.Projekty (proj_nazwa)
    VALUES ('Projekt ' + CAST(@i AS VARCHAR(10)));
    SET @i = @i + 1;
    END;
GO

ALTER TABLE dbo.Projekty
ADD proj_status VARCHAR(30);
GO
UPDATE dbo.Projekty
SET proj_status = 'nowy'
WHERE proj_id <= 25;

UPDATE dbo.Projekty
SET proj_status = 'w trakcie'
WHERE proj_id > 25 AND proj_id <= 50;

UPDATE dbo.Projekty
SET proj_status = 'zakończony pozytywnie'
WHERE proj_id > 50 AND proj_id <= 75;

UPDATE dbo.Projekty
SET proj_status = 'zakończony negatywnie'
WHERE proj_id > 75;

GO
DROP TABLE IF EXISTS dbo.DictionaryValues;

CREATE TABLE dbo.DictionaryValues (
    dict_id INT PRIMARY KEY IDENTITY,
    dict_type VARCHAR(50) NOT NULL,
    dict_value VARCHAR(50) NOT NULL,
    UNIQUE (dict_type, dict_value)
);
GO
INSERT INTO dbo.DictionaryValues (dict_type, dict_value)
VALUES
('proj_status', 'nowy'),
('proj_status', 'w trakcie'),
('proj_status', 'zakończony pozytywnie'),
('proj_status', 'zakończony negatywnie');
go
ALTER TABLE dbo.Projekty
ADD proj_status_id INT;

ALTER TABLE dbo.Projekty
ADD CONSTRAINT fk_proj_status FOREIGN KEY (proj_status_id)
REFERENCES dbo.DictionaryValues(dict_id);
go

go
UPDATE p
SET proj_status_id = d.dict_id
FROM dbo.Projekty p
JOIN dbo.DictionaryValues d
ON d.dict_type = 'proj_status' AND d.dict_value = p.proj_status;
go

ALTER TABLE dbo.Projekty DROP COLUMN proj_status;
go
INSERT INTO dbo.DictionaryValues (dict_type, dict_value)
VALUES ('proj_status', 'archiwalny');
go
SELECT
    p.proj_id,
    p.proj_nazwa,
    d.dict_value AS proj_status
FROM dbo.Projekty p
LEFT JOIN dbo.DictionaryValues d
ON p.proj_status_id = d.dict_id;
GO

INSERT INTO dbo.DictionaryValues (dict_type, dict_value)
VALUES
('proj_budzet', 'lokalny'),
('proj_budzet', 'centralny');
go
ALTER TABLE dbo.Projekty
ADD proj_budzet_id INT;

ALTER TABLE dbo.Projekty
ADD CONSTRAINT fk_proj_budzet FOREIGN KEY (proj_budzet_id)
REFERENCES dbo.DictionaryValues(dict_id);



