CREATE OR REPLACE PROCEDURE generate_faculties() AS
$$
BEGIN
    INSERT INTO faculties(faculty_name, faculty_acronym) VALUES ('Факультет вычислительной техники', 'ФВТ');
    INSERT INTO faculties(faculty_name, faculty_acronym)
    VALUES ('Факультет приборостроения, информационных технологий и электроники', 'ФПИТЭ');
    INSERT INTO faculties(faculty_name, faculty_acronym) VALUES ('Факультет машиностроения', 'ФМ');
END;
$$ LANGUAGE plpgsql;