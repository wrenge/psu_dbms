SELECT Author_surname, Author_name, Author_patronymic, num_books
FROM (SELECT A.Author_id, Count(*) AS num_books
      FROM Books
               INNER JOIN Instance I on Books.Book_id = I.Book_id
               INNER JOIN Issues I2 on I.Instance_id = I2.Instance_id
               INNER JOIN Author A on Books.Author_id = A.Author_id
      GROUP BY A.Author_id) AS agg
         INNER JOIN Author ON agg.Author_id = Author.Author_id
ORDER BY num_books DESC