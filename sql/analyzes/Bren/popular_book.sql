SELECT Book_name, num_books
FROM (SELECT Books.Book_id, Count(*) AS num_books
      FROM Books
               INNER JOIN Instance I on Books.Book_id = I.Book_id
               INNER JOIN Issues I2 on I.Instance_id = I2.Instance_id
      GROUP BY Books.Book_id) AS agg
         INNER JOIN Books ON agg.Book_id = Books.Book_id
ORDER BY num_books DESC