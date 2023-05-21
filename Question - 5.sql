/*
1)Insert the data given above in both employee, department and project tables.
*/

-- CREATING EMPLOYEE TABLE
CREATE TABLE EMPLOYEEE(
    First_Name VARCHAR(15),
    Mid_Name CHAR(2),
    Last_Name VARCHAR(15),
    SSN_Number CHAR(9),
    Birthday DATE,
    Address VARCHAR(50),
    Sex CHAR(1),
    Salary INT(7),
    Supervision_SSN CHAR(9),
    Department_Number INT(5)
);

-- CREATING PROJECT TABLE
CREATE TABLE PROJECT(
    Project_Name VARCHAR(15),
    Project_Number INT(5),
    Project_Location VARCHAR(15),
    Department_Number INT(5)
);

-- CREATING DEPARTMENT TABLE
CREATE TABLE DEPARTMENT(
    Department_Name Varchar(15),
    Department_Number INT(5),
    Manager_SSN CHAR(9),
    Manager_Start_Date DATE
);

-- INSRTING RECORDS IN EMPLOYEE TABLE
INSERT INTO EMPLOYEEE VALUES("Doug","E","Gilbert",554433221,"1960-06-09","11 S 59 E Salt, Lake City, UT","M",80000,NULL,3);
INSERT INTO EMPLOYEEE VALUES("Joyee",NULL,"PAN",543216789,"1960-02-07","35 S 18 E ,Salt Lake City, UT","F",70000,NULL,2),("Frankin","T","Wong",333445555,"1945-12-08","638 Voss Houstan, TX","M",40000,554433221,5);
INSERT INTO EMPLOYEEE VALUES("Jennifer","S","Wallace",987654321,"1931-06-20","291 Berry Bellaire, TX","F",43000,554433221,4),("John","B","Smith",123456789,"1955-01-09","731 Fondren Houston, TX","M",30000,333445555,5),("Ramesh","K","Narayan",666884444,"1952-08-15","975 Fire Oak, Humble, TX","M",38000,333445555,5),("Joyee","A","English",453453453,"1962-07-31","5631 Rice Houston, TX","F",25000,333445555,5),("James","E","Borg",888665555,"1927-11-10","450 Stone Houston, TX","M",55000,543216789,1),("Alieia","J","Zelaya",999887777,"1958-07-19","3321 Castle Spring, TX","F",25000,987654321,4),("Ahmad","V","Jabbar",987987987,"1959-03-29","980 Dallas Houston, TX","M",25000,987654321,4);

-- INSERTING RECORDS IN DEPARTMENT TABLE
INSERT INTO DEPARTMENT VALUES("Manufacture",1,888665555,"1971-06-19"),("Administration",2,543216789,"1999-01-04"),("Headquarter",3,554433221,"1955-08-22"),("Finance",4,987654321,"1985-01-01"),("Research",5,987654321,"1978-05-22");

-- INSERTING RECORDS IN PROJECT TABLE
INSERT INTO PROJECT VALUES("ProjectA",3388,"Houston",1),("ProjectB",1945,"Salt Lake City",3),("ProjectC",6688,"Houston",5),("ProjectD",2423,"Bellaire",4),("ProjectE",7745,"Sugarland",5),("ProjectF",1566,"Salt Lake City",3),("ProjectG",1234,"New York",2),("ProjectH",3467,"Satafford",4),("ProjectI",4345,"Chicago",1),("ProjectJ",2212,"San Francisco",2);

-- 2) Display all the employees' information.
SELECT * FROM EMPLOYEEE;

-- 3) Display Employee name along with his SSN and Supervisor SSN.
SELECT First_Name,Last_Name,SSN_Number,Supervision_SSN
FROM EMPLOYEEE;

-- 4) Display the employee names whose bdate is '29-MAR-1959'.
SELECT First_Name,Last_Name
FROM EMPLOYEEE
WHERE Birthday="1959-03-29";

-- 5) Display salary of the employees without duplications.
SELECT DISTINCT Salary
FROM EMPLOYEEE;

