-- ~140ms
WITH tmp (row_number, Faculty_id, Category_id, num, year) as
         (SELECT row_number() OVER ( ORDER BY YEAR(Issue_date)),
                 Faculty_id,
                 Category_id,
                 Count(*)         as num,
                 YEAR(Issue_date) as year
          FROM Issues
                   INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                   INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                   INNER JOIN Books B on I.Book_id = B.Book_id
                   INNER JOIN Groups G2 on R2.Group_id = G2.Group_id
          GROUP BY Faculty_id, Category_id, YEAR(Issue_date))
SELECT F.Faculty_name, C.Category_name, t.year
FROM tmp t
         INNER JOIN Category C ON t.Category_id = C.Category_id
         INNER JOIN Faculties F ON t.Faculty_id = F.Faculty_id
WHERE NOT EXISTS(SELECT tmp.Faculty_id
                 FROM tmp
                 WHERE t.Faculty_id = tmp.Faculty_id
                   AND (t.num < tmp.num OR t.row_number < tmp.row_number)
                   AND t.year = tmp.year)
ORDER BY F.Faculty_name