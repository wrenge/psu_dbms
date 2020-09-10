-- ~72ms
USE uni_library
GO
CREATE VIEW NeededBooks
AS
SELECT Book_name, bookingCount, Count
FROM (SELECT B.Book_id, COUNT(*) AS bookingCount
      FROM Booking Q
               INNER JOIN Books B on Q.Book_id = B.Book_id
      WHERE Q.Close_date IS NULL
      GROUP BY B.Book_id) t
         INNER JOIN Books B ON t.Book_id = B.Book_id
