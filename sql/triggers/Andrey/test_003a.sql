BEGIN TRAN
    UPDATE Issues
    SET Receive_date = GETDATE()
    WHERE Receive_date IS NULL AND Instance_id IN (SELECT Instance_id FROM Instance WHERE Book_id = 1)
SELECT Book_id, Count, Total_count FROM Books WHERE Book_id = 1
ROLLBACK TRAN

SELECT Book_id, Count, Total_count FROM Books WHERE Book_id = 1