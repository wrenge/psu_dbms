SELECT Publisher_name, C.City_name, agg.Num_books
FROM Publisher
         INNER JOIN
     (SELECT P.Publisher_id, SUM(Books.Total_count) as Num_books
      FROM Books
               INNER JOIN Publisher P on Books.Publisher_id = P.Publisher_id
      GROUP BY P.Publisher_id) as agg ON agg.Publisher_id = Publisher.Publisher_id
         INNER JOIN City C on Publisher.City_id = C.City_id
ORDER BY agg.Num_books DESC