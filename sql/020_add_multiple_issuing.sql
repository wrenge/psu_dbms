CREATE TYPE id_list AS TABLE
(
    id INT NOT NULL PRIMARY KEY
)
GO

CREATE OR ALTER PROCEDURE issue_books(@reader_id INT,
                                      @return_date DATE,
                                      @instances_list id_list READONLY)
AS
BEGIN
    INSERT INTO Issues(Reader_id, Instance_id, Issue_date, Return_date)
    SELECT @reader_id, id, GETDATE(), @return_date
    FROM @instances_list
END
GO

CREATE OR ALTER PROCEDURE receive_books(@reader_id INT,
                                        @instances_list id_list READONLY)
AS
BEGIN
    UPDATE Issues
    SET Return_date = GETDATE()
    WHERE Reader_id = @reader_id
      AND Instance_id IN
    (SELECT id FROM @instances_list)
END

GO