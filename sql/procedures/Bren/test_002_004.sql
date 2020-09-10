BEGIN TRAN
    DECLARE @list BookIDList
    INSERT @list VALUES (1), (2)
    EXEC AddBooking 1, @list
    DECLARE @list2 BookingIDList
    INSERT INTO @list2 SELECT TOP (SELECT COUNT(*) FROM @list) Booking_id FROM Booking ORDER BY Booking_id DESC
    EXEC CancelBooking @list2
    SELECT TOP (SELECT COUNT(*) FROM @list) * FROM Booking ORDER BY Booking_id DESC
ROLLBACK TRAN