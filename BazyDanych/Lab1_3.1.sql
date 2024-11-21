USE AdventureWorks2019
go
ALTER TRIGGER trg_CheckIDOnInsert
ON dbo.Pracownicy
AFTER INSERT
AS
BEGIN
    DECLARE @NewID INT;

    -- Get the ID from the newly inserted record
    SELECT @NewID = ID FROM inserted;

    -- Check if the new ID is less than 10
    IF @NewID < 10
    BEGIN
        -- Rollback the transaction and raise an error
        ROLLBACK TRANSACTION;
        RAISERROR('Insertion of ID less than 10 is not allowed.', 16, 1);
    END;
END;
