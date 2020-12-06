CREATE OR REPLACE PROCEDURE generate_readers(IN count INT,
                                             IN min_date TIMESTAMP) AS
$$
DECLARE
    _name               VARCHAR;
    _surname            VARCHAR;
    _patronymic         VARCHAR;
    _max_interval       INT;
    _student_class_id   INT;
    _group_type_id      INT;
    _department_type_id INT;
    _random_years       INT;
    _registration_date  TIMESTAMP;
    _exclusion_date     TIMESTAMP;
    _class_id           INT;
    _group_year         INT;
    _group_id           INT;
    _random_num         INT;
    _random_seed        REAL;
BEGIN
    _max_interval = 2020 - (SELECT extract(YEAR FROM min_date));
    _student_class_id = (SELECT class_id FROM classes WHERE class_name = 'Студент' LIMIT 1);
    _department_type_id = (SELECT type_id FROM grouptype WHERE type_name = 'Кафедра' LIMIT 1);
    _group_type_id = (SELECT type_id FROM grouptype WHERE type_name = 'Группа' LIMIT 1);
    FOR i IN 1..count
        LOOP
            _random_num = hash_numeric(nextval('random_counter'));
            _random_seed = CAST((_random_num % 10000) as real) / 10000;
            SELECT * FROM random_person() INTO _name, _surname, _patronymic;
            _random_years = ABS(_random_num) % _max_interval + 1;
            _registration_date = _random_years * INTERVAL '1 year' + min_date;
            _exclusion_date = (ABS(_random_num) % 6 + 1) * INTERVAL '1 year' + _registration_date;

            IF _random_num > 0 THEN
                _class_id = _student_class_id;
            ELSE
                SELECT classes.class_id, setseed(_random_seed)
                INTO _class_id
                FROM classes
                WHERE classes.class_id != _student_class_id
                ORDER BY random()
                LIMIT 1;
            END IF;

            _group_year = (SELECT extract(YEAR FROM _registration_date))::INT % 100;
            IF _class_id = _student_class_id THEN
                SELECT groups.group_id
                INTO _group_id
                FROM groups
                WHERE substr(group_name, 1, 2) = _group_year::VARCHAR(2)
                  AND type_id = _group_type_id
                ORDER BY random()
                LIMIT 1;
            ELSE
                SELECT groups.group_id
                INTO _group_id
                FROM groups
                WHERE type_id = _department_type_id
                ORDER BY random()
                LIMIT 1;
            END IF;

            INSERT INTO readers(reader_surname, reader_name, reader_patronymic, group_id, class_id, registration_date,
                                exclusion_date)
            VALUES (_surname, _name, _patronymic, _group_id, _class_id, _registration_date,
                    _exclusion_date);
        END LOOP;
END;
$$ LANGUAGE plpgsql;
