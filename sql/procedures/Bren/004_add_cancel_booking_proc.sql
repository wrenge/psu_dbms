USE uni_library
GO

CREATE OR ALTER PROCEDURE CancelBooking @data BookingIDList READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE @finished INT = (SELECT COUNT(*)
                                     FROM Booking B
                                     WHERE B.Book_id IN (SELECT D.booking_id FROM @data D)
                                       AND Close_date IS NOT NULL)

            IF (@finished > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(
                            N'%i из отменяемых броней уже завершены',
                            @finished);
                    THROW 51000, @message, 19
                end

            UPDATE Booking
            SET Close_date = GETDATE(),
                Status_id  = 2
            WHERE Booking_id IN (SELECT D.booking_id FROM @data D)
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW
    end catch
end