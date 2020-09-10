USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateFiBooks @publisher_per_book INT
AS
BEGIN
    CREATE TABLE #Books_Staging
    (
        Name NVARCHAR(max),
    )

    BULK INSERT #Books_Staging
        FROM 'C:\psu-dbms\data\fiction_books.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    DECLARE @name NVARCHAR(64)
    DECLARE @publisher_count INT = (SELECT COUNT(*) FROM Publisher)
    DECLARE @author_count INT = (SELECT COUNT(*) FROM Author)
    DECLARE @category_id INT = (SELECT Category_id FROM Category WHERE Category_name = N'Художественная литература')

    DECLARE names_cursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT DISTINCT Name FROM #Books_Staging

    OPEN names_cursor
    FETCH NEXT FROM names_cursor INTO @name
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @i INT = 0
            DECLARE @author_id INT = ABS(CHECKSUM(NEWID())) % @author_count + 1
            WHILE @i < @publisher_per_book
                BEGIN
                    DECLARE @publisher_id INT = ABS(CHECKSUM(NEWID())) % @publisher_count + 1
                    INSERT INTO Books(Book_name, Author_id, Publisher_id, Subject_id, Category_id)
                    VALUES (@name, @author_id, @publisher_id, NULL, @category_id)
                    SET @i = @i + 1
                end
            FETCH NEXT FROM names_cursor INTO @name
        end
    CLOSE names_cursor
    DEALLOCATE names_cursor

    DROP TABLE #Books_Staging
END