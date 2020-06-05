-- ~78 ms
WITH tmp (row_number, Group_id, Category_id, num, year) as
         (SELECT row_number() OVER ( ORDER BY YEAR(Issue_date)) AS row_number,
                 R2.Group_id,
                 B.Category_id,
                 Count(*)                                       AS num,
                 YEAR(Issue_date)                               AS year
          FROM Issues
                   INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                   INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                   INNER JOIN Books B on I.Book_id = B.Book_id
          GROUP BY R2.Group_id, B.Category_id, YEAR(Issue_date))
SELECT G.Group_name, C.Category_name, year
FROM tmp t
         INNER JOIN Groups G on t.Group_id = G.Group_id
         INNER JOIN Category C ON t.Category_id = C.Category_id
WHERE NOT EXISTS(SELECT Group_id
                 FROM tmp
                 WHERE t.Group_id = tmp.Group_id
                   AND (t.num < tmp.num OR t.row_number < tmp.row_number)
                   AND t.year = tmp.year)
ORDER BY G.Group_name