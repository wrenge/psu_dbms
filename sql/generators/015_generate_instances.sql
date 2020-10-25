CREATE OR REPLACE PROCEDURE generate_instances(instance_per_book INT)
AS
$$
DECLARE
    _book_id        INT;
    _copy_condition INT;
    _copy_year      INT;
BEGIN
    FOR _book_id IN (SELECT book_id FROM books)
        LOOP
            FOR i IN 1..instance_per_book
                LOOP
                    _copy_condition = ABS(hash_numeric(nextval('random_counter'))) % 101;
                    _copy_year = ABS(hash_numeric(currval('random_counter'))) % 21 + 2000;
                    INSERT INTO instance(book_id, copy_condition, copy_year)
                    VALUES (_book_id, _copy_condition, _copy_year);
                END LOOP;
        END LOOP;
END;
$$ LANGUAGE plpgsql