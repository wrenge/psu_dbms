USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateBooking @count INT
AS
BEGIN

    DECLARE @i INT = 0
    DECLARE @status_count INT = (SELECT COUNT(*) FROM BookingStatus)
    WHILE @i < @count
        BEGIN
            DECLARE @book_id INT = (SELECT TOP (1) Book_id FROM Books ORDER BY ABS(CHECKSUM(NEWID())))
            DECLARE @reader_id INT
            DECLARE @from_date DATETIME
            DECLARE @to_date DATETIME

            SELECT TOP (1) @reader_id = Reader_id, @from_date = Registration_date, @to_date = Exclusion_date
            FROM Readers
            ORDER BY ABS(CHECKSUM(NEWID()))

            DECLARE @booking_date DATETIME = DATEADD(DAY, CHECKSUM(NEWID()) % DATEDIFF(DAY, @from_date, @to_date),
                                                     @from_date)
            DECLARE @end_date DATETIME = DATEADD(year, 3, @booking_date)
            DECLARE @close_date DATETIME = NULL
            DECLARE @status_id INT = NULL
            IF CHECKSUM(NEWID()) > 0
                BEGIN
                    SET @close_date = DATEADD(DAY, CHECKSUM(NEWID()) % DATEDIFF(DAY, @from_date, @end_date),
                                                     @from_date)
                    SET @status_id = ABS(CHECKSUM(NEWID())) % @status_count + 1
                end

            INSERT INTO Booking(Book_id, End_date, Reader_id, Close_date, Status_id)
            VALUES (@book_id, @end_date, @reader_id, @close_date, @status_id)
            SET @i = @i + 1
        end
END