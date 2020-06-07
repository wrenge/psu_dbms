USE uni_library
GO
CREATE TRIGGER IssueTrigger
    ON Issues
    AFTER INSERT
    AS
BEGIN
    UPDATE Books
    SET Count = Count - cnt
    FROM (SELECT Book_id, COUNT(*) as cnt
          FROM inserted I1
                   INNER JOIN Instance I2 on I1.Instance_id = I2.Instance_id
          GROUP BY Book_id) t
             INNER JOIN Books B ON B.Book_id = t.Book_id
end