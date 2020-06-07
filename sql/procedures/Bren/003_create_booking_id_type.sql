USE uni_library
GO
CREATE TYPE dbo.BookingIDList
AS TABLE
(
    booking_id INT UNIQUE
);
GO
