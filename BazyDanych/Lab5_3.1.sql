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

ALTER TABLE dbo.Projekty
ADD CONSTRAINT ck_status CHECK (proj_status IN ('nowy', 'w trakcie', 'zakończony pozytywnie', 'zakończony negatywnie'));

GO
UPDATE dbo.Projekty
SET proj_status = 'nowy';
GO

INSERT INTO dbo.Projekty (proj_nazwa, proj_status)
VALUES ('Projekt Omega', 'zakończony pozytywnie');
GO
/*Tu bedzie fail*/
INSERT INTO dbo.Projekty (proj_nazwa, proj_status)
VALUES ('Projekt Invalid', 'invalid_status');

