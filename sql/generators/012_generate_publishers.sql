CREATE OR REPLACE PROCEDURE generate_publishers()
AS
$$
DECLARE
    publisher_name VARCHAR;
BEGIN
    CREATE TEMPORARY TABLE _publishers_staging
    (
        name VARCHAR
    );

    COPY _publishers_staging (name)
        FROM '/usr/import/data/Publishers.csv'
        DELIMITER ';'
        CSV HEADER;

    FOR publisher_name IN SELECT name FROM _publishers_staging
        LOOP
            INSERT INTO publisher(publisher_name, city_id)
            VALUES (publisher_name,
                    (SELECT city_id FROM city ORDER BY hash_numeric(currval('publisher_publisher_id_seq')) LIMIT 1));
        END LOOP;

    DROP TABLE _publishers_staging;
END;
$$ LANGUAGE plpgsql