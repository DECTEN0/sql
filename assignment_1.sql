/*
COMS5023A

SQL Data Manipulation Assessment Questions

*/


-- create a databse for the assignments
CREATE DATABASE wits;

-- instatiante the db
USE wits;

/*
Question 1 [6 marks]

Write the SQL command to create the students table with the specified attributes and data
types (student_num, student_lname, student_fname, enrollment_date, age).

ATTRIBUTE (FIELD NAME)   DATA TYPE
student_num              CHAR(3)
student_lname            VARCHAR(25)
student_fname            VARCHAR(25)
enrollment_date          DATE
age                      INTEGER


Describe the table by executing the command
DESC students;

*/
-- Question 1 solution

CREATE TABLE students(
student_num CHAR(3),
student_lname   VARCHAR(25),
student_fname   VARCHAR(25),
enrollment_date  DATE,
age INTEGER
);

-- Describe the table

DESC students;


/*

Question 2 [8 marks]
Write SQL statements to insert all six student records provided in the exercise into the
students table. Your output should be as shown in the screenshot

*/

-- insert data into table
INSERT INTO students (student_num, student_lname, student_fname, enrollment_date, age)
VALUES 
    ('101', 'Mokoena', 'Thabo', '2019-05-23', 18),
    ('102', 'Shilubana', 'Ndivhuwo', '2018-08-13', 20),
    ('103', 'Baloyi', 'Tsakani', '2017-11-09', 19),
    ('104', 'Mgangatho', 'Lukhanyo', '2020-03-17', 17),
    ('105', 'Mofokeng', 'Lerato', '2018-12-05', 21),
    ('106', 'Mnguni', 'Nomsa', '2018-08-13', 18);
    
    
/*

Question 3 [4 marks]
Write the SQL command to insert a new student with student_num 054 and age 7 only.

*/

-- Insert new student with student_num - 054 and age =7
INSERT INTO students(student_num, student_lname, student_fname, enrollment_date, age)
VALUES ('054', NULL, NULL, NULL, 7);

/*

Question 4 [4 marks]
Write the SQL command to insert a new student with student_num 076, student_lname
Vukosi, and enrollment_date 2021-09-09.

*/
INSERT INTO students(student_num, student_lname, student_fname, enrollment_date, age)
VALUES('076', 'Vukosi', NULL, '2021-09-09', NULL);

/*

Question 5 [2 marks]
Write the SQL command to display all records from the students table.

*/

-- Display all the data
SELECT * FROM students;



/*

Question 6 [3 marks]
Write the SQL command to display only the student_num and age columns for all students. 

*/

-- Display student_num and age columns
SELECT student_num, age FROM students;

/*

Question 7 [5 marks]
Write the SQL command to update the first name of the student with student_num 104 to Mark.

*/

-- change student_fname to Mark
UPDATE students
SET student_fname = 'Mark'
WHERE student_num = '104';


/*

Question 8 [6 marks]
Write the SQL command to update the age of all students enrolled before 2019 to 22. 

*/

UPDATE students
SET age = 22
WHERE enrollment_date < '2019-01-01';


/*

Question 9 [5 marks]
Write the SQL command to delete all records where age equals 18

*/
DELETE 
FROM students
WHERE age = 18;

/*

Question 10 [7 marks]
Write the SQL command to delete all rows from the students table without deleting the
table structure.

*/

DELETE 
FROM students;

-- Alt; much faster on larger datasets
TRUNCATE TABLE students;

-- Display all the data
SELECT * FROM students;