-- 6) Display the MgrSSN, MgrStartDate of the manager of 'Finance' department.
SELECT Manager_SSN,Manager_Start_Date
FROM DEPARTMENT
WHERE Department_Name="Finance";

-- 7) Modify the department number of an employee having fname as 'Joyce' to 5


-- 8) Alter Table department add column DepartmentPhoneNum of NUMBER data type and insert values into this column only.
ALTER TABLE DEPARTMENT ADD Department_Phone_Number INT(6);
UPDATE DEPARTMENT SET Department_Phone_Number =
(478512)
WHERE Department_Number=1;
UPDATE DEPARTMENT SET Department_Phone_Number =
(587463)
WHERE Department_Number=2;
UPDATE DEPARTMENT SET Department_Phone_Number =
(986574)
WHERE Department_Number=3;
UPDATE DEPARTMENT SET Department_Phone_Number =
(258749)
WHERE Department_Number=4;
UPDATE DEPARTMENT SET Department_Phone_Number =
(874693)
WHERE Department_Number=5;

-- 9) Alter table orders modify the size of DepartmentPhoneNum.
ALTER TABLE PROJECT ADD COLUMN Department_Phone_Number INT(8);

-- 10) Modify the field name DepartmentPhoneNum of departments table to PhNo.
ALTER TABLE DEPARTMENT RENAME COLUMN Department_Phone_Number to PhNo;

-- 11) Rename Table Department as DEPT.
ALTER TABLE DEPARTMENT RENAME DEPT;

-- 12) Alter Table department remove column DepartmentPhoneNum.
ALTER TABLE DEPT DROP COLUMN PhNo;






-- ************************EX-2*************************
-- Modify the schema given in Exercise-1 to incorporate the new relations and add the constraints to all the relations as mentioned above.

-- ADDING CONSTRAINTS TO EXISTING EMPLOYEEE COLUMNS
ALTER TABLE EMPLOYEEE 
MODIFY COLUMN First_Name VARCHAR(15) NOT NULL; 
ALTER TABLE EMPLOYEEE
MODIFY COLUMN Last_Name VARCHAR(15) NOT NULL;
ALTER TABLE EMPLOYEEE
ADD PRIMARY KEY (SSN_NUMBER);
ALTER TABLE EMPLOYEEE
ADD CONSTRAINT Sex CHECK(Sex IN ("M","F","m","f"));
ALTER TABLE EMPLOYEEE
ALTER Salary SET DEFAULT 800;
ALTER TABLE EMPLOYEEE
ADD FOREIGN KEY(Supervision_SSN) REFERENCES EMPLOYEEE(SSN_NUMBER)ON DELETE SET NULL;


-- ADDING CONSTRAINTS TO EXISTING DEPARTMENT COLUMNS
ALTER TABLE DEPARTMENT 
MODIFY COLUMN Department_Name VARCHAR(15) NOT NULL;
ALTER TABLE DEPARTMENT 
ADD PRIMARY KEY (Department_Number);
ALTER TABLE DEPARTMENT
ADD FOREIGN KEY(Manager_SSN) REFERENCES EMPLOYEEE(SSN_NUMBER)ON DELETE SET NULL;
ALTER TABLE EMPLOYEEE
ADD FOREIGN KEY (Department_Number) REFERENCES DEPARTMENT(Department_Number) ON DELETE CASCADE;  


-- ADDING CONSTRAINTS TO EXISTING PROJECT COLUMNS
ALTER TABLE PROJECT 
MODIFY COLUMN Project_Name VARCHAR(15) NOT NULL;
ALTER TABLE PROJECT
ADD PRIMARY KEY (Project_Number);
ALTER TABLE PROJECT
ADD FOREIGN KEY (Department_Number) REFERENCES DEPARTMENT(Department_Number) ON DELETE SET NULL;

-- CREATING NEW TABLES 
-- CREATING DEPT_LOCATIONS TABLE
CREATE TABLE DEPT_LOCATIONS(
    Department_Number   INT(5),
    Department_Location VARCHAR(15),
     FOREIGN KEY (Department_Number) REFERENCES DEPARTMENT (Department_Number) ON DELETE CASCADE
);

