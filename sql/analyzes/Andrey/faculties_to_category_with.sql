-- ~140ms
WITH tmp (Faculty_id, Category_id, num) as
         (SELECT Faculty_id, Category_id, Count(*) as num
          FROM Issues
                   INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                   INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                   INNER JOIN Books B on I.Book_id = B.Book_id
                   INNER JOIN Groups G2 on R2.Group_id = G2.Group_id
          GROUP BY Faculty_id, Category_id)
SELECT F.Faculty_name, C.Category_name
FROM tmp t
         INNER JOIN Category C ON t.Category_id = C.Category_id
         INNER JOIN Faculties F ON t.Faculty_id = F.Faculty_id
WHERE NOT EXISTS(SELECT tmp.Faculty_id FROM tmp WHERE t.Faculty_id = tmp.Faculty_id AND t.num < tmp.num)
ORDER BY F.Faculty_name