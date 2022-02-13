USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateCities
AS
BEGIN
    CREATE TABLE #Cities_Staging
    (
        Name      NVARCHAR(max),
    )

    BULK INSERT #Cities_Staging
        FROM '/usr/import/data/City.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    INSERT INTO City(City_name)
    SELECT Name
    FROM #Cities_Staging

    DROP TABLE #Cities_Staging
END