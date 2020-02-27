DECLARE @group_id INT;
DECLARE qcursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT Group_id
    FROM Groups
OPEN qcursor
FETCH qcursor INTO @group_id;
CREATE TABLE #temp
(
    Faculty_name VARCHAR(32),
    Category_name VARCHAR(256)
);
WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @group_name VARCHAR(32);
        DECLARE @category_name VARCHAR(256);
        SELECT TOP (1) @group_name = Group_name, @category_name = Category_name
        FROM Issues
                 INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                 INNER JOIN Groups G on R2.Group_id = G.Group_id
                 INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                 INNER JOIN Books B on I.Book_id = B.Book_id
                 INNER JOIN Category C on B.Category_id = C.Category_id
        WHERE G.Group_id = @group_id
        GROUP BY Category_name, Group_name
        ORDER BY Count(*) DESC;
        INSERT INTO #temp VALUES (@group_name, @category_name);
        FETCH qcursor INTO @group_id;
    END
CLOSE qcursor;
DEALLOCATE qcursor;
SELECT *
FROM #temp
DROP TABLE #temp