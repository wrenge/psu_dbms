-- ~113ms
USE uni_library
GO
CREATE OR ALTER FUNCTION CanIssueBookTo(@bookID INT, @readerID INT)
    RETURNS BIT
BEGIN
    IF (SELECT Count(*) FROM Booking WHERE Book_id = @bookID AND Close_date IS NULL) <
       (SELECT Count FROM Books WHERE Book_id = @bookID)
        RETURN 1
    ELSE
        BEGIN
            IF (SELECT Count(*)
                FROM Readers R,
                     Books B
                WHERE Reader_id = @readerID
                  AND Book_id = @bookID
                  AND Reader_id IN (SELECT TOP (B.Count) Q.Reader_id
                                    FROM Booking Q
                                    WHERE Book_id = B.Book_id
                                      AND Close_date IS NULL
                                    ORDER BY Booking_id)) > 0
                RETURN 1
        END
    RETURN 0
END