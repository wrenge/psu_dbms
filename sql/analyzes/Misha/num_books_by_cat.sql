SELECT Category_name, Count(*) as Num_books
FROM Instance
         INNER JOIN Books B on Instance.Book_id = B.Book_id
         INNER JOIN Category C on B.Category_id = C.Category_id
GROUP BY C.Category_name