USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateFaculties
AS
BEGIN
    CREATE TABLE #Faculties_Staging
    (
        Name      NVARCHAR(max),
        ShortName NVARCHAR(max)
    )

    BULK INSERT #Faculties_Staging
        FROM '/usr/import/data/Faculties.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    INSERT INTO Faculties(Faculty_name, Faculty_acronym)
    SELECT Name, ShortName
    FROM #Faculties_Staging

    DROP TABLE #Faculties_Staging
END