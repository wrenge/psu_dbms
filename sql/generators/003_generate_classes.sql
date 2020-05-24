USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateClasses
AS
BEGIN
    CREATE TABLE #Classes_Staging
    (
        Name      NVARCHAR(max)
    )

    BULK INSERT #Classes_Staging
        FROM 'C:\psu-dbms\data\Classes.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    INSERT INTO Classes(Class_name)
    SELECT Name
    FROM #Classes_Staging

    DROP TABLE #Classes_Staging
END