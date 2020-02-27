SELECT Group_name, COUNT(*) AS missing_count
FROM Groups
         RIGHT JOIN Readers R2 on Groups.Group_id = R2.Group_id
         INNER JOIN Issues I on R2.Reader_id = I.Reader_id
WHERE Return_date < GETDATE() AND Receive_date IS NULL
GROUP BY Group_name
ORDER BY missing_count DESC