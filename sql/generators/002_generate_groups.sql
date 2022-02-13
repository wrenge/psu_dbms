USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateGroups @start_year INT
AS
BEGIN
    CREATE TABLE #Group_Names
    (
        Names NVARCHAR(max)
    )

    BULK INSERT #Group_Names
        FROM '/usr/import/data/Groups.csv'
        WITH
        (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';', --CSV field delimiter
        ROWTERMINATOR = '\n', --Use to shift the control to next row
        TABLOCK
        )

    DECLARE @group_name NVARCHAR(max)
    DECLARE @end_year INT = 20
    DECLARE @faculty_count INT = (SELECT COUNT(*) FROM Faculties)
    DECLARE @group_type_id INT = (SELECT Type_id FROM GroupType WHERE Type_name = N'Группа')
    DECLARE @department_type_id INT = (SELECT Type_id FROM GroupType WHERE Type_name = N'Кафедра')
    DECLARE names_cursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT DISTINCT Names FROM #Group_Names

    OPEN names_cursor
    FETCH NEXT FROM names_cursor INTO @group_name
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @i INT = @start_year
            DECLARE @faculty_id INT = ABS(CHECKSUM(NEWID())) % @faculty_count + 1
            WHILE @i <= @end_year
                BEGIN
                    DECLARE @full_name NVARCHAR(32) = CONCAT(@i, @group_name)
                    INSERT INTO Groups(Group_name, Faculty_id, Type_id) VALUES (@full_name, @faculty_id, @group_type_id)
                    SET @i = @i + 1
                END

            DECLARE @department_name NVARCHAR(32) = CONCAT(N'Кафедра ', @group_name)
            INSERT INTO Groups(Group_name, Faculty_id, Type_id)
            VALUES (@department_name, @faculty_id, @department_type_id)

            FETCH NEXT FROM names_cursor INTO @group_name
        END
    CLOSE names_cursor
    DEALLOCATE names_cursor

    DROP TABLE #Group_Names

END