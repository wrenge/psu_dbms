-- ~67ms
USE uni_library
GO
CREATE VIEW AverageBookCondition
AS
SELECT Book_name, AVG(Copy_condition) AS averageCond, AVG(Copy_year) AS averageYear
FROM Instance I
         INNER JOIN Books B on I.Book_id = B.Book_id
GROUP BY B.Book_name
