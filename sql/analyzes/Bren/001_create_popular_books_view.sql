-- ~80ms
USE uni_library
GO
CREATE VIEW PopularBooks AS
SELECT TOP(10) Book_name, Count(*) AS Popularity
FROM Issues issues
INNER JOIN Instance I on issues.Instance_id = I.Instance_id
INNER JOIN Books B on I.Book_id = B.Book_id
GROUP BY B.Book_name
ORDER BY Popularity DESC