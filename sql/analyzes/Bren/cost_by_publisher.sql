SELECT Publisher_name, total_cost
FROM Publisher
         INNER JOIN
     (SELECT P.Publisher_id, SUM(Request_Quantity) * SUM(Request_cost) as total_cost
      FROM Request
               INNER JOIN Books B on Request.Book_id = B.Book_id
               INNER JOIN Publisher P on B.Publisher_id = P.Publisher_id
      GROUP BY P.Publisher_id) AS agg ON agg.Publisher_id = Publisher.Publisher_id
ORDER BY total_cost DESC