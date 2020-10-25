CREATE OR REPLACE PROCEDURE generate_authors(count INT) AS
$$
DECLARE
    _name       VARCHAR;
    _surname    VARCHAR;
    _patronymic VARCHAR;
BEGIN
    FOR i IN 1..count
        LOOP
            SELECT * FROM random_person() INTO _name, _surname, _patronymic;
            INSERT INTO author(author_surname, author_name, author_patronymic) VALUES (_surname, _name, _patronymic);
        END LOOP;
END;
$$ LANGUAGE plpgsql