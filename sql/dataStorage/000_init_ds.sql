CREATE TABLE book_name
(
  id_book_name SERIAL NOT NULL,
  book_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_book_name),
  UNIQUE (book_name)
);

CREATE TABLE author
(
  id_author SERIAL NOT NULL,
  surname VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  patronymic VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_author)
);

CREATE TABLE publisher
(
  id_publisher SERIAL NOT NULL,
  publisher_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_publisher),
  UNIQUE (publisher_name)
);

CREATE TABLE category
(
  id_category SERIAL NOT NULL,
  category_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_category),
  UNIQUE (category_name)
);

CREATE TABLE subject
(
  id_subject SERIAL NOT NULL,
  subject_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_subject),
  UNIQUE (subject_name)
);

CREATE TABLE date_time
(
  id_date_time SERIAL NOT NULL,
  date_time_value DATE NOT NULL,
  PRIMARY KEY (id_date_time)
);

CREATE TABLE book_request_fact
(
  id_book_request SERIAL NOT NULL,
  request_count INT NOT NULL,
  request_cost MONEY NOT NULL,
  id_period_date INT NOT NULL,
  id_category INT NOT NULL,
  id_author INT NOT NULL,
  id_subject INT NOT NULL,
  id_publisher INT NOT NULL,
  id_book_name INT NOT NULL,
  PRIMARY KEY (id_book_request),
  FOREIGN KEY (id_period_date) REFERENCES date_time(id_date_time),
  FOREIGN KEY (id_category) REFERENCES category(id_category),
  FOREIGN KEY (id_author) REFERENCES author(id_author),
  FOREIGN KEY (id_subject) REFERENCES subject(id_subject),
  FOREIGN KEY (id_publisher) REFERENCES publisher(id_publisher),
  FOREIGN KEY (id_book_name) REFERENCES book_name(id_book_name)
);

CREATE TABLE booking_status
(
  id_booking_status SERIAL NOT NULL,
  booking_status_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_booking_status),
  UNIQUE (booking_status_name)
);

CREATE TABLE faculty
(
  id_faculty SERIAL NOT NULL,
  faculty_full_name VARCHAR(256) NOT NULL,
  fuculty_short_name VARCHAR(256) NOT NULL,
  PRIMARY KEY (id_faculty),
  UNIQUE (faculty_full_name),
  UNIQUE (fuculty_short_name)
);

CREATE TABLE unit_type
(
  id_unit_type SERIAL NOT NULL,
  type_name INT NOT NULL,
  PRIMARY KEY (id_unit_type)
);

CREATE TABLE issue_status
(
  id_issue_status SERIAL NOT NULL,
  status_name INT NOT NULL,
  PRIMARY KEY (id_issue_status)
);

CREATE TABLE unit
(
  id_unit SERIAL NOT NULL,
  unit_name VARCHAR(10) NOT NULL,
  id_unit_type INT NOT NULL,
  id_faculty INT NOT NULL,
  PRIMARY KEY (id_unit),
  FOREIGN KEY (id_unit_type) REFERENCES unit_type(id_unit_type),
  FOREIGN KEY (id_faculty) REFERENCES faculty(id_faculty),
  UNIQUE (unit_name)
);

CREATE TABLE issue_facts
(
  id_issue SERIAL NOT NULL,
  id_book_name INT NOT NULL,
  id_author INT NOT NULL,
  id_publisher INT NOT NULL,
  id_category INT NOT NULL,
  id_subject INT NOT NULL,
  id_period_date INT NOT NULL,
  id_group INT NOT NULL,
  id_issue_status INT NOT NULL,
  PRIMARY KEY (id_issue),
  FOREIGN KEY (id_book_name) REFERENCES book_name(id_book_name),
  FOREIGN KEY (id_author) REFERENCES author(id_author),
  FOREIGN KEY (id_publisher) REFERENCES publisher(id_publisher),
  FOREIGN KEY (id_category) REFERENCES category(id_category),
  FOREIGN KEY (id_subject) REFERENCES subject(id_subject),
  FOREIGN KEY (id_period_date) REFERENCES date_time(id_date_time),
  FOREIGN KEY (id_group) REFERENCES unit(id_unit),
  FOREIGN KEY (id_issue_status) REFERENCES issue_status(id_issue_status)
);

CREATE TABLE booking_fact
(
  id_booking_fact SERIAL NOT NULL,
  id_booking_status INT,
  id_publisher INT NOT NULL,
  id_subject INT NOT NULL,
  id_author INT NOT NULL,
  id_book_name INT NOT NULL,
  id_period_date INT NOT NULL,
  id_category INT NOT NULL,
  id_group INT NOT NULL,
  PRIMARY KEY (id_booking_fact),
  FOREIGN KEY (id_booking_status) REFERENCES booking_status(id_booking_status),
  FOREIGN KEY (id_publisher) REFERENCES publisher(id_publisher),
  FOREIGN KEY (id_subject) REFERENCES subject(id_subject),
  FOREIGN KEY (id_author) REFERENCES author(id_author),
  FOREIGN KEY (id_book_name) REFERENCES book_name(id_book_name),
  FOREIGN KEY (id_period_date) REFERENCES date_time(id_date_time),
  FOREIGN KEY (id_category) REFERENCES category(id_category),
  FOREIGN KEY (id_group) REFERENCES unit(id_unit)
);