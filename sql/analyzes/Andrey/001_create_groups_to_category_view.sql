-- ~77 ms
USE uni_library
GO
CREATE VIEW GroupsCategoriesIssuedBooks
AS
SELECT row_number() OVER ( ORDER BY YEAR(Issue_date)) AS row_number,
                 R2.Group_id,
                 B.Category_id,
                 Count(*)                                       AS num,
                 YEAR(Issue_date)                               AS year
          FROM Issues
                   INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                   INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                   INNER JOIN Books B on I.Book_id = B.Book_id
          GROUP BY R2.Group_id, B.Category_id, YEAR(Issue_date)

GO

CREATE VIEW GroupsToCategories AS
SELECT G.Group_name, C.Category_name
FROM (SELECT * FROM GroupsCategoriesIssuedBooks) t1
         INNER JOIN Groups G on t1.Group_id = G.Group_id
         INNER JOIN Category C ON t1.Category_id = C.Category_id
WHERE NOT EXISTS(SELECT Group_id
                 FROM (SELECT * FROM GroupsCategoriesIssuedBooks) as t2
                 WHERE t1.Group_id = t2.Group_id
                   AND (t1.num < t2.num OR t1.row_number < t2.row_number)
                   AND t1.year = t2.year)