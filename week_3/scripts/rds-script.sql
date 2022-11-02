CREATE DATABASE aws_course_db;

\c aws_course_db

CREATE TABLE aws_students (
	id serial PRIMARY KEY,
	name VARCHAR (50) NOT NULL
);

insert into aws_students values(1, 'Sergii');
insert into aws_students values(2, 'Anna');
insert into aws_students values(3, 'Mitya');

select * from aws_students;