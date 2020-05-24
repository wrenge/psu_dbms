USE uni_library
GO

CREATE OR ALTER TRIGGER instance_total_count_increase
    ON Instance
    AFTER INSERT
    AS
BEGIN
    DECLARE @book_id INT;
    DECLARE @book_count INT;

    DECLARE trigger_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT B2.Book_id, Count(*)
        FROM inserted
                 INNER JOIN Books B2 on inserted.Book_id = B2.Book_id
        GROUP BY B2.Book_id;
    OPEN trigger_cursor;
    FETCH FROM trigger_cursor INTO @book_id, @book_count;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Books
            SET Count       = Count + @book_count,
                Total_count = Total_count + @book_count
            WHERE Book_id = @book_id;
            FETCH FROM trigger_cursor INTO @book_id, @book_count;
        END
END
GO

CREATE OR ALTER TRIGGER instance_total_count_decrease
    ON Instance
    AFTER DELETE
    AS
BEGIN
    DECLARE @book_id INT;
    DECLARE @book_count INT;

    DECLARE trigger_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT B2.Book_id, Count(*)
        FROM deleted
                 INNER JOIN Books B2 on deleted.Book_id = B2.Book_id
        GROUP BY B2.Book_id;
    OPEN trigger_cursor;
    FETCH FROM trigger_cursor INTO @book_id, @book_count;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Books
            SET Count       = Count - @book_count,
                Total_count = Total_count - @book_count
            WHERE Book_id = @book_id;
            FETCH FROM trigger_cursor INTO @book_id, @book_count;
        END
END
GO