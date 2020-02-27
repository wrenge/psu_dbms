DECLARE @fac_id INT;
DECLARE qcursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT Faculty_id
    FROM Faculties
OPEN qcursor
FETCH qcursor INTO @fac_id;
CREATE TABLE #temp
(
    Faculty_name VARCHAR(256),
    Subject_name VARCHAR(256)
);
WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @faculty_name VARCHAR(256);
        DECLARE @subject_name VARCHAR(256);
        SELECT TOP (1) @Faculty_name = Faculty_name, @subject_name = Subject_name
        FROM Issues
                 INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                 INNER JOIN Groups G on R2.Group_id = G.Group_id
                 INNER JOIN Faculties F on G.Faculty_id = F.Faculty_id
                 INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                 INNER JOIN Books B on I.Book_id = B.Book_id
                 INNER JOIN Subject S on B.Subject_id = S.Subject_id
        WHERE F.Faculty_id = @fac_id
        GROUP BY Subject_name, Faculty_name
        ORDER BY Count(*) DESC;
        INSERT INTO #temp VALUES (@faculty_name, @subject_name);
        FETCH qcursor INTO @fac_id;
    END
CLOSE qcursor;
DEALLOCATE qcursor;
SELECT * FROM #temp
DROP TABLE #temp