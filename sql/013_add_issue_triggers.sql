USE uni_library
GO
CREATE OR ALTER TRIGGER on_issue_book
    ON Issues
    AFTER INSERT
    AS
BEGIN
    DECLARE @book_id INT;
    DECLARE @book_count INT;
    DECLARE trigger_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT B2.Book_id, Count(*)
        FROM inserted
                 INNER JOIN Instance I1 ON I1.Instance_id = inserted.Instance_id
                 INNER JOIN Books B2 on I1.Book_id = B2.Book_id
        WHERE inserted.Receive_date IS NULL
        GROUP BY B2.Book_id;
    OPEN trigger_cursor;
    FETCH FROM trigger_cursor INTO @book_id, @book_count;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Books
            SET Count = Count - @book_count
            FROM Books
            WHERE Books.Book_id = @book_id;
            FETCH FROM trigger_cursor INTO @book_id, @book_count;
        END
    CLOSE trigger_cursor;
    DEALLOCATE trigger_cursor;
END
GO

CREATE OR ALTER TRIGGER on_return_book
    ON Issues
    AFTER UPDATE
    AS
BEGIN
    DECLARE @book_id INT;
    DECLARE @book_count INT;

    DECLARE trigger_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT B2.Book_id, Count(*)
        FROM inserted
                 INNER JOIN Instance I1 ON I1.Instance_id = inserted.Instance_id
                 INNER JOIN Books B2 on I1.Book_id = B2.Book_id
        WHERE inserted.Receive_date IS NOT NULL
          AND inserted.Issue_id IN (SELECT Issue_id FROM deleted WHERE deleted.Receive_date IS NULL)
        GROUP BY B2.Book_id;
    OPEN trigger_cursor;
    FETCH FROM trigger_cursor INTO @book_id, @book_count;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Books
            SET Count = Count + @book_count
            FROM Books
            WHERE Books.Book_id = @book_id;
            FETCH FROM trigger_cursor INTO @book_id, @book_count;
        END
    CLOSE trigger_cursor;
    DEALLOCATE trigger_cursor;
END
GO