-- CREATING WORKS_ON TABLE
CREATE TABLE WORKS_ON(
    Employee_SSN CHAR(9),
    Project_Number INT(5),
    Hours DECIMAL(3,1) NOT NULL,
    FOREIGN KEY (Employee_SSN) REFERENCES EMPLOYEEE(SSN_Number) ON DELETE CASCADE,
    FOREIGN KEY (Project_Number) REFERENCES PROJECT(Project_Number) ON DELETE CASCADE
);

--CREATING DEPENDENT TABLE
CREATE TABLE DEPENDENT(
    Employee CHAR(9),
    Dependent_Name VARCHAR(15),
    Sex CHAR(1) CHECK(Sex IN("M","F","m","f")),
    Birthday DATE,
    Relationship VARCHAR(8),
    FOREIGN KEY (Employee) REFERENCES EMPLOYEEE (SSN_Number) ON DELETE CASCADE 
);

--INSERTING VALUES INTO NEW TABLES
--DEPT_LOCATIONS TABLE
INSERT INTO DEPT_LOCATIONS VALUES(1,"Houston"),(1,"Chicago"),(2,"New York"),(2,"San Francisco"),(3,"Salt Lake City"),(4,"Stafford"),(4,"Bellaire"),(5,"Sugarland"),(5,"Houston");

--WORKS_ON TABLE
INSERT INTO WORKS_ON VALUES(123456789,3388,32.5),(123456789,1945,7.5),(666884444,3388,40.0),(453453453,7745,20.0),(453453453,2212,20.0),(333445555,7745,10.0),(333445555,6688,10.0),(333445555,4345,35.0),(333445555,2212,28.5),(999887777,1234,11.5),(999887777,1234,13.0),(543216789,2212,17.0),(554433221,1945,21.5);

-- DEPENDENT TABLE
INSERT INTO DEPENDENT VALUES(333445555,"Alice","F","1976-04-05","Daughter"),(333445555,"Theodore","M","1973-10-25","Son"),(333445555,"Joy","F","1948-05-03","Spouse"),(987654321,"Abner","M","1932-02-29","Spouse"),(123456789,"Alice","F","1978-12-31","Daughter"),(123456789,"Elizabeth","F","1957-05-05","Spouse");

-- Execute the following Query on the DB to display and discuss the integrity constraints violated by any of the following operations

-- 1) Insert ('Robert', 'F', 'Scott', '943775543', '21-JUN-42', '2365 Newcastle Rd, Bellaire, TX', M, 58000, '888665555', 1 ) into EMPLOYEE.
INSERT INTO EMPLOYEEE VALUES  ('Robert', 'F', 'Scott', '943775543', '21-JUN-42','2365 Newcastle Rd, Bellaire, TX',M, 58000, '888665555', 1 );
-- INVALID QUERY VIOLATING SEX ATTRIBUTE CONSTRAINT SHOULD BE CHARACTER WITH SINGLE OR DOUBLE QUOTES


-- 2) Insert ( '677678989', null, '40.0' ) into WORKS_ON.
INSERT INTO WORKS_ON VALUES('677678989', null, '40.0');
-- INVALID QUERY VIOLATING FOREIGN KEY CONSTRAINT OF ATTRIBUTE EMPLOYEE_SSN AND NOT NULL CONSTRAINT ON PROJECT_NUMBER

-- 3) Insert ( '453453453', 'John', M, '12-DEC-60', 'SPOUSE' ) into DEPENDENT
INSERT INTO DEPENDENT VALUES( '453453453', 'John', M, '12-DEC-60', 'SPOUSE');
--INVALID CONSTRAINT VIOLATING CHAR CONSTRAINT ON SEX ATTRIBUTE

-- 4) Delete the WORKS_ON tuples with ESSN= '333445555'
DELETE FROM WORKS_ON 
WHERE Employee_SSN= '333445555';
--VALID QUERY SUCCESSFULLY DELETED 4 TUPLES 

