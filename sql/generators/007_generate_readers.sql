USE uni_library
GO

CREATE OR ALTER PROCEDURE GenerateReaders @count INT, @min_date DATETIME
AS
BEGIN
    DECLARE @i INT = 0
    DECLARE @Name NVARCHAR(max)
    DECLARE @SurName NVARCHAR(max)
    DECLARE @Patronymic NVARCHAR(max)
    DECLARE @max_interval INT = 2020 - YEAR(@min_date)
    DECLARE @student_class_id INT
    SELECT @student_class_id = Class_id FROM Classes WHERE Class_name = N'Студент'
    DECLARE @group_type_id INT = (SELECT Type_id FROM GroupType WHERE Type_name = N'Группа')
    DECLARE @department_type_id INT = (SELECT Type_id FROM GroupType WHERE Type_name = N'Кафедра')

    WHILE @i < @count
        BEGIN
            EXEC RandomPerson @Name OUTPUT, @SurName OUTPUT, @Patronymic OUTPUT
            DECLARE @random_years INT = (ABS(CHECKSUM(NEWID()))) % @max_interval
            DECLARE @registration_date DATETIME = DATEADD(year, @random_years, @min_date)
            DECLARE @exclusion_date DATETIME = DATEADD(year, (ABS(CHECKSUM(NEWID()))) % 6 + 1, @registration_date)
            DECLARE @class_id INT
            IF CHECKSUM(NEWID()) > 0
                SELECT @class_id = @student_class_id
            ELSE
                SELECT TOP (1) @class_id = Class_id FROM Classes ORDER BY CHECKSUM(NEWID())

            DECLARE @group_year INT = YEAR(@registration_date) % 100
            DECLARE @group_id INT
            IF @class_id = @student_class_id
                BEGIN
                    SELECT TOP (1) @group_id = Group_id
                    FROM Groups
                    WHERE SUBSTRING(Group_name, 1, 2) = CONVERT(NVARCHAR(2), @group_year) AND Type_id = @group_type_id
                    ORDER BY CHECKSUM(NEWID())
                END
            ELSE
                BEGIN
                    SELECT TOP (1) @group_id = Group_id
                    FROM Groups
                    WHERE Type_id = @department_type_id
                    ORDER BY CHECKSUM(NEWID())
                END

            INSERT INTO Readers(Reader_surname, Reader_name, Reader_patronymic, Group_id, Class_id, Registration_date,
                                Exclusion_date)
            VALUES (@SurName, @Name, @Patronymic, @group_id, @class_id, @registration_date, @exclusion_date)

            SET @i = @i + 1
        END
END