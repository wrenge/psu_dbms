USE uni_library
GO

CREATE OR ALTER PROCEDURE AddInstances @data BookInstancesList READONLY AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE book_cursor CURSOR FAST_FORWARD
                FOR SELECT book_id, cnt, year
                    FROM @data
            OPEN book_cursor

            DECLARE @book_id INT
            DECLARE @cnt INT
            DECLARE @year INT
            FETCH NEXT FROM book_cursor INTO @book_id, @cnt, @year
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    DECLARE @i INT = 0
                    WHILE @i < @cnt
                        BEGIN
                            INSERT INTO Instance (Book_id, Copy_condition, Copy_year) VALUES (@book_id, 100, @year)
                            SET @i = @i + 1
                        end
                    FETCH NEXT FROM book_cursor INTO @book_id, @cnt, @year
                end
            CLOSE book_cursor
            DEALLOCATE book_cursor
        COMMIT TRAN
    end try
    begin catch
        ROLLBACK TRAN
        THROW
    end catch
END