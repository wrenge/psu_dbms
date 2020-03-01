CREATE OR ALTER FUNCTION can_issue_book(@book_id INT)
    RETURNS INT
AS
BEGIN
    DECLARE @cnt INT
    SELECT @cnt = Count FROM Books WHERE Book_id = @book_id
    DECLARE @booked INT
    SELECT @booked = COUNT(*)
    FROM Booking
    WHERE Book_id = @book_id
      AND End_date IS NULL
    IF @cnt > @booked
        RETURN (1)
    RETURN (0)
END;
GO