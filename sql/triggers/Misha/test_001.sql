BEGIN TRAN
    DECLARE @list BookInstancesList
    INSERT @list VALUES (1, 100, 2020)
    EXEC AddInstances @list
    SELECT Book_id, Count, Total_count
    FROM Books
    WHERE Book_id IN (SELECT Book_id FROM @list)
ROLLBACK TRAN

SELECT Book_id, Count, Total_count
    FROM Books
    WHERE Book_id IN (1)