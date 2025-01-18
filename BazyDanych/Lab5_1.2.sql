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
    DECLARE @InterestRateStr VARCHAR(10);

    BEGIN TRY
        BEGIN TRANSACTION;

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
            SELECT 1 / 0;
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

        SET @InterestRateStr = CAST(@InterestRate AS VARCHAR(10));

        RAISERROR (N'Uwaga, wystąpił błąd o numerze %d, gdy wprowadzono parametr wejściowy %s.',
                   10,
                   1,
                   @ErrorCode,
                   @InterestRateStr);

        PRINT 'Kod błędu: ' + CAST(@ErrorCode AS VARCHAR(10));
    END CATCH;
END;



EXEC dbo.ManageAccounts @InterestRate = 1.2, @SimulateError = 1;


SELECT * FROM Konta
