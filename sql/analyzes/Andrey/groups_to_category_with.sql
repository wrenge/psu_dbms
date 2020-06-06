-- ~78 ms
DECLARE @min_date DATETIME = '01-01-2010' -- нижняя граница диапазона
DECLARE @max_date DATETIME = '01-01-2011'; -- верхняя граница диапазона

WITH tmp AS (SELECT ROW_NUMBER() over (ORDER BY Category_id) AS row_number,
                    R2.Group_id,
                    B.Category_id,
                    Count(*)                                 AS num
             FROM Issues
                      INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                      INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                      INNER JOIN Books B on I.Book_id = B.Book_id
             WHERE Issue_date BETWEEN @min_date AND @max_date
             GROUP BY R2.Group_id, B.Category_id)
SELECT tt.Group_name, tt.Category_name
FROM (SELECT Group_name, MAX(Category_name) as Category_name
      FROM tmp t
               INNER JOIN Groups G on t.Group_id = G.Group_id
               INNER JOIN Category C ON t.Category_id = C.Category_id
      WHERE NOT EXISTS(SELECT Group_id
                       FROM tmp
                       WHERE t.Group_id = tmp.Group_id
                         AND t.num < tmp.num)
      GROUP BY Group_name) tt
ORDER BY tt.Group_name
