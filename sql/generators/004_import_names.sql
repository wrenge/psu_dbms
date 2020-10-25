CREATE OR REPLACE PROCEDURE import_names() AS
$$
BEGIN
    CREATE TABLE russian_names
    (
        name   VARCHAR,
        gender VARCHAR
    );

    CREATE TABLE russian_surnames
    (
        name VARCHAR
    );

    COPY russian_names (name, gender)
        FROM '/import/uni-library/data/russian_names.csv'
        DELIMITER ';'
        CSV HEADER;

    COPY russian_surnames (name)
        FROM '/import/uni-library/data/russian_surnames.csv'
        DELIMITER ';'
        CSV HEADER;
END;
$$ LANGUAGE plpgsql