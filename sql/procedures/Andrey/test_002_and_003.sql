USE uni_library
GO
BEGIN TRAN
    DECLARE @list InstanceIDList
    INSERT @list VALUES (1000), (2000)
    EXEC IssueInstances @reader_id = 1, @ids = @list
    EXEC ReceiveInstances @list
    SELECT * FROM Issues WHERE Reader_id = 1
ROLLBACK TRAN