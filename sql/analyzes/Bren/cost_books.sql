SELECT Book_name, Category_name, Subject_name, Total_cost
FROM Books
         INNER JOIN
     (SELECT R2.Book_id, SUM(Request_Quantity) * SUM(Request_cost) as Total_cost
      FROM Books
               INNER JOIN Request R2 on Books.Book_id = R2.Book_id
      GROUP BY R2.Book_id) AS agg ON agg.Book_id = Books.Book_id
         INNER JOIN Category C on Books.Category_id = C.Category_id
         LEFT JOIN Subject S on Books.Subject_id = S.Subject_id
ORDER BY Total_cost DESC