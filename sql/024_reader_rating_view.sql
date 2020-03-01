CREATE OR ALTER VIEW reader_rating
AS SELECT Reader_id,
       SUM(IIF(Receive_date IS NOT NULL, Issue_count, 0)) AS Rating
FROM (SELECT COUNT(*) AS Issue_count, Reader_id, Receive_date
      FROM Issues
      GROUP BY Reader_id, Receive_date) as IcRi
GROUP BY Reader_id
