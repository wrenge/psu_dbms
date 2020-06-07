BEGIN TRAN
DELETE FROM ReaderIssuesView WHERE Receive_date IS NULL
SELECT Book_id, Count, Total_count FROM Books
ROLLBACK TRAN

SELECT Book_id, Count, Total_count FROM Books
