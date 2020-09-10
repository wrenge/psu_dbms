USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateAuthors @count INT
AS
BEGIN
    DECLARE @i INT = 0
    DECLARE @Name NVARCHAR(max)
    DECLARE @SurName NVARCHAR(max)
    DECLARE @Patronymic NVARCHAR(max)
    WHILE @i < @count
        BEGIN
            EXEC RandomPerson @Name OUTPUT, @SurName OUTPUT, @Patronymic OUTPUT
            INSERT INTO Author(Author_surname, Author_name, Author_patronymic)
            VALUES (@SurName, @Name, @Patronymic)

            SET @i = @i + 1
        END
END