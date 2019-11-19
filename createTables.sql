/*
drop table requested;
drop table borrows;
drop table users;
drop table authors;
drop table books;
*/

#create table Books
create table books
(
isbn BIGINT,
title varchar(256),
genre varchar(256),
PRIMARY KEY (isbn)
);

#Load Data
load data local infile "INPUT YOUR PATH TO books.txt" into table books fields terminated by ",";

#Create Table Authors
create table authors 
(
name varchar(255),
isbn BIGINT,
age integer,
gender varchar(255),
Primary Key (name,isbn),
FOREIGN KEY (isbn) REFERENCES books(isbn) 
);

#Load Data
load data local infile "INPUT YOUR PATH TO authors.txt" into table authors fields terminated by ",";

#Create User table
create table users
(
id integer NOT NULL PRIMARY KEY,
name varchar(255),
address varchar(255) NOT NULL,
email varchar(255),
phone varchar(255) NOT NULL
);

#Load Data
load data local infile "INPUT YOUR PATH TO users.txt" into table users fields terminated by ",";

#Create Borrows table
create table borrows
(
dueDate date NOT NULL,
dateBorrowed date NOT NULL,
dateReturned date,
isbn BIGINT NOT NULL,
id integer NOT NULL,
PRIMARY KEY (id,isbn,dateBorrowed),
FOREIGN KEY (id) references users(id),
FOREIGN KEY (isbn) references books(isbn)
);

#Load Data
load data local infile "INPUT YOUR PATH TO borrows.txt" into table borrows fields terminated by ",";

create table requested
(
id integer,
isbn BIGINT,
title varchar(255),
PRIMARY KEY (id, isbn),
FOREIGN KEY (id) references users(id)
);

#Load Data
load data local infile "INPUT YOUR PATH TO requested.txt" into table requested fields terminated by ",";