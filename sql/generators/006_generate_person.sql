CREATE SEQUENCE IF NOT EXISTS person_sequence;

CREATE OR REPLACE FUNCTION random_person(OUT person_name VARCHAR,
                                         OUT person_surname VARCHAR,
                                         OUT person_patronymic VARCHAR) AS
$$
DECLARE
    person_gender VARCHAR;
BEGIN
    SELECT gender, name INTO person_gender, person_name
    FROM russian_names
    ORDER BY abs(hash_numeric(nextval('person_sequence')))
    LIMIT 1;

    SELECT name INTO person_surname
    FROM russian_surnames
    ORDER BY abs(hash_numeric(nextval('person_sequence')))
    LIMIT 1;

    SELECT name INTO person_patronymic
    FROM russian_surnames
    ORDER BY abs(hash_numeric(nextval('person_sequence')))
    LIMIT 1;

    IF person_gender = 'Ж' THEN
        person_surname = concat(person_surname, 'а');
        person_patronymic = concat(person_patronymic, 'на');
    ELSE
        person_patronymic = concat(person_patronymic, 'ич');
    END IF;
END;
$$ LANGUAGE plpgsql