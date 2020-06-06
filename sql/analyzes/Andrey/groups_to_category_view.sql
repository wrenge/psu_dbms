-- ~78 ms
DECLARE @min_date DATETIME = '01-01-2010' -- нижняя граница диапазона
DECLARE @max_date DATETIME = '01-01-2011'; -- верхняя граница диапазона

WITH tmp AS (SELECT Group_name, Category_name, Count(*) AS num
             FROM GroupsCategoriesIssuedBooks
             WHERE Issue_date BETWEEN @min_date AND @max_date
             GROUP BY Group_name, Category_name)
SELECT tt.Group_name, tt.Category_name
FROM (SELECT Group_name, MAX(Category_name) as Category_name
      FROM tmp t
      WHERE NOT EXISTS(SELECT Group_name
                       FROM tmp
                       WHERE t.Group_name = tmp.Group_name
                         AND t.num < tmp.num)
      GROUP BY Group_name) tt
ORDER BY Group_name