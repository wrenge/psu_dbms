USE uni_library
GO
CREATE TYPE dbo.BookDataList
AS TABLE
(
    book_name NVARCHAR(128),
    author_id INT NOT NULL,
    publisher_id INT NOT NULL,
    subject_id INT DEFAULT NULL,
    category_id INT NOT NULL,
    count INT DEFAULT 0,
    year INT NOT NULL
);
GO
