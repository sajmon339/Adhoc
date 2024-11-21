USE AdventureWorks2019
go
CREATE TRIGGER dbo.TRG_KontrolaDatyUrodzenia
ON dbo.Pracownicy
FOR INSERT
AS
BEGIN
    DECLARE @InsertedDate DATE;

    SELECT @InsertedDate = DataUrodzenia FROM inserted;

    IF @InsertedDate > GETDATE()
    BEGIN
        RAISERROR('Nie możesz wprowadzić daty z przyszłości!', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;



INSERT INTO dbo.Pracownicy (Id,Imie, Nazwisko, PESEL, DataUrodzenia)
VALUES (40,'Jan', 'Kowalski', 95111801111, '2099-01-01');  -- Future date
