USE uni_library
GO
CREATE OR ALTER PROCEDURE ReceiveInstances @ids InstanceIDList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE @in_stock_cnt INT = (SELECT COUNT(*)
                                             FROM Issues
                                             WHERE EXISTS(SELECT * FROM @ids I WHERE I.instance_id = Issues.Instance_id)
                                               AND COALESCE(Receive_date, '31-12-9999') < GETDATE())
            IF (@in_stock_cnt > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(N'%i из запрошенных книг уже есть в наличии',
                                                                  @in_stock_cnt);
                    THROW 51000, @message, 29
                END

            UPDATE Issues
            SET Receive_date = GETDATE()
            WHERE Instance_id IN (SELECT * FROM @ids)
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW;
    end catch
END
