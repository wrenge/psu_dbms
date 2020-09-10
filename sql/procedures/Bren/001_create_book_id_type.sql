USE uni_library
GO
CREATE TYPE dbo.BookIDList
AS TABLE
(
    book_id INT UNIQUE
);
GO
