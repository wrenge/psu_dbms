USE uni_library
GO

CREATE OR ALTER PROCEDURE FinishRequests @data RequestIDList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE @finished INT = (SELECT COUNT(*)
                                     FROM Request R
                                     WHERE R.Request_id IN (SELECT D.request_id FROM @data D)
                                       AND Request_finish_date IS NOT NULL)

            IF (@finished > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(
                            N'%i из завершаемых заказов уже завершены',
                            @finished);
                    THROW 51000, @message, 19
                end

            UPDATE Request
            SET Request_finish_date = GETDATE()
            WHERE Request_id IN (SELECT D.request_id FROM @data D)

            --          На случай, если надо добавлять книги
--             DECLARE @list BookInstancesList
--             INSERT INTO @list
--             SELECT R.Book_id, R.Request_Quantity, GETDATE()
--             FROM @data D
--                      INNER JOIN Request R ON D.request_id = R.Request_id
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW
    end catch
end