USE uni_library
GO

CREATE OR ALTER PROCEDURE ImportSurNames
AS
BEGIN
    CREATE TABLE russian_surnames
    (
        Name             NVARCHAR(max)
    )

    BULK INSERT russian_surnames
        FROM 'C:\psu-dbms\data\russian_surnames.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

END