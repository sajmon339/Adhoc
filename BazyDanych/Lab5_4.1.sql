    DROP TABLE IF EXISTS dbo.Projekty
    GO
    CREATE TABLE dbo.Projekty (
    proj_id INT PRIMARY KEY IDENTITY,
    proj_nazwa VARCHAR(20)
    );


GO

ALTER TABLE dbo.Projekty ADD proj_umowa_plik VARBINARY(MAX);

GO
SELECT * FROM dbo.Projekty

INSERT INTO dbo.Projekty (proj_nazwa, proj_umowa_plik)
SELECT 'Projekt Delta', *
FROM OPENROWSET(BULK '/var/opt/mssql/data/output.png', SINGLE_BLOB) rs;
go
insert  into dbo.Projekty (proj_nazwa)
VALUES('Project Alpha')
GO

DROP PROC IF EXISTS dbo.usp_LoadProjectImage

GO
CREATE PROC dbo.usp_LoadProjectImage
    @Path NVARCHAR(MAX),
    @ProjectName NVARCHAR(20)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)

    DECLARE PathCursor CURSOR FOR
    SELECT proj_nazwa
    FROM dbo.Projekty
    WHERE proj_umowa_plik IS NULL;

    OPEN PathCursor
    FETCH NEXT FROM PathCursor INTO @ProjectName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            SET @SQL = '
                UPDATE dbo.Projekty
                SET proj_umowa_plik = (SELECT * FROM OPENROWSET(BULK N''' + @Path + ''', SINGLE_BLOB) rs)
                WHERE proj_nazwa = N''' + @ProjectName + ''';'
            PRINT(@SQL)
            EXEC sp_executesql @SQL
        END TRY
        BEGIN CATCH
            PRINT 'Error processing file: ' + @Path
        END CATCH

        FETCH NEXT FROM PathCursor INTO @ProjectName
    END

    CLOSE PathCursor
    DEALLOCATE PathCursor
END
GO


EXEC dbo.usp_LoadProjectImage '/var/opt/mssql/data/output.png','Project Alpha'


SELECT * FROM dbo.Projekty