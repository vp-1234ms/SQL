CREATE TABLE STUDENT(
    reg_id INT,
    name VARCHAR(10) NOT NULL,
    address VARCHAR(20) UNIQUE
);


DESCRIBE STUDENT;


ALTER TABLE STUDENT ADD PRIMARY KEY(reg_id);

SELECT * FROM STUDENT;


INSERT INTO STUDENT VALUES(1,'Jack','Biology');
INSERT INTO STUDENT VALUES(2,'Kate','Sociology');
INSERT INTO STUDENT VALUES(3,'Claire','Math');
INSERT INTO STUDENT VALUES(4,'Jack','CIVIL'),(5,'Mike','Computer Science');

SELECT student.reg_id,student.name
FROM student
ORDER BY name;

SELECT student.reg_id,student.name
FROM student
ORDER BY reg_id;


SELECT student.reg_id,student.name
FROM student
ORDER BY reg_id DESC;



SELECT *
FROM student
ORDER BY reg_id ASC;

SELECT *
FROM student
ORDER BY name ASC;

SELECT *
FROM student
ORDER BY name,reg_id ASC;

SELECT * 
FROM STUDENT
LIMIT 3;


SELECT * 
FROM STUDENT 
ORDER BY name,reg_id ASC
LIMIT 3;


SELECT name,reg_id,address
FROM student 
WHERE address='Biology' or ='Civil'
ORDER BY reg_id ASC;



SELECT name,reg_id,address
FROM student 
WHERE name='Jack' or address='Sociology'
ORDER BY reg_id ASC
LIMIT 2;


SELECT name,reg_id,address
FROM student 
WHERE name='Jack' and address='Civil' and reg_id>=3
ORDER BY reg_id ASC
LIMIT 2;



-- <> is not equal to
SELECT name,reg_id,address
FROM student 
WHERE name <> 'Jack'; 



SELECT name,reg_id,address
FROM student 
WHERE reg_id<3 and name <> 'Jack'; 



SELECT * 
FROM Student
WHERE name IN ('Jack','Kate');


DROP TABLE Student;


