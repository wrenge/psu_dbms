USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateInstances @instance_per_book INT
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
            WHILE @i < @instance_per_book
                BEGIN
                    DECLARE @copy_condition INT = ABS(CHECKSUM(NEWID())) % 101
                    DECLARE @copy_year INT = ABS(CHECKSUM(NEWID())) % 21 + 2000
                    INSERT INTO Instance(Book_id, Copy_condition, Copy_year)
                    VALUES (@book_id, @copy_condition, @copy_year)
                    SET @i = @i + 1
                end
            FETCH NEXT FROM book_cursor INTO @book_id
        end
    CLOSE book_cursor
    DEALLOCATE book_cursor
END