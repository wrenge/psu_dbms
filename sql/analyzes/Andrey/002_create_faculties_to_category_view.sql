-- ~91ms
USE uni_library
GO
CREATE VIEW FacultiesCategoriesIssuedBooks
AS
SELECT Faculty_id, Category_id, Count(*) as num
FROM Issues
         INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
         INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
         INNER JOIN Books B on I.Book_id = B.Book_id
         INNER JOIN Groups G on R2.Group_id = G.Group_id
GROUP BY Faculty_id, Category_id

CREATE VIEW FacultiesToCategories AS
SELECT Faculty_name, C.Category_name
FROM (SELECT * FROM FacultiesCategoriesIssuedBooks) t1
         INNER JOIN Category C ON t1.Category_id = C.Category_id
         INNER JOIN Faculties F on t1.Faculty_id = F.Faculty_id
WHERE NOT EXISTS(SELECT Faculty_id
                 FROM (SELECT * FROM FacultiesCategoriesIssuedBooks) as t2
                 WHERE t1.Faculty_id = t2.Faculty_id
                   AND t1.num < t2.num)