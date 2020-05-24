USE uni_library
GO

CREATE OR ALTER PROCEDURE RandomPerson @Name NVARCHAR(max) OUTPUT,
                              @SurName NVARCHAR(max) OUTPUT,
                              @Patronymic NVARCHAR(max) OUTPUT
AS
BEGIN
    DECLARE @sex NVARCHAR(max)
    SELECT TOP (1) @sex = Sex, @Name = Name
    FROM russian_names
    ORDER BY ABS(CHECKSUM(NEWID()))

    SELECT TOP (1) @SurName = Name
    FROM russian_surnames
    ORDER BY ABS(CHECKSUM(NEWID()))

    SELECT TOP (1) @Patronymic = Name
    FROM russian_surnames
    ORDER BY -ABS(CHECKSUM(NEWID()))

    IF @sex = N'Ж'
        BEGIN
            SET @SurName = CONCAT(@SurName, N'а')
            SET @Patronymic = CONCAT(@Patronymic, N'на')
        END
    ELSE
        BEGIN
            SET @Patronymic = CONCAT(@Patronymic, N'ич')
        END
END