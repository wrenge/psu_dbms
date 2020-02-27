SELECT Publisher_name, num_requests, total_quantity
FROM Publisher
         INNER JOIN
     (SELECT P.Publisher_id, Count(*) as num_requests, SUM(Request_Quantity) as total_quantity
      FROM Request
               INNER JOIN Books B on Request.Book_id = B.Book_id
               INNER JOIN Publisher P on B.Publisher_id = P.Publisher_id
      GROUP BY P.Publisher_id) AS agg ON agg.Publisher_id = Publisher.Publisher_id
ORDER BY total_quantity DESC, num_requests DESC