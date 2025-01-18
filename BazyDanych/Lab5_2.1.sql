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

DROP TABLE IF EXISTS dbo.PracownicyProjekty;
GO
CREATE TABLE dbo.PracownicyProjekty (
    pracproj_id INT IDENTITY(1,1) PRIMARY KEY,
    pracproj_id_prac INT NOT NULL,
    pracproj_id_proj INT NOT NULL,
    FOREIGN KEY (pracproj_id_prac) REFERENCES dbo.Pracownicy(prac_id),
    FOREIGN KEY (pracproj_id_proj) REFERENCES dbo.Projekty(proj_id)
);
GO
DECLARE @prac_id INT;
DECLARE @prac_projekty VARCHAR(MAX);
DECLARE @proj_id INT;
DECLARE @start INT;
DECLARE @length INT;

DECLARE prac_cursor CURSOR FOR
SELECT prac_id, prac_projekty
FROM dbo.Pracownicy
WHERE prac_projekty IS NOT NULL;

OPEN prac_cursor;

FETCH NEXT FROM prac_cursor INTO @prac_id, @prac_projekty;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @start = 1;
    SET @proj_id = NULL;

    WHILE CHARINDEX(',', @prac_projekty, @start) > 0
    BEGIN
        SET @length = CHARINDEX(',', @prac_projekty, @start) - @start;
        SET @proj_id = CAST(SUBSTRING(@prac_projekty, @start, @length) AS INT);

        INSERT INTO dbo.PracownicyProjekty (pracproj_id_prac, pracproj_id_proj)
        VALUES (@prac_id, @proj_id);

        SET @start = CHARINDEX(',', @prac_projekty, @start) + 1;
    END

    IF LEN(@prac_projekty) >= @start
    BEGIN
        SET @proj_id = CAST(SUBSTRING(@prac_projekty, @start, LEN(@prac_projekty) - @start + 1) AS INT);

        INSERT INTO dbo.PracownicyProjekty (pracproj_id_prac, pracproj_id_proj)
        VALUES (@prac_id, @proj_id);
    END

    FETCH NEXT FROM prac_cursor INTO @prac_id, @prac_projekty;
END

CLOSE prac_cursor;
DEALLOCATE prac_cursor;
GO

ALTER TABLE dbo.Pracownicy DROP COLUMN prac_projekty;
GO

SELECT * FROM dbo.PracownicyProjekty;
GO
SELECT p.prac_imie, p.prac_nazwisko, pr.proj_nazwa
FROM dbo.PracownicyProjekty pp
JOIN dbo.Pracownicy p ON pp.pracproj_id_prac = p.prac_id
JOIN dbo.Projekty pr ON pp.pracproj_id_proj = pr.proj_id;
GO
