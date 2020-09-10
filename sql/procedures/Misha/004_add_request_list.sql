USE uni_library
GO
CREATE TYPE dbo.RequestIDList
AS TABLE
(
    request_id INT UNIQUE
);
GO

CREATE TYPE dbo.RequestList
AS TABLE
(
    Book_id INT UNIQUE,
    cost MONEY,
    quantity INT CHECK(quantity > 0)
);
GO