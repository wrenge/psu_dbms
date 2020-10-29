CREATE OR REPLACE PROCEDURE generate_requests(min_date TIMESTAMP) AS
$$
DECLARE
    _request_cost     INT;
    _request_quantity INT;
    _request_date     TIMESTAMP;
    _book_id          INT;
    _random_num       INT;
BEGIN
    FOR _book_id IN (SELECT book_id FROM books)
        LOOP
            _random_num = hash_numeric(nextval('random_counter'));
            _request_cost = abs(_random_num) % 1200 + 300;
            _request_quantity = abs(_random_num) % 200 + 1;
            _request_date = min_date + (abs(_random_num) % 6 + 1) * INTERVAL '1 year';
            INSERT INTO request(book_id, request_cost, request_quantity, request_date)
            VALUES (_book_id, _request_cost, _request_quantity, _request_date);
        END LOOP;
END;
$$ LANGUAGE plpgsql