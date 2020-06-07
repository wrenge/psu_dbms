BEGIN TRAN
    DECLARE @list RequestList
    INSERT @list VALUES (1, 100, 10), (2, 100, 10)
    EXEC AddRequests @list
    DECLARE @list2 RequestIDList
    INSERT INTO @list2 SELECT TOP (SELECT COUNT(*) FROM @list) Request_id FROM Request ORDER BY Request_id DESC
    EXEC FinishRequests @list2
    SELECT TOP (SELECT COUNT(*) FROM @list) * FROM Request ORDER BY Request_id DESC
ROLLBACK TRAN