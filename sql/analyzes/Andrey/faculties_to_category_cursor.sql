-- ~112 ms
DECLARE @faculty_id INT;
DECLARE qcursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT Faculty_id
    FROM Faculties
OPEN qcursor
FETCH qcursor INTO @faculty_id;
CREATE TABLE #temp
(
    Faculty_name  VARCHAR(32),
    Category_name VARCHAR(256)
);
WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @faculty_name VARCHAR(32);
        DECLARE @category_name VARCHAR(256);
        SELECT TOP (1) @faculty_name = Faculty_name, @category_name = Category_name
        FROM Issues
                 INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                 INNER JOIN Groups G on R2.Group_id = G.Group_id
                 INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                 INNER JOIN Books B on I.Book_id = B.Book_id
                 INNER JOIN Category C on B.Category_id = C.Category_id
                 INNER JOIN Faculties F on G.Faculty_id = F.Faculty_id
        WHERE G.Faculty_id = @faculty_id
        GROUP BY Category_name, Faculty_name
        ORDER BY Count(*) DESC;
        INSERT INTO #temp VALUES (@faculty_name, @category_name);
        FETCH qcursor INTO @faculty_id;
    END
CLOSE qcursor;
DEALLOCATE qcursor;
SELECT *
FROM #temp
DROP TABLE #temp