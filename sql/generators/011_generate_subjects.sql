USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateSubjects
AS
BEGIN
    CREATE TABLE #Subjects_Staging
    (
        Name      NVARCHAR(max),
    )

    BULK INSERT #Subjects_Staging
        FROM 'C:\psu-dbms\data\subjects.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    INSERT INTO Subject(Subject_name)
    SELECT Name
    FROM #Subjects_Staging

    DROP TABLE #Subjects_Staging
END