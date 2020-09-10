DECLARE @min_date DATETIME = '01-01-2010' -- нижняя граница диапазона
DECLARE @max_date DATETIME = '01-01-2012'; -- верхняя граница диапазона

WITH tmp AS
         (SELECT Reader_id, 0.2 AS rating
          FROM Issues
          WHERE @max_date BETWEEN Issue_date AND COALESCE(Receive_date, '31.12.9999')
          UNION ALL
          SELECT Reader_id, -1.2
          FROM Issues
          WHERE @max_date BETWEEN Return_date AND COALESCE(Receive_date, '31.12.9999')
          UNION ALL
          SELECT Reader_id, -0.4
          FROM Issues
          WHERE @max_date > COALESCE(Receive_date, '31.12.9999'))
SELECT Reader_name, Reader_surname, sum(tmp.rating) rating
FROM tmp
         INNER JOIN Readers ON tmp.Reader_id = Readers.Reader_id
WHERE @min_date BETWEEN Registration_date AND Exclusion_date
GROUP BY Reader_name, Reader_surname
ORDER BY rating DESC