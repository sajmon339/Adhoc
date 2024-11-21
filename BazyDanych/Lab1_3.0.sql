USE AdventureWorks2019
go

CREATE TRIGGER dbo.trg_CheckIDOnInsert
ON dbo.Pracownicy
AFTER INSERT
AS
BEGIN
    DECLARE @NewID INT;
    DECLARE @MaxID INT;

    SELECT @MaxID = ISNULL(MAX(ID), 0) FROM dbo.Pracownicy;

    SELECT @NewID = ID FROM inserted;

    IF @NewID < 10
    BEGIN
        UPDATE dbo.Pracownicy SET ID = @MaxID + 1 WHERE ID = @NewID;
    END;
END;





INSERT INTO dbo.Pracownicy (ID, Imie, Nazwisko, PESEL, DataUrodzenia)
VALUES (2, 'Jan', 'Kowalski', 12345678910, '1985-06-15');


SELECT * FROM dbo.Pracownicy;

INSERT INTO dbo.Pracownicy (ID, Imie, Nazwisko, PESEL, DataUrodzenia)
VALUES (12, 'Anna', 'Nowak', 23456789012, '1990-03-12');

SELECT * FROM dbo.Pracownicy;

INSERT INTO dbo.Pracownicy (ID, Imie, Nazwisko, PESEL, DataUrodzenia)
VALUES (3, 'Piotr', 'Zieliński', 34567890123, '1988-11-22');

SELECT * FROM dbo.Pracownicy;

INSERT INTO dbo.Pracownicy (ID, Imie, Nazwisko, PESEL, DataUrodzenia)
VALUES (4, 'Maria', 'Wiśniewska', 45678901234, '1992-07-09');


