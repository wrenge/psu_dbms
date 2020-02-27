DECLARE @class_id INT;
DECLARE @class_count INT;
DECLARE qcursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT R2.Class_id, COUNT(*)
    FROM Classes
             INNER JOIN Readers R2 on Classes.Class_id = R2.Class_id
    GROUP BY R2.Class_id
OPEN qcursor
FETCH qcursor INTO @class_id, @class_count;
CREATE TABLE #temp
(
    Class_name    VARCHAR(256),
    Class_booking INT
);
WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @class_name VARCHAR(256);
        DECLARE @class_booking INT;
        SELECT @class_name = Class_name, @class_booking = COUNT(*) * 100 / @class_count
        FROM Classes
                 INNER JOIN Readers R2 on Classes.Class_id = R2.Class_id
                 INNER JOIN Booking B on R2.Reader_id = B.Reader_id
        WHERE R2.Class_id = @class_id
        GROUP BY Class_name
        INSERT INTO #temp VALUES (@class_name, @class_booking);
        FETCH qcursor INTO @class_id, @class_count;
    END
CLOSE qcursor;
DEALLOCATE qcursor;
SELECT *
FROM #temp
ORDER BY Class_booking DESC
DROP TABLE #temp