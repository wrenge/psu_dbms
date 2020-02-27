SELECT Author_surname, Author_name, Author_patronymic, agg.Num_books
FROM (SELECT A.Author_id, SUM(Books.Total_count) as Num_books
      FROM Books
               INNER JOIN Author A on Books.Author_id = A.Author_id
      GROUP BY A.Author_id) AS agg
         INNER JOIN Author ON agg.Author_id = Author.Author_id
ORDER BY Num_books DESC