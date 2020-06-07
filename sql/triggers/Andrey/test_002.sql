BEGIN TRAN
    DECLARE @list InstanceIDList
    INSERT @list VALUES (1), (199)
    EXEC IssueInstances @reader_id = 1, @ids = @list
    SELECT B.Book_id, Count, Total_count
    FROM Books B
             INNER JOIN Instance I on B.Book_id = I.Book_id
    WHERE Instance_id IN (SELECT * FROM @list)
ROLLBACK TRAN

SELECT Book_id, Count, Total_count FROM Books WHERE Book_id IN (1, 2)
