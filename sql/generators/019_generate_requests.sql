USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateRequests @min_date DATETIME
AS
BEGIN
    DECLARE @book_id NVARCHAR(64)

    DECLARE book_cursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT Book_id FROM Books

    OPEN book_cursor
    FETCH NEXT FROM book_cursor INTO @book_id
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @i INT = 0
            DECLARE @request_cost INT = ABS(CHECKSUM(NEWID())) % 1200 + 300
            DECLARE @request_quantity INT = ABS(CHECKSUM(NEWID())) % 200 + 1
            DECLARE @request_date DATETIME = DATEADD(YEAR, ABS(CHECKSUM(NEWID())) % 6 + 1, @min_date)
            INSERT INTO Request(Book_id, Request_cost, Request_Quantity, Request_date)
            VALUES (@book_id, @request_cost, @request_quantity, @request_date)
            SET @i = @i + 1
            FETCH NEXT FROM book_cursor INTO @book_id
        end
    CLOSE book_cursor
    DEALLOCATE book_cursor
END