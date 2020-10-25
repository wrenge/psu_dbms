CREATE OR REPLACE PROCEDURE generate_booking(count INT)
AS
$$
DECLARE
    _status_count INT;
    _book_id      INT;
    _reader_id    INT;
    _from_date    TIMESTAMP;
    _to_date      TIMESTAMP;
    _end_date     TIMESTAMP;
    _close_date   TIMESTAMP;
    _status_id    INT;
    _booking_date TIMESTAMP;
    _random_num   INT;
BEGIN
    _status_count = (SELECT COUNT(*) FROM bookingstatus);
    FOR i IN 1..count
        LOOP
            _random_num = hash_numeric(nextval('random_counter'));

            _book_id =
                    (SELECT book_id
                     FROM books
                     ORDER BY ABS(hash_numeric(currval('random_counter')))
                     LIMIT 1);

            SELECT reader_id, registration_date, exclusion_date
            INTO _reader_id, _from_date, _to_date
            FROM readers
            ORDER BY ABS(hash_numeric(currval('random_counter')))
            LIMIT 1;

            _booking_date = random_date_range(_from_date, _to_date, _random_num);
            _end_date = _booking_date + INTERVAL '3 years';
            _close_date = NULL;
            _status_id = NULL;

            IF _random_num > 0 THEN
                _close_date = random_date_range(_booking_date, _end_date, _random_num);
                _status_id = ABS(_random_num) % _status_count + 1;
            END IF;
            INSERT INTO booking(book_id, end_date, reader_id, close_date, status_id)
            VALUES (_book_id, _end_date, _reader_id, _close_date, _status_id);
        END LOOP;
END;
$$ LANGUAGE plpgsql;