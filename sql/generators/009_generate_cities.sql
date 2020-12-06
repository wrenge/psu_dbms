CREATE OR REPLACE PROCEDURE generate_cities() AS
$$
BEGIN
    COPY city (city_name)
        FROM '/usr/import/data/City.csv'
        DELIMITER ';'
        CSV HEADER;
END;
$$ LANGUAGE plpgsql