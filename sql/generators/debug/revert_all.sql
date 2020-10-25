DELETE
FROM request;
ALTER SEQUENCE request_request_id_seq RESTART WITH 1;
DELETE
FROM issues;
ALTER SEQUENCE issues_issue_id_seq RESTART WITH 1;
DELETE
FROM booking;
ALTER SEQUENCE booking_booking_id_seq RESTART WITH 1;
DELETE
FROM instance;
ALTER SEQUENCE instance_instance_id_seq RESTART WITH 1;
DELETE
FROM books;
ALTER SEQUENCE books_book_id_seq RESTART WITH 1;
DELETE
FROM publisher;
ALTER SEQUENCE publisher_publisher_id_seq RESTART WITH 1;
DELETE
FROM subject;
ALTER SEQUENCE subject_subject_id_seq RESTART WITH 1;
DELETE
FROM city;
ALTER SEQUENCE city_city_id_seq RESTART WITH 1;
DELETE
FROM readers;
ALTER SEQUENCE readers_reader_id_seq RESTART WITH 1;
DELETE
FROM classes;
ALTER SEQUENCE classes_class_id_seq RESTART WITH 1;
DELETE
FROM groups;
ALTER SEQUENCE groups_group_id_seq RESTART WITH 1;
DELETE
FROM faculties;
ALTER SEQUENCE faculties_faculty_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS person_sequence RESTART WITH 1;
ALTER SEQUENCE IF EXISTS random_counter RESTART WITH 1;