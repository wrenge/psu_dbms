USE uni_library
GO
CREATE OR ALTER PROCEDURE IssueInstances @reader_id INT,
                                         @ids InstanceIDList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            IF (SELECT TOP (1) COUNT(*) cnt
                FROM @ids I1
                         INNER JOIN Instance I2 ON I1.instance_id = I2.Instance_id
                GROUP BY I2.Book_id
                ORDER BY cnt DESC) > 1
                THROW 51000, N'Нельзя выдать несколько экземпляров одной и той же книги', 14

            DECLARE @out_of_stock_cnt INT = (SELECT COUNT(*)
                                             FROM Issues
                                             WHERE EXISTS(SELECT * FROM @ids I WHERE I.instance_id = Issues.Instance_id)
                                               AND COALESCE(Receive_date, '31-12-9999') > GETDATE())
            IF (@out_of_stock_cnt > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(N'%i из запрошенных книг нет в наличии',
                                                                  @out_of_stock_cnt);
                    THROW 51000, @message, 24
                END

            IF (SELECT COUNT(*) FROM Readers WHERE @reader_id = Reader_id AND Exclusion_date > GETDATE()) <= 0
                THROW 51000, N'Выбранный читатель не может получать книги', 28

            INSERT INTO Issues(Reader_id, Instance_id, Issue_date, Return_date)
            SELECT @reader_id, instance_id, GETDATE(), DATEADD(year, 3, GETDATE()) FROM @ids
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW;
    end catch
END
