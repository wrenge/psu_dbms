USE uni_library
GO
CREATE OR ALTER PROCEDURE AddBooking @reader_id INT,
                                     @data BookIDList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE @booked_cnt INT = (SELECT COUNT(*)
                                       FROM Booking B
                                       WHERE EXISTS(SELECT * FROM @data D WHERE D.book_id = B.Book_id)
                                         AND COALESCE(B.Close_date, '31-12-9999') > GETDATE()
                                         AND B.Reader_id = @reader_id)
            IF (@booked_cnt > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(N'%i из запрошенных книг уже забронированы',
                                                                  @booked_cnt);
                    THROW 51000, @message, 18
                END

            IF (SELECT COUNT(*) FROM Readers WHERE @reader_id = Reader_id AND Exclusion_date > GETDATE()) <= 0
                THROW 51000, N'Выбранный читатель не может бронировать книги', 22

            INSERT INTO Booking(Book_id, End_date, Reader_id)
            SELECT book_id, DATEADD(year, 3, GETDATE()), @reader_id
            FROM @data
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW;
    end catch
END
