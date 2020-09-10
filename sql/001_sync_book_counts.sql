USE uni_library
GO

UPDATE Books
SET Total_count = cnt
FROM (SELECT Book_id, Count(*) as cnt
      FROM Instance
      GROUP BY Book_id) t
         INNER JOIN Books B ON B.Book_id = t.Book_id

UPDATE Books
SET Count = B.Total_count - cnt
FROM (SELECT Book_id, Count(*) as cnt
      FROM Issues issues
               INNER JOIN Instance I on issues.Instance_id = I.Instance_id
      WHERE issues.Return_date < GETDATE()
      GROUP BY Book_id) t
         INNER JOIN Books B ON B.Book_id = t.Book_id