USE AdventureWorks2019
GO


DECLARE @ExistingBusinessEntityID INT;

SELECT TOP 1 @ExistingBusinessEntityID = BusinessEntityID
FROM Person.BusinessEntity
WHERE BusinessEntityID NOT IN (SELECT BusinessEntityID FROM Person.Person)
AND BusinessEntityID NOT IN (SELECT BusinessEntityID FROM HumanResources.Employee);

DECLARE @NID VARCHAR(15)=(SELECT  SUBSTRING(REPLACE(CAST(NEWID() AS VARCHAR(36)), '-', ''), 1, 15))


IF @ExistingBusinessEntityID IS NOT NULL
BEGIN

    INSERT INTO Person.Person (
        BusinessEntityID,
        PersonType,
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        EmailPromotion,
        AdditionalContactInfo,
        Demographics,
        rowguid,
        ModifiedDate
    )
    VALUES (
        @ExistingBusinessEntityID, -- Use the existing BusinessEntityID
        'EM', -- Person type (e.g., 'EM' for employee)
        0, -- NameStyle (0 or 1)
        'Mr.',
        'John',
        'A.',
        'Doe',
        NULL,
        0,
        NULL,
        NULL,
        NEWID(),
        GETDATE()
    );


    INSERT INTO HumanResources.Employee (
        BusinessEntityID,
        NationalIDNumber,
        LoginID,
        OrganizationNode,
        JobTitle,
        BirthDate,
        MaritalStatus,
        Gender,
        HireDate,
        SalariedFlag,
        VacationHours,
        SickLeaveHours,
        CurrentFlag,
        rowguid,
        ModifiedDate
    )
    VALUES (
        @ExistingBusinessEntityID,
        @NID ,
        CONCAT('adventure-works\',NEWID()),
        hierarchyid::Parse('/1/1/1/'),
        'Software Developer',
        '1985-06-15',
        'M',
        'M',
        GETDATE(),
        1,
        10,
        5,
        1,
        NEWID(),
        GETDATE()
    );

    SELECT *
    FROM HumanResources.Employee 
    WHERE BusinessEntityID = @ExistingBusinessEntityID;
END
ELSE
BEGIN
    PRINT 'No available BusinessEntityID found to reuse.'
END;




