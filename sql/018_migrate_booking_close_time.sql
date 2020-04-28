UPDATE uni_library.dbo.Booking
    SET End_date = End_date
WHERE End_date < GETDATE()