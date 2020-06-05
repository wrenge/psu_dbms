-- ~91ms
USE uni_library
GO
CREATE VIEW FacultiesCategoriesIssuedBooks
AS
SELECT row_number() OVER ( ORDER BY YEAR(Issue_date)) as row_number,
       Faculty_id,
       Category_id,
       Count(*)         as num,
       YEAR(Issue_date) as year
FROM Issues
         INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
         INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
         INNER JOIN Books B on I.Book_id = B.Book_id
         INNER JOIN Groups G2 on R2.Group_id = G2.Group_id
GROUP BY Faculty_id, Category_id, YEAR(Issue_date)

GO

CREATE VIEW FacultiesToCategories AS
SELECT Faculty_name, C.Category_name, t1.year
FROM (SELECT * FROM FacultiesCategoriesIssuedBooks) t1
         INNER JOIN Category C ON t1.Category_id = C.Category_id
         INNER JOIN Faculties F on t1.Faculty_id = F.Faculty_id
WHERE NOT EXISTS(SELECT Faculty_id
                 FROM (SELECT * FROM FacultiesCategoriesIssuedBooks) as t2
                 WHERE t1.Faculty_id = t2.Faculty_id
                   AND (t1.num < t2.num OR t1.row_number < t2.row_number))