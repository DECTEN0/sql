CREATE DATABASE sql_class;
USE sql_class;

CREATE TABLE table1(
student_id INT,
student_name VARCHAR(50),
enrolled_courses VARCHAR(100)
);

INSERT INTO table1(student_id, student_name, enrolled_courses)
VALUES(101, 'Alice', 'Coding, Math'), (102, 'Bob', 'Coding');


SELECT *
FROM table1;  --- Unormalized form 

-- 1st Normal form ; Atomic Values
-- All cells must be indivisible, no repeating groups, comma seperated values
-- Fix ; Expand the rows so each course can have its own row
-- Primary Key: student_id AND enrollement_courses -- composite key


CREATE TABLE nf1(
student_id_PK INT,
student_name VARCHAR(50),
enrolled_courses_PK VARCHAR(100)
);

INSERT INTO nf1(student_id_PK, student_name, enrolled_courses_PK)
VALUES(101, 'Alice', 'Math'), (102, 'Bob', 'Coding'), (101, 'Alice', 'Coding');
SELECT * FROM nf1;

SELECT *
FROM table1;  --- Unormalized form 

-- 2nd normal form: No dependacies
-- your table must be in 1nf -- every non-key column must depend on the entire composite key (combination of student_id_PK and enrolled_courses_PK)
-- THE FIX; split this into seperate tables, one table with student info(student_id(PK), student_name), course_info (enrolled_courses(PK), tutor), student_emrollement(student_id, enrolled_courses_PK)

CREATE TABLE student_info(
student_id_PK INT,
student_name VARCHAR(50)
);

CREATE TABLE course_info(
enrolled_courses_PK VARCHAR(100),
tutor VARCHAR(100)
);

CREATE TABLE student_emrollement(
enrolled_courses_PK VARCHAR(100),
student_id_PK INT
);

INSERT INTO student_info(student_id_PK, student_name)
VALUES (101, 'Alice'), (102, 'Bob');

INSERT INTO course_info(enrolled_courses_PK, tutor)
VALUES ('Coding', 'Mr.Smith'), ('Math', 'Ms.Davis');

INSERT INTO student_emrollement(student_id_PK, enrolled_courses_PK)
VALUES (101, 'Coding'), (101, 'Math'), (102, 'Coding');


SELECT * FROM student_info;
SELECT * FROM course_info;
SELECT * FROM student_emrollement;


-- 3rd normal form; No transitive dependancies
-- must be in 2nf, non-key column can depend on another non-key column
-- problem instructor_room depend on ut==tutor ie transitive dependency (non-key --> non-key)
-- fix; split the table into 2 tables course_details(code, course name), instructors(instructor, room)
		
