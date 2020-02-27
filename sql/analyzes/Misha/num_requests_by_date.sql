SELECT CAST(YEAR(Request_date) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(Request_date) AS VARCHAR(2)), 2) as date,
       COUNT(Request_cost) as request_count
FROM Request
GROUP BY CAST(YEAR(Request_date) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(Request_date) AS VARCHAR(2)), 2)