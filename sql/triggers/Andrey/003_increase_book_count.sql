USE uni_library
GO
CREATE TRIGGER BookIncreaseUpdateTrigger
    ON Issues
    AFTER UPDATE
    AS
BEGIN
    UPDATE Books
    SET Count = Count + cnt
    FROM (SELECT Book_id, COUNT(*) as cnt
          FROM inserted I1
                   INNER JOIN Instance I2 on I1.Instance_id = I2.Instance_id
          WHERE I1.Receive_date IS NOT NULL
          GROUP BY Book_id) t
             INNER JOIN Books B ON B.Book_id = t.Book_id
end
GO

USE uni_library
GO
CREATE TRIGGER BookIncreaseDeleteTrigger
    ON Issues
    AFTER DELETE
    AS
BEGIN
    UPDATE Books
    SET Count = Count + cnt
    FROM (SELECT Book_id, COUNT(*) as cnt
          FROM deleted I1
                   INNER JOIN Instance I2 on I1.Instance_id = I2.Instance_id
          GROUP BY Book_id) t
             INNER JOIN Books B ON B.Book_id = t.Book_id
end