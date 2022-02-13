USE uni_library
GO

CREATE OR ALTER PROCEDURE GeneratePublishers
AS
BEGIN
    CREATE TABLE #Publishers_Staging
    (
        Name NVARCHAR(max),
    )

    BULK INSERT #Publishers_Staging
        FROM '/usr/import/data/Publishers.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    DECLARE @name NVARCHAR(64)
    DECLARE @city_count INT = (SELECT COUNT(*) FROM City)
    DECLARE names_cursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT DISTINCT Name FROM #Publishers_Staging

    OPEN names_cursor
    FETCH NEXT FROM names_cursor INTO @name
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @city_id INT = ABS(CHECKSUM(NEWID())) % @city_count + 1
            INSERT INTO Publisher(Publisher_name, City_id) VALUES (@name, @city_id)
            FETCH NEXT FROM names_cursor INTO @name
        end
    CLOSE names_cursor
    DEALLOCATE names_cursor

    DROP TABLE #Publishers_Staging
END