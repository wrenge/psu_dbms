CREATE OR REPLACE PROCEDURE generate_groups(p_start_year INT) AS
$$
DECLARE
    v_group_name         TEXT;
    v_end_year           INT = 20;
    v_faculty_count      INT = (SELECT COUNT(*)
                                FROM faculties);
    v_group_type_id      INT = (SELECT type_id
                                FROM grouptype
                                WHERE type_name = N'Группа');
    v_department_type_id INT = (SELECT type_id
                                FROM grouptype
                                WHERE type_name = N'Кафедра');
    v_faculty_id         INT = 0;
    v_full_name          VARCHAR(32);
    v_department_name    VARCHAR(32);
BEGIN
    CREATE TEMPORARY TABLE group_names
    (
        name TEXT
    );

    INSERT INTO group_names(name) VALUES ('ВИС');
    INSERT INTO group_names(name) VALUES ('ВПИ');
    INSERT INTO group_names(name) VALUES ('ВПЭ');
    INSERT INTO group_names(name) VALUES ('ПФ');
    INSERT INTO group_names(name) VALUES ('ПЭН');
    INSERT INTO group_names(name) VALUES ('ПКТ');
    INSERT INTO group_names(name) VALUES ('МТШ');
    INSERT INTO group_names(name) VALUES ('МСЛ');
    INSERT INTO group_names(name) VALUES ('МТБ');

    FOR v_group_name IN SELECT DISTINCT group_names.name FROM group_names
        LOOP
            v_faculty_id = ABS(hash_numeric(nextval('random_counter'))) % v_faculty_count + 1;
            FOR i IN p_start_year..v_end_year
                LOOP
                    v_full_name = CONCAT(i, v_group_name);
                    INSERT INTO groups(group_name, faculty_id, type_id)
                    VALUES (v_full_name, v_faculty_id, v_group_type_id);
                END LOOP;
            v_department_name = CONCAT(N'Кафедра ', v_group_name);
            INSERT INTO groups(group_name, faculty_id, type_id)
            VALUES (v_department_name, v_faculty_id, v_department_type_id);
        END LOOP;

    DROP TABLE group_names;
END;
$$ LANGUAGE plpgsql;