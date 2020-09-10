USE uni_library
GO
CREATE TYPE dbo.BookInstancesList
AS TABLE
(
    book_id INT NOT NULL UNIQUE,
    cnt INT NOT NULL CHECK (cnt > 0),
    year INT NOT NULL
);
GO
