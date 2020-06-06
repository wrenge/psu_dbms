ALTER VIEW ReaderIssuesView AS
    SELECT R2.Reader_id,
           Reader_surname,
           Reader_name,
           Registration_date,
           Exclusion_date,
           Issue_date,
           Receive_date,
           Return_date
    FROM Issues I
             INNER JOIN Readers R2 on I.Reader_id = R2.Reader_id