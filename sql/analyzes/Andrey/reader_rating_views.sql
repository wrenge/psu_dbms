DECLARE @min_date DATETIME = '01-01-2010' -- нижняя граница диапазона
DECLARE @max_date DATETIME = '01-01-2012'; -- верхняя граница диапазона

WITH tmp AS
         (SELECT Reader_name, Reader_surname, 0.2 AS rating
          FROM ReaderIssuesView
          WHERE @max_date BETWEEN Issue_date AND COALESCE(Receive_date, '31.12.9999')
            AND @min_date BETWEEN Registration_date AND Exclusion_date
          UNION ALL
          SELECT Reader_name, Reader_surname, -1.2
          FROM ReaderIssuesView
          WHERE @max_date BETWEEN Return_date AND COALESCE(Receive_date, '31.12.9999')
            AND @min_date BETWEEN Registration_date AND Exclusion_date
          UNION ALL
          SELECT ReaderIssuesView.Reader_name, ReaderIssuesView.Reader_surname, -0.4
          FROM ReaderIssuesView
          WHERE @max_date > COALESCE(Receive_date, '31.12.9999')
            AND @min_date BETWEEN Registration_date AND Exclusion_date)
SELECT Reader_name, Reader_surname, sum(tmp.rating) rating
FROM tmp
GROUP BY Reader_name, Reader_surname
ORDER BY rating DESC