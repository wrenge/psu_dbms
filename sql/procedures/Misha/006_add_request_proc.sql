USE uni_library
GO

CREATE OR ALTER PROCEDURE AddRequests @data RequestList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            INSERT INTO Request(Book_id, Request_cost, Request_Quantity, Request_date)
            SELECT D.Book_id, D.cost, D.quantity, GETDATE()
            FROM @data D
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW
    end catch
end