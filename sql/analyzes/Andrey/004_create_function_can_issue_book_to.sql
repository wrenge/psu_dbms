-- ~113ms
CREATE OR REPLACE FUNCTION CanIssueBookTo(bookID INT, readerID INT)
    RETURNS BOOLEAN AS
$$
BEGIN
    IF (SELECT Count(*) FROM Booking WHERE Book_id = bookID AND Close_date IS NULL) <
       (SELECT Count FROM Books WHERE Book_id = bookID) THEN
        RETURN 1;
    ELSE
        IF (SELECT Count(*)
            FROM Readers R,
                 Books B
            WHERE Reader_id = @readerID
              AND Book_id = @bookID
              AND Reader_id IN (SELECT Q.Reader_id
                                FROM Booking Q
                                WHERE Book_id = B.Book_id
                                  AND Close_date IS NULL
                                ORDER BY Booking_id
                                LIMIT B.count)) > 0 THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END IF;
END;
$$ LANGUAGE plpgsql