CREATE OR REPLACE PROCEDURE generate_subjects()
AS
$$
BEGIN
    CREATE TEMPORARY TABLE _subjects_staging
    (
        name        VARCHAR,
        category_id INT
    );

    COPY _subjects_staging (name, category_id)
        FROM '/import/uni-library/data/subjects.csv'
        DELIMITER ';'
        CSV HEADER;

    INSERT INTO subject(subject_name, category_id)
    SELECT name AS subject_name, category_id
    FROM _subjects_staging;

    DROP TABLE _subjects_staging;
END
$$ LANGUAGE plpgsql