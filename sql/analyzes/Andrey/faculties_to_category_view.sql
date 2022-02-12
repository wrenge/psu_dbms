-- ~140ms
WITH tmp AS (SELECT Faculty_name,
                    Category_name,
                    Count(*) as num
             FROM FacultiesCategoriesIssuedBooks
             WHERE Issue_date BETWEEN '01-01-2000' AND '08-01-2020'
             GROUP BY Faculty_name, Category_name, EXTRACT(YEAR FROM Issue_date))
SELECT tt.Faculty_name, tt.Category_name
FROM (SELECT Faculty_name, MAX(Category_name) as Category_name
      FROM tmp t
      WHERE NOT EXISTS(SELECT tmp.Faculty_name
                       FROM tmp
                       WHERE t.Faculty_name = tmp.Faculty_name
                         AND t.num < tmp.num)
      GROUP BY Faculty_name) tt
ORDER BY tt.Faculty_name