-- 5) Modify the MGRSSN and MGRSTARTDATE of the DEPARTMENT tuple with DNUMBER=5 to '123456789' and '01-OCT-88', respectively
UPDATE DEPARTMENT
SET Manager_SSN=123456789 AND Manager_Start_Date="1988-10-01"
WHERE Department_Number=5;
--INVALID QUERY VIOLATING FOREIGN KEY CONSTRAINT ON ATTRIBUTE MANAGER_SSN

-- 6) Add Foreign Keys using Alter Table [if not done earlier].
-- Already Added all possible Foreign Keys

-- 7) Drop Foreign key defined on SuperSSN and add it using Alter table command.
ALTER TABLE EMPLOYEEE
DROP FOREIGN KEY Supervision_SSN;

ALTER TABLE EMPLOYEEE
ADD FOREIGN KEY (Supervision_SSN) REFERENCES EMPLOYEEE(SSN_Number); 

-- 8) Make name of Project as Unique and sex of employee as not null.
ALTER TABLE PROJECT
MODIFY Project_Name VARCHAR(15) UNIQUE;
ALTER TABLE EMPLOYEEE
MODIFY Sex CHAR(1) NOT NULL;

-- 9) Make Address as a new type containing door no, street, city, State, Continent.



-- 10) Make salary of employee to accept real values
ALTER TABLE EMPLOYEEE
ADD CHECK (Salary>=0);

DESCRIBE EMPLOYEEE;
DESCRIBE DEPARTMENT;
DESCRIBE PROJECT;
DESCRIBE DEPT;
DESCRIBE DEPT_LOCATIONS;
DESCRIBE WORKS_ON;
DESCRIBE DEPENDENT;


SELECT * FROM EMPLOYEEE;
SELECT * FROM PROJECT;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;


DROP TABLE EMPLOYEEE;
DROP TABLE PROJECT;
DROP TABLE DEPARTMENT;
DROP TABLE DEPT;
DROP TABLE DEPT_LOCATIONS;
DROP TABLE WORKS_ON;
DROP TABLE DEPENDENT;







-- ************************EX-3*************************
-- Create a hospital database with the following entity and attributes

-- CREATING PHYSICIAN TABLE
CREATE TABLE PHYSICIAN(
    EmployeeId INT UNIQUE PRIMARY KEY,
    Name VARCHAR(15),
    Position_Physician VARCHAR(20),
    SSN INT
);

CREATE TABLE HOSPT_DEPARTMENT(
    DepartmentId INT UNIQUE PRIMARY KEY,
    Name VARCHAR(20),
    Head INT,
    FOREIGN KEY (Head) REFERENCES PHYSICIAN(EmployeeId)
);

CREATE TABLE WORKS_WITH(
    Physician INT,
    Department INT,
    Primary_Affiliation CHAR(1),
    FOREIGN KEY (Physician) REFERENCES PHYSICIAN (EmployeeId),
    FOREIGN KEY (Department) REFERENCES HOSPT_DEPARTMENT(DEPARTMENTId)
);

CREATE TABLE HOSPT_PROCEDURE(
    Code CHAR(4) UNIQUE PRIMARY KEY,
    Name VARCHAR(20),
    Cost INT
);

CREATE TABLE PATIENT(
    SSN INT UNIQUE PRIMARY KEY,
    Name VARCHAR(20),
    Address VARCHAR(40),
    PhoneNumber INT,
    InsuranceId INT UNIQUE,
    PCP INT,
    FOREIGN KEY (PCP) REFERENCES PHYSICIAN (EmployeeId)
);

CREATE TABLE NURSE(
    EmployeeId INT UNIQUE PRIMARY KEY,
    Name VARCHAR(20),
    Position_Nurse VARCHAR(20),
    Registerd CHAR(1),
    SSN INT UNIQUE
);

CREATE TABLE APPOINTMENT(
    AppointmentId INT UNIQUE PRIMARY KEY,
    Patient INT,
    PrepNurse INT,
    Physician_Appointed INT,
    Appointment_Date DATE,
    Start_Time TIME,
    End_Time TIME,
    ExaminationRoom INT,
    FOREIGN KEY (Patient) REFERENCES PATIENT (SSN),
    FOREIGN KEY (PrepNurse) REFERENCES NURSE (EmployeeId),
    FOREIGN KEY (Physician_Appointed) REFERENCES PHYSICIAN  (EmployeeId)
);

