CREATE OR REPLACE PROCEDURE generate_classes() AS
$$
BEGIN
    INSERT INTO classes(class_name)
    VALUES ('Студент'),
           ('Преподаватель'),
           ('Лаборант'),
           ('Системный администратор'),
           ('Сотрудник секретариата');
END;
$$ LANGUAGE plpgsql