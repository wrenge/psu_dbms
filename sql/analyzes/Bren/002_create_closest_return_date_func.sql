-- ~75ms
USE uni_library
GO

CREATE FUNCTION GetClosestReturnDate(@book_id INT)
    RETURNS DATETIME
BEGIN
    RETURN (SELECT TOP (1) issues.Return_date
    FROM Issues issues
             INNER JOIN Instance I on issues.Instance_id = I.Instance_id
             INNER JOIN Books B on I.Book_id = B.Book_id
    WHERE Receive_date IS NULL
      AND Return_date > GETDATE()
      AND B.Book_id = @book_id
    ORDER BY Return_date)
end