-- INSERTING DATA INTO COLUMNS
-- PHYSICIAN TABLE
INSERT INTO Physician (EmployeeId, Name, Position_Physician, SSN)
VALUES
  (1, 'John Doe', 'Surgeon', 123456789),
  (2, 'Jane Smith', 'Consultant', 987654325),
  (3, 'Michael Johnson', 'Physician Assistant', 456789012),
  (4, 'Chris Davis', 'Cardiologist', 789012345),
  (5, 'David Wilson', 'Anesthesiologist', 567890123),
  (6, 'Carry Thompson', 'Pediatrician', 321549876),
  (7, 'Robert Lee', 'Oncologist', 654321098),
  (8, 'Jennifer Brown', 'Neurologist', 210987654),
  (9, 'Christoph Marti', 'Radiologist', 543218765),
  (10, 'Melissa Taylor', 'Dermatologist', 876543210);

INSERT INTO HOSPT_DEPARTMENT
VALUES(121, 'Cardiology', 1),
(222, 'Pediatrics', 3),
  (358, 'Oncology', 6),
  (478, 'Neurology', 2),
  (598, 'Radiology', 8),
  (623, 'Dermatology', 9),
  (798, 'Orthopedics',  5);
  
INSERT INTO WORKS_WITH (Physician, Department, Primary_Affiliation)
VALUES
  (1, 222, 'Y'),
  (2, 598, NULL),
  (3, 478, 'Y'),
  (4, 121, 'Y'),
  (5, 222, NULL),
  (6, 358, 'Y'),
  (7, 121, NULL),
  (8, 598, 'Y');

INSERT INTO HOSPT_PROCEDURE(Code, Name, Cost)
VALUES
  ('P001', 'Appendectomy', 5000),
  ('P002', 'Physiotherapy', 1500),
  ('P003', 'Cataract Surgery', 3000),
  ('P004', 'Knee Replacement', 10000),
  ('P005', 'Gasteric Problem', 2000),
  ('P006', 'Hernia Repair', 4000),
  ('P007', 'Angioplasty', 8000),
  ('P008', 'Mastectomy', 6000),
  ('P009', 'Laser Eye Surgery', 3500),
  ('P010', 'Hip Replacement', 12000);

INSERT INTO PATIENT(SSN, Name, Address, PhoneNumber, InsuranceId, PCP)
VALUES
  (12345678, 'John Doe', '123 Main St, City', 5551234, 987654321, 9),
  (98765432, 'Jane Smith', '456 Elm St, City', 5555678, 123456789, 4),
  (45678901, 'Michael Johnson', '789 Oak St, City', 5559012, 654321098, 2),
  (78901234, 'Emily Davis', '321 Pine St, City', 5553456, 432109876, 7),
  (56789012, 'David Wilson', '654 Maple St, City', 5556789, 210987654,1),
  (32154987, 'Sarah Thompson', '987 Cedar St, City', 5559012, 876543210,5),
  (65432109, 'Robert Lee', '210 Birch St, City', 5552345, 543218765, 1),
  (21098765, 'Jennifer Brown', '543 Spruce St, City', 5555678, 765432109, 2),
  (54321876, 'Christopher Martinez', '876 Walnut St, City', 5559012, 234567890, 7),
  (87654321, 'Melissa Taylor', '109 Pineapple St, City', 5552345, 908765432, 2);

INSERT INTO NURSE(EmployeeId, Name, Position_Nurse, Registerd, SSN)
VALUES
  (785, 'Cmily Johnson', 'Senior Nurse', 'Y', 123456789),
  (298, 'Michael Smith', 'Registered Nurse', 'N', 987654321),
  (336, 'Cessica Davis', 'Nurse Practitioner', 'Y', 456789012),
  (425, 'Sarah Wilson', 'Nurse Manager', 'Y', 789012345),
  (598, 'Cavid Thompson', 'Staff Nurse', 'N', 567890123),
  (632, 'Jennifer Brown', 'Charge Nurse', 'Y', 321549876),
  (798, 'Robert Lee', 'Operating Room Nurse', 'Y', 654321098),
  (810, 'Melissa Taylor', 'Pediatric Nurse', 'Y', 210987654),
  (906, 'Dhristopher Martinez', 'ICU Nurse', 'N', 543218765),
  (101, 'Laura Anderson', 'Emergency Nurse', 'N', 876543210);

INSERT INTO Appointment(AppointmentId, Patient, PrepNurse, Physician_Appointed, Appointment_Date, Start_Time, End_Time, ExaminationRoom)
VALUES
  (100001, 12345678, 101, 1, '2023-05-17', '10:00:00', '11:00:00', 101),
  (100002, 32154987, 336, 2, '2023-05-17', '11:30:00', '12:30:00', 102),
  (100003, 65432109, 598, 3, '2023-05-18', '09:00:00', '10:00:00', 103),
  (100004, 21098765, 785, 4, '2023-05-18', '14:00:00', '15:00:00', 104),
  (100005, 45678901, 810, 5, '2023-05-19', '10:30:00', '11:30:00', 105),
  (100006, 54321876, 906, 6, '2023-05-19', '12:00:00', '13:00:00', 106),
  (100007, 56789012, 798, 7, '2023-05-20', '13:30:00', '14:30:00', 107),
  (100008, 65432109, 632, 8, '2023-05-20', '15:00:00', '16:00:00', 108),
  (100009, 56789012, 425, 9, '2023-05-21', '09:30:00', '10:30:00', 109),
  (100010, 87654321, 298, 10, '2023-05-21', '11:00:00', '12:00:00', 110);


-- 1) Write a SQL statement to display all the information of all physicians.
SELECT * 
FROM PHYSICIAN;

-- 2) List the cost of medical procedure for 'Physiotherapy' and 'Gastric problem'
SELECT cost 
FROM HOSPT_PROCEDURE
WHERE Name='Physiotherapy' OR Name='Gasteric problem';

-- 3) Find the list of the physician who does not have any affiliations. (use NULL for not 
-- affiliated)
SELECT Physician,Primary_Affiliation
FROM WORKS_WITH
WHERE Primary_Affiliation IS Null;

-- 4) Write a SQL query to find the employees whose name begins with the character 'C'. 
-- Return empid, name and ssn. 
SELECT PHYSICIAN.EmployeeId,PHYSICIAN.Name,PHYSICIAN.SSN,NURSE.EmployeeId,NURSE.Name,NURSE.SSN
FROM PHYSICIAN,NURSE
WHERE PHYSICIAN.NAME LIKE 'C%' OR NURSE.NAME LIKE 'C%';

-- 5) Write a SQL query to find the details of the patients whose appointment time is greater 
-- than 12.30 PM for a corresponding date
SELECT APPOINTMENT.Patient,PATIENT.Name,PATIENT.Address,PATIENT.PhoneNumber
FROM APPOINTMENT,PATIENT
WHERE APPOINTMENT.Start_Time>"12:00:30" AND PATIENT.SSN=APPOINTMENT.PATIENT;


DESCRIBE PHYSICIAN;
DESCRIBE HOSPT_DEPARTMENT;
DESCRIBE WORKS_WITH;
DESCRIBE HOSPT_PROCEDURE;
DESCRIBE PATIENT;
DESCRIBE NURSE;
DESCRIBE APPOINTMENT;


SELECT * FROM PHYSICIAN;
SELECT * FROM HOSPT_DEPARTMENT;
SELECT * FROM WORKS_WITH;
SELECT * FROM HOSPT_PROCEDURE;
SELECT * FROM PATIENT;
SELECT * FROM NURSE;
SELECT * FROM APPOINTMENT;


DROP TABLE  PHYSICIAN;
DROP TABLE  HOSPT_DEPARTMENT;
DROP TABLE  WORKS_WITH;
DROP TABLE  HOSPT_PROCEDURE;
DROP TABLE  PATIENT;
DROP TABLE  NURSE;
DROP TABLE  APPOINTMENT;
