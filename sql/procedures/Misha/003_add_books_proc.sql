USE uni_library
GO

CREATE OR ALTER PROCEDURE AddBooks @data BookDataList READONLY AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
            DECLARE @existing_book_cnt INT = (SELECT COUNT(*)
                                              FROM Books B
                                              WHERE EXISTS(SELECT *
                                                           FROM @data D
                                                           WHERE D.book_name = B.Book_name
                                                             AND D.author_id = B.Author_id
                                                             AND D.publisher_id = B.Publisher_id))
            IF (@existing_book_cnt > 0)
                BEGIN
                    DECLARE @message VARCHAR(MAX) = FORMATMESSAGE(
                            N'%i из добавляемых книг уже существуют. Используйте AddInstances',
                            @existing_book_cnt);
                    THROW 51000, @message, 20
                end

            IF (SELECT TOP (1) COUNT(*) FROM @data D GROUP BY book_name, author_id, publisher_id) > 1
                THROW 51000, N'Нельзя добавлять одинаковые книги', 24

            DECLARE @list BookInstancesList
            DECLARE @inserted TABLE
                              (
                                  book_id      INT,
                                  book_name    NVARCHAR(128),
                                  author_id    INT,
                                  publisher_id INT
                              )

            INSERT INTO Books(Book_name, Author_id, Publisher_id, Subject_id, Category_id)
            OUTPUT inserted.Book_id, inserted.Book_name, inserted.Author_id, inserted.Publisher_id INTO @inserted
            SELECT D.book_name, D.author_id, D.publisher_id, D.subject_id, D.category_id
            FROM @data D

            INSERT INTO @list
            SELECT I.book_id, D.count, D.year
            FROM @data D,
                 @inserted I
            WHERE I.book_name = D.book_name
              AND I.author_id = D.author_id
              AND I.publisher_id = D.publisher_id
            EXEC AddInstances @list
        COMMIT TRAN;
    end try
    begin catch
        ROLLBACK TRAN;
        THROW
    end catch
END