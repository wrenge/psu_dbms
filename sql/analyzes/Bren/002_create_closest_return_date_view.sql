-- ~307ms
USE uni_library
GO

CREATE VIEW ClosestReturnDate
AS
SELECT B.Book_name,
       (SELECT TOP (1) Return_date
        FROM Issues I1
                 INNER JOIN Instance I2 on I1.Instance_id = I2.Instance_id
        WHERE Receive_date IS NULL
          AND Return_date > GETDATE()
          AND B.Book_id = I2.Book_id
        ORDER BY Return_date) AS Return_date
FROM Books B