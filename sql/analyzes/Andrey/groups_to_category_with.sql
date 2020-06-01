-- ~78 ms
WITH tmp (Group_id, Category_id, num) as
         (SELECT R2.Group_id, B.Category_id, Count(*) as num
          FROM Issues
                   INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                   INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                   INNER JOIN Books B on I.Book_id = B.Book_id
          GROUP BY R2.Group_id, B.Category_id)
SELECT G.Group_name, C.Category_name
FROM tmp t
         INNER JOIN Groups G on t.Group_id = G.Group_id
         INNER JOIN Category C ON t.Category_id = C.Category_id
WHERE NOT EXISTS(SELECT Group_id FROM tmp WHERE t.Group_id = Group_id AND t.num < num)
ORDER BY G.Group_name