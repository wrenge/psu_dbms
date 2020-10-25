CREATE OR REPLACE PROCEDURE generate_issues(count INT)
AS
$$
DECLARE
    _instance_id    INT;
    _instance_count INT;
    _reader_id      INT;
    _from_date      TIMESTAMP;
    _to_date        TIMESTAMP;
    _issue_date     TIMESTAMP;
    _return_date    TIMESTAMP;
    _receive_date   TIMESTAMP;
    _random_num     INT;
BEGIN
    _instance_count = (SELECT COUNT(*) FROM instance);
    FOR i IN 1..count
        LOOP
            _random_num = hash_numeric(nextval('random_counter'));
            _instance_id = abs(hash_numeric(currval('random_counter'))) % _instance_count + 1;

            SELECT reader_id, registration_date, exclusion_date
            INTO _reader_id, _from_date, _to_date
            FROM readers
            ORDER BY ABS(hash_numeric(currval('random_counter')))
            LIMIT 1;
            _issue_date = random_date_range(_from_date, _to_date, _random_num);
            _return_date = _issue_date + INTERVAL '3 years';
            _receive_date = NULL;

            IF _random_num > 0 THEN
                _receive_date = random_date_range(_issue_date, _to_date, _random_num);
            END IF;

            INSERT INTO issues(reader_id, instance_id, issue_date, receive_date, return_date)
            VALUES (_reader_id, _instance_id, _issue_date, _receive_date, _return_date);
        END LOOP;

END;
$$ LANGUAGE plpgsql