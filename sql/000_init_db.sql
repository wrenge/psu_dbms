CREATE DATABASE [uni_library]

GO
USE uni_library
go

CREATE TABLE Author
(
    Author_id         integer IDENTITY ( 1,1 ),
    Author_surname    nvarchar(20) NOT NULL,
    Author_name        nvarchar(20) NOT NULL,
    Author_patronymic nvarchar(20) NULL
)
go

ALTER TABLE Author
    ADD CONSTRAINT XPKAuthor PRIMARY KEY CLUSTERED (Author_id ASC)
go

create table BookingStatus
(
	Status_id int identity
		constraint BookingStatus_pk
			primary key nonclustered,
	Status_name NVARCHAR(32) not null
)
go

CREATE TABLE Booking
(
    Booking_id integer IDENTITY ( 1,1 ),
    Book_id    integer  NOT NULL,
    End_date   datetime NOT NULL,
    Reader_id  integer  NOT NULL,
    Close_date datetime,
    Status_id int
)
go

ALTER TABLE Booking
    ADD CONSTRAINT XPKBooking PRIMARY KEY CLUSTERED (Booking_id ASC, Book_id ASC, Reader_id ASC)
go

CREATE TABLE Books
(
    Book_id      integer IDENTITY ( 1,1 ),
    Book_name    nvarchar(128) NOT NULL,
    Author_id    integer      NULL,
    Publisher_id integer      NOT NULL,
    Subject_id   integer      NULL,
    Category_id  integer      NOT NULL,
    Count        integer      NOT NULL DEFAULT (0),
    Total_count  integer      NOT NULL DEFAULT (0)
)
go

ALTER TABLE Books
    ADD CONSTRAINT XPKBooks PRIMARY KEY CLUSTERED (Book_id ASC)
go

CREATE TABLE Category
(
    Category_id   integer IDENTITY ( 1,1 ),
    Category_name nvarchar(64) NOT NULL
)
go

ALTER TABLE Category
    ADD CONSTRAINT XPKCategory PRIMARY KEY CLUSTERED (Category_id ASC)
go

CREATE TABLE City
(
    City_id   integer IDENTITY ( 1,1 ),
    City_name nvarchar(32) NOT NULL
)
go

ALTER TABLE City
    ADD CONSTRAINT XPKCity PRIMARY KEY CLUSTERED (City_id ASC)
go

CREATE TABLE Classes
(
    Class_id   integer IDENTITY ( 1,1 ),
    Class_name nvarchar(64) NOT NULL
)
go

ALTER TABLE Classes
    ADD CONSTRAINT XPKClasses PRIMARY KEY CLUSTERED (Class_id ASC)
go

CREATE TABLE Faculties
(
    Faculty_id      integer IDENTITY ( 1,1 ),
    Faculty_name    nvarchar(128) NOT NULL,
    Faculty_acronym nvarchar(10)  NOT NULL
)
go

ALTER TABLE Faculties
    ADD CONSTRAINT XPKFaculties PRIMARY KEY CLUSTERED (Faculty_id ASC)
go

create table GroupType
(
	Type_id int identity
		constraint GroupType_pk
			primary key nonclustered,
	Type_name NVARCHAR(64) not null
)
go

CREATE TABLE Groups
(
    Group_id   integer IDENTITY ( 1,1 ),
    Group_name nvarchar(32) NOT NULL,
    Type_id integer not null,
    Faculty_id integer     NOT NULL
)
go

ALTER TABLE Groups
    ADD CONSTRAINT XPKGroups PRIMARY KEY CLUSTERED (Group_id ASC)
go

CREATE TABLE Instance
(
    Instance_id    integer IDENTITY ( 1,1 ),
    Book_id        integer NOT NULL,
    Copy_condition integer NOT NULL,
    Copy_year      integer NOT NULL
)
go

ALTER TABLE Instance
    ADD CONSTRAINT XPKInstance PRIMARY KEY CLUSTERED (Instance_id ASC)
go

CREATE TABLE Issues
(
    Issue_id     integer IDENTITY ( 1,1 ),
    Reader_id    integer  NOT NULL,
    Instance_id  integer  NOT NULL,
    Issue_date   datetime NOT NULL,
    Receive_date datetime NULL,
    Return_date  datetime NOT NULL
)
go

ALTER TABLE Issues
    ADD CONSTRAINT XPKIssues PRIMARY KEY CLUSTERED (Issue_id ASC, Reader_id ASC)
go

CREATE TABLE Publisher
(
    Publisher_id   integer IDENTITY ( 1,1 ),
    Publisher_name nvarchar(64) NOT NULL,
    City_id        integer     NOT NULL
)
go

ALTER TABLE Publisher
    ADD CONSTRAINT XPKPublisher PRIMARY KEY CLUSTERED (Publisher_id ASC)
go

CREATE TABLE Readers
(
    Reader_id         integer IDENTITY ( 1,1 ),
    Reader_surname    nvarchar(20) NOT NULL,
    Reader_name       nvarchar(20) NOT NULL,
    Reader_patronymic nvarchar(20) NULL,
    Group_id          integer     NULL,
    Class_id          integer     NOT NULL,
    Registration_date datetime    NOT NULL,
    Exclusion_date    datetime    NULL
)
go

ALTER TABLE Readers
    ADD CONSTRAINT XPKReaders PRIMARY KEY CLUSTERED (Reader_id ASC)
go

CREATE TABLE Request
(
    Request_id       integer IDENTITY ( 1,1 ),
    Book_id          integer  NOT NULL,
    Request_cost     money    NOT NULL,
    Request_Quantity integer  NOT NULL,
    Request_date     datetime NOT NULL
)
go

ALTER TABLE Request
    ADD CONSTRAINT XPKRequest PRIMARY KEY CLUSTERED (Request_id ASC)
go

CREATE TABLE Subject
(
    Subject_id   integer IDENTITY ( 1,1 ),
    Subject_name nvarchar(32) NOT NULL
)
go

ALTER TABLE Subject
    ADD CONSTRAINT XPKSubject PRIMARY KEY CLUSTERED (Subject_id ASC)
go


ALTER TABLE Booking
    ADD CONSTRAINT R_10 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Booking
    ADD CONSTRAINT R_16 FOREIGN KEY (Reader_id) REFERENCES Readers (Reader_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

alter table Booking
	add constraint Booking_BookingStatus_Status_id_fk
		foreign key (Status_id) references BookingStatus
go

ALTER TABLE Books
    ADD CONSTRAINT R_3 FOREIGN KEY (Author_id) REFERENCES Author (Author_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Books
    ADD CONSTRAINT R_4 FOREIGN KEY (Publisher_id) REFERENCES Publisher (Publisher_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Books
    ADD CONSTRAINT R_6 FOREIGN KEY (Subject_id) REFERENCES Subject (Subject_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Books
    ADD CONSTRAINT R_7 FOREIGN KEY (Category_id) REFERENCES Category (Category_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Groups
    ADD CONSTRAINT R_14 FOREIGN KEY (Faculty_id) REFERENCES Faculties (Faculty_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

alter table Groups
    add constraint Groups_GroupType_Type_id_fk foreign key (Type_id) references GroupType
go

ALTER TABLE Instance
    ADD CONSTRAINT R_8 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Issues
    ADD CONSTRAINT R_18 FOREIGN KEY (Reader_id) REFERENCES Readers (Reader_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Issues
    ADD CONSTRAINT R_17 FOREIGN KEY (Instance_id) REFERENCES Instance (Instance_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Publisher
    ADD CONSTRAINT R_5 FOREIGN KEY (City_id) REFERENCES City (City_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Readers
    ADD CONSTRAINT R_12 FOREIGN KEY (Class_id) REFERENCES Classes (Class_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Readers
    ADD CONSTRAINT R_13 FOREIGN KEY (Group_id) REFERENCES Groups (Group_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

go

ALTER TABLE Request
    ADD CONSTRAINT R_9 FOREIGN KEY (Book_id) REFERENCES Books (Book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
go