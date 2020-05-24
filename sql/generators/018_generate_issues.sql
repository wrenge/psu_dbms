USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateIssues @count INT
AS
BEGIN

    DECLARE @i INT = 0
    WHILE @i < @count
        BEGIN
            DECLARE @instance_id INT = (SELECT TOP (1) Instance_id FROM Instance ORDER BY ABS(CHECKSUM(NEWID())))
            DECLARE @reader_id INT
            DECLARE @from_date DATETIME
            DECLARE @to_date DATETIME

            SELECT TOP (1) @reader_id = Reader_id, @from_date = Registration_date, @to_date = Exclusion_date
            FROM Readers
            ORDER BY ABS(CHECKSUM(NEWID()))

            DECLARE @issue_date DATETIME = DATEADD(DAY, CHECKSUM(NEWID()) % DATEDIFF(DAY, @from_date, @to_date),
                                                     @from_date)
            DECLARE @return_date DATETIME = DATEADD(year, 3, @issue_date)
            DECLARE @receive_date DATETIME = NULL
            IF CHECKSUM(NEWID()) > 0
                BEGIN
                    SET @receive_date = DATEADD(DAY, CHECKSUM(NEWID()) % DATEDIFF(DAY, @from_date, @to_date),
                                                     @from_date)
                end

            INSERT INTO Issues(Reader_id, Instance_id, Issue_date, Receive_date, Return_date)
            VALUES (@reader_id, @instance_id, @issue_date, @receive_date, @return_date)
            SET @i = @i + 1
        end
END