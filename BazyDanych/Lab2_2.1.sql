Use AdventureWorks2019
go
DECLARE @zmienna_tabelaryczna TABLE (
    ID INT,
    Name NVARCHAR(50)
);

DECLARE @zmienna_skalarna INT;

INSERT INTO @zmienna_tabelaryczna (ID, Name)
VALUES
    (1, 'Rekord1'),
    (2, 'Rekord2'),
    (3, 'Rekord3');

SET @zmienna_skalarna = (SELECT COUNT(*) FROM @zmienna_tabelaryczna);

IF @zmienna_skalarna > 2
BEGIN
    PRINT 'Liczba rekordów jest większa niż 2.';
END
ELSE
BEGIN
    PRINT 'Liczba rekordów jest mniejsza lub równa 2.';
END;
GO

CREATE PROCEDURE dbo.SprawdzZmienna
AS
BEGIN
    DECLARE @zmienna_tabelaryczna TABLE (
        ID INT,
        Name NVARCHAR(50)
    );

    DECLARE @zmienna_skalarna INT;

    INSERT INTO @zmienna_tabelaryczna (ID, Name)
    VALUES
        (1, 'Rekord1'),
        (2, 'Rekord2'),
        (3, 'Rekord3');

    SET @zmienna_skalarna = (SELECT COUNT(*) FROM @zmienna_tabelaryczna);

    IF @zmienna_skalarna > 2
    BEGIN
        PRINT 'Liczba rekordów jest większa niż 2.';
    END
    ELSE
    BEGIN
        PRINT 'Liczba rekordów jest mniejsza lub równa 2.';
    END;
END;
GO
EXEC dbo.SprawdzZmienna;
