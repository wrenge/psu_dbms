SELECT CAST(YEAR(Request_date) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(Request_date) AS VARCHAR(2)), 2) as date,
       SUM(Request.Request_cost) * SUM(Request.Request_Quantity) as sum
FROM Request
GROUP BY CAST(YEAR(Request_date) AS VARCHAR(4)) + '-' + right('00' + CAST(MONTH(Request_date) AS VARCHAR(2)), 2)
