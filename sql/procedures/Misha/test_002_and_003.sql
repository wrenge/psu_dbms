BEGIN TRAN
    DECLARE @list BookDataList
    INSERT @list VALUES (N'Привет', 1, 1, NULL, 1, 10, 2010), (N'Мир', 1, 1, NULL, 1, 10, 2010)
    EXEC AddBooks @list
    SELECT *
    FROM Books B INNER JOIN Instance I on B.Book_id = I.Book_id
    WHERE B.Book_id IN (SELECT TOP (2) B2.Book_id FROM Books B2 ORDER BY Book_id DESC)
ROLLBACK TRAN