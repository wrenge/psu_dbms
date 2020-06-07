USE uni_library
GO
CREATE OR ALTER TRIGGER BookTotalIncreaseTrigger
    ON Instance
    AFTER INSERT
    AS
BEGIN
    UPDATE Books
    SET Count += cnt,
    Total_count += cnt
    FROM (SELECT Book_id, COUNT(*) as cnt
          FROM inserted I1
          GROUP BY Book_id) t
             INNER JOIN Books B ON B.Book_id = t.Book_id
end
GO