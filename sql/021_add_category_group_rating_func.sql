CREATE OR ALTER FUNCTION category_group_rating(@start_date DATE, @end_date DATE)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT TOP 1 WITH TIES Group_name, Category_name
                FROM (SELECT COUNT(*) as count, Category_name, Group_name
                      FROM Issues
                               INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
                               INNER JOIN Books B on I.Book_id = B.Book_id
                               INNER JOIN Category C on B.Category_id = C.Category_id
                               INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
                               INNER JOIN Groups G on R2.Group_id = G.Group_id
                      WHERE Issue_date BETWEEN @start_date AND @end_date
                      GROUP BY Group_name, Category_name) AS cGnCn
                ORDER BY ROW_NUMBER() over (PARTITION BY Group_name ORDER BY count DESC)
            );
GO