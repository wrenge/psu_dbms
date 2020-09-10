CREATE DATABASE uni_library;

CREATE TABLE Author
(
    Author_id         SERIAL PRIMARY KEY,
    Author_surname    VARCHAR(20) NOT NULL,
    Author_name        VARCHAR(20) NOT NULL,
    Author_patronymic VARCHAR(20) NULL
);

CREATE TABLE BookingStatus
(
    Status_id SERIAL PRIMARY KEY,
    Status_name VARCHAR(32) not null
);

CREATE TABLE Booking
(
    Booking_id SERIAL PRIMARY KEY,
    Book_id    INTEGER  NOT NULL,
    End_date   timestamp(3) NOT NULL,
    Reader_id  INTEGER  NOT NULL,
    Close_date timestamp(3),
    Status_id INTEGER
);

CREATE TABLE Books
(
    Book_id      SERIAL PRIMARY KEY,
    Book_name    VARCHAR(128) NOT NULL,
    Author_id    INTEGER      NULL,
    Publisher_id INTEGER      NOT NULL,
    Subject_id   INTEGER      NULL,
    Category_id  INTEGER      NOT NULL,
    Count        INTEGER      NOT NULL DEFAULT (0),
    Total_count  INTEGER      NOT NULL DEFAULT (0)
);

CREATE TABLE Category
(
    Category_id   SERIAL PRIMARY KEY,
    Category_name VARCHAR(64) NOT NULL
);

CREATE TABLE City
(
    City_id   SERIAL PRIMARY KEY,
    City_name VARCHAR(32) NOT NULL
);

CREATE TABLE Classes
(
    Class_id   SERIAL PRIMARY KEY,
    Class_name VARCHAR(64) NOT NULL
);

CREATE TABLE Faculties
(
    Faculty_id      SERIAL PRIMARY KEY,
    Faculty_name    VARCHAR(128) NOT NULL,
    Faculty_acronym VARCHAR(10)  NOT NULL
);

CREATE TABLE GroupType
(
	Type_id SERIAL
		constraint GroupType_pk
			primary key,
	Type_name VARCHAR(64) not null
);

CREATE TABLE Groups
(
    Group_id   SERIAL PRIMARY KEY,
    Group_name VARCHAR(32) NOT NULL,
    Type_id INTEGER not null,
    Faculty_id INTEGER     NOT NULL
);

CREATE TABLE Instance
(
    Instance_id    SERIAL PRIMARY KEY,
    Book_id        INTEGER NOT NULL,
    Copy_condition INTEGER NOT NULL,
    Copy_year      INTEGER NOT NULL
);

CREATE TABLE Issues
(
    Issue_id     SERIAL PRIMARY KEY,
    Reader_id    INTEGER  NOT NULL,
    Instance_id  INTEGER  NOT NULL,
    Issue_date   timestamp(3) NOT NULL,
    Receive_date timestamp(3) NULL,
    Return_date  timestamp(3) NOT NULL
);

CREATE TABLE Publisher
(
    Publisher_id   SERIAL PRIMARY KEY,
    Publisher_name VARCHAR(64) NOT NULL,
    City_id        INTEGER     NOT NULL
);

CREATE TABLE Readers
(
    Reader_id         SERIAL PRIMARY KEY,
    Reader_surname    VARCHAR(20) NOT NULL,
    Reader_name       VARCHAR(20) NOT NULL,
    Reader_patronymic VARCHAR(20) NULL,
    Group_id          INTEGER     NULL,
    Class_id          INTEGER     NOT NULL,
    Registration_date timestamp(3)    NOT NULL,
    Exclusion_date    timestamp(3)    NULL
);

CREATE TABLE Request
(
    Request_id       SERIAL PRIMARY KEY,
    Book_id          INTEGER  NOT NULL,
    Request_cost     money    NOT NULL,
    Request_Quantity INTEGER  NOT NULL,
    Request_date     timestamp(3) NOT NULL
);

CREATE TABLE Subject
(
    Subject_id   SERIAL PRIMARY KEY,
    Subject_name VARCHAR(32) NOT NULL
);


ALTER TABLE Booking
    ADD CONSTRAINT R_10 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;


ALTER TABLE Booking
    ADD CONSTRAINT R_16 FOREIGN KEY (Reader_id) REFERENCES Readers (Reader_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;


ALTER TABLE Booking
	ADD CONSTRAINT Booking_BookingStatus_Status_id_fk
		FOREIGN KEY (Status_id) REFERENCES BookingStatus;


ALTER TABLE Books
    ADD CONSTRAINT R_3 FOREIGN KEY (Author_id) REFERENCES Author (Author_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Books
    ADD CONSTRAINT R_4 FOREIGN KEY (Publisher_id) REFERENCES Publisher (Publisher_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Books
    ADD CONSTRAINT R_6 FOREIGN KEY (Subject_id) REFERENCES Subject (Subject_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Books
    ADD CONSTRAINT R_7 FOREIGN KEY (Category_id) REFERENCES Category (Category_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Groups
    ADD CONSTRAINT R_14 FOREIGN KEY (Faculty_id) REFERENCES Faculties (Faculty_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Groups
    ADD CONSTRAINT Groups_GroupType_Type_id_fk FOREIGN KEY (Type_id) REFERENCES GroupType;


ALTER TABLE Instance
    ADD CONSTRAINT R_8 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Issues
    ADD CONSTRAINT R_18 FOREIGN KEY (Reader_id) REFERENCES Readers (Reader_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Issues
    ADD CONSTRAINT R_17 FOREIGN KEY (Instance_id) REFERENCES Instance (Instance_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Publisher
    ADD CONSTRAINT R_5 FOREIGN KEY (City_id) REFERENCES City (City_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Readers
    ADD CONSTRAINT R_12 FOREIGN KEY (Class_id) REFERENCES Classes (Class_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Readers
    ADD CONSTRAINT R_13 FOREIGN KEY (Group_id) REFERENCES Groups (Group_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;



ALTER TABLE Request
    ADD CONSTRAINT R_9 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;
