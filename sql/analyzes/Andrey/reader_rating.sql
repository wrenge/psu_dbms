-- ~95ms
SELECT R.Reader_surname,
       R.Reader_name,
       CAST(IIF(t.overall = 0, 1.0, 1.0 - (t.missed + t.outdated * 0.2) / t.overall) AS REAL) AS rating
FROM (SELECT Reader_id,
             (SELECT Count(*)
              FROM Issues I
              WHERE R1.Reader_id = I.Reader_id
                AND I.Return_date IS NULL
                AND I.Receive_date < GETDATE())                               AS missed,
             (SELECT Count(*)
              FROM Issues I
              WHERE R1.Reader_id = I.Reader_id
                AND I.Return_date > I.Receive_date)                           AS outdated,
             (SELECT Count(*) FROM Issues I WHERE R1.Reader_id = I.Reader_id) AS overall
      FROM Readers R1) AS t
         INNER JOIN Readers R
                    ON t.Reader_id = R.Reader_id