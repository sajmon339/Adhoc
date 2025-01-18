use AdventureWorks2019

go



DROP TABLE IF EXISTS dbo.Konta;

CREATE TABLE dbo.Konta (
    IdKonta INT PRIMARY KEY IDENTITY (1,1),
    Imie VARCHAR(50),
    Saldo DECIMAL(10, 2)
);

INSERT INTO dbo.Konta ( Imie, Saldo) VALUES
( 'Jan Kowalski', 1000.00),
( 'Anna Nowak', 1500.00);

GO
DROP PROCEDURE IF EXISTS dbo.ManageAccounts;
GO

CREATE PROCEDURE dbo.ManageAccounts
    @InterestRate DECIMAL(5, 2),
    @SimulateError BIT = 0
AS
BEGIN
    DECLARE @ErrorCode INT;
    DECLARE @TranCount INT;

    IF @@TRANCOUNT > 0
    BEGIN
        PRINT 'Transaction already active. Exiting to prevent recursion.';
        RETURN;
    END

    BEGIN TRANSACTION;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.Konta WHERE Imie = 'Marek Iksiński')
        BEGIN
            INSERT INTO dbo.Konta (Imie, Saldo)
            VALUES ('Marek Iksiński', 1000.00);

            PRINT 'Record successfully inserted into the table.';
        END

        UPDATE dbo.Konta
        SET Saldo = Saldo + (Saldo * @InterestRate / 100);

        PRINT 'Balances updated successfully.';

        IF @SimulateError = 1
        BEGIN
            PRINT 'Simulating an error...';
            DECLARE @SimulatedError INT = 1 / 0;
        END;

        COMMIT;
        PRINT 'Transaction committed successfully.';
    END TRY
    BEGIN CATCH
        SET @ErrorCode = ERROR_NUMBER();
        SET @TranCount = @@TRANCOUNT;

        IF @TranCount > 0
        BEGIN
            ROLLBACK;
            PRINT 'Transakcja została wycofana.';
        END;

        PRINT 'Kod błędu: ' + CAST(@ErrorCode AS VARCHAR);
    END CATCH;
END;

EXEC dbo.ManageAccounts @InterestRate = 1.2, @SimulateError = 0;


SELECT * FROM Konta
SELECT @@TRANCOUNT;