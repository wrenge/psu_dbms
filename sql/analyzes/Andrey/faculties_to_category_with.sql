-- ~140ms
DECLARE @min_date DATETIME = '01-01-2010' -- нижняя граница диапазона
DECLARE @max_date DATETIME = '08-01-2010'; -- верхняя граница диапазона
WITH tmp AS (SELECT Faculty_id,
                    Category_id,
                    Count(*) as num
             FROM Issues
                      INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                      INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                      INNER JOIN Books B on I.Book_id = B.Book_id
                      INNER JOIN Groups G2 on R2.Group_id = G2.Group_id
             WHERE Issue_date BETWEEN @min_date AND @max_date
             GROUP BY Faculty_id, Category_id, YEAR(Issue_date))
SELECT tt.Faculty_name, tt.Category_name
FROM (SELECT Faculty_name, MAX(Category_name) as Category_name
      FROM tmp t
               INNER JOIN Faculties F ON F.Faculty_id = t.Faculty_id
               INNER JOIN Category C ON C.Category_id = t.Category_id
      WHERE NOT EXISTS(SELECT tmp.Faculty_id
                       FROM tmp
                       WHERE t.Faculty_id = tmp.Faculty_id
                         AND t.num < tmp.num)
      GROUP BY Faculty_name) tt
ORDER BY tt.Faculty_name