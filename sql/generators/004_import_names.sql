USE uni_library
GO

CREATE OR ALTER PROCEDURE ImportNames
AS
BEGIN
    CREATE TABLE russian_names
    (
        Name             NVARCHAR(max),
        Sex              NVARCHAR(max),
    )

    BULK INSERT russian_names
        FROM '/usr/import/data/russian_names.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

END