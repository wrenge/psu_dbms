CREATE OR REPLACE PROCEDURE generate_fi_books(publishers_per_book INT)
AS
$$
DECLARE
    _book_name        VARCHAR;
    _author_count     INT;
    _subject_count    INT;
    _category_id      INT;
    _publishers_count INT;
    _author_id        INT;
    _subject_id       INT;
    _publisher_id     INT;
BEGIN
    CREATE TEMPORARY TABLE _books_staging
    (
        name VARCHAR
    );

    COPY _books_staging (name)
        FROM '/usr/import/data/fiction_books.csv'
        DELIMITER ';'
        CSV HEADER;


    _publishers_count = (SELECT COUNT(*) FROM publisher);
    _author_count = (SELECT COUNT(*) FROM author);
    _subject_count = (SELECT COUNT(*) FROM subject);
    _category_id = (SELECT category_id FROM category WHERE category_name = N'Художественная литература');

    FOR _book_name IN (SELECT DISTINCT name FROM _books_staging)
        LOOP
            _author_id = abs(hash_numeric(nextval('random_counter'))) % _author_count + 1;
            _subject_id =
                    (SELECT subject_id
                     FROM subject
                     WHERE category_id = _category_id
                     ORDER BY ABS(hash_numeric(nextval('random_counter')))
                     LIMIT 1);
            FOR i IN 1..publishers_per_book
                LOOP
                    _publisher_id = abs(hash_numeric(nextval('random_counter'))) % _publishers_count + 1;
                    INSERT INTO books(book_name, author_id, publisher_id, subject_id)
                    VALUES (_book_name, _author_id, _publisher_id, _subject_id);
                END LOOP;
        END LOOP;

    DROP TABLE _books_staging;
END
$$ LANGUAGE plpgsql