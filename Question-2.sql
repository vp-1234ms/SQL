CREATE TABLE Branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(20),
    mgr_id INT,
    mgr_start_date DATE
);

CREATE TABLE Employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    birth_date DATE,
    sex CHAR(1),
    salary INT,
    super_id INT,
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

ALTER TABLE Branch
ADD FOREIGN KEY (mgr_id) REFERENCES Employee(emp_id);

CREATE TABLE Client(
    client_id INT PRIMARY KEY,
    cliet_name VARCHAR(30),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Works_With(
    emp_id INT,
    client_id INT,
    total_sales INT,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);

CREATE TABLE Branch_Supplier(
    branch_id INT,
    supplier_name VARCHAR(30),
    supply_type VARCHAR(20),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

INSERT INTO Branch VALUES (1,'Corporate',100,'2006-02-09'),(2,'Scranton',102,'1992-04-06'),(3,'Stamford',106,'1998-02-19');

INSERT INTO Employee VALUES(100,'David','Wallance','1967-11-17','M',250000,NULL,1),(101,'Jan','Levinson','1961-05-11','F',110000,100,1),(102,'Michael','Scott','1964-03-15','M',75000,100,2),(103,'Angela','Martin','1971-06-25','F',63000,102,2),(104,'Kelly','Kapoor','1980-02-05','F',55000,102,2),(105,'Stanley','Hudson','1958-02-19','M',69000,102,2),(106,'Josh','Porter','1969-09-05','M',78000,100,3),(107,'Andy','Bernard','1973-07-22','M',65000,106,3),(108,'Jim','Halpert','1978-10-01','M',71000,106,3);

INSERT INTO Client VALUES(400, 'Dunmore Highschool', 2),(401, 'Lackawana Country', 2),(402, 'FedEx', 3),(403, 'John Daly Law, LLC', 3),(404, 'Scranton Whitepages', 2),(405, 'Times Newspaper', 3),(406, 'FedEx', 2);


INSERT INTO works_with VALUES(105, 400, 55000),(102, 401, 267000),(108, 402, 22500),(107, 403, 5000),(108, 403, 12000),(105, 404, 33000),(107, 405, 26000),(102, 406, 15000),(105, 406, 130000);

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper'),(2, 'Uni-ball', 'Writing Utensils'),(3, 'Patriot Paper', 'Paper'),(2, 'J.T. Forms & Labels', 'Custom Forms'),(3, 'Uni-ball', 'Writing Utensils'),(3, 'Hammer Mill', 'Paper'),(3, 'Stamford Lables', 'Custom Forms');

SELECT * 
FROM Branch;

SELECT * 
FROM Employee;

SELECT * 
FROM Client;

SELECT * 
FROM Works_With;

SELECT * 
FROM Branch_Supplier;

-- 1)EMPLOYEES HAVING MORE THAN 100K SALARY
SELECT emp_id,salary
FROM Employee
Where salary>100000
ORDER BY salary;


--2)ALL FEMALE EMPLOYEES BORN BEFORE 1970
SELECT first_name,last_name,birth_date
FROM Employee
Where birth_date<'1970-1-1'
ORDER BY birth_date;

--3)Manager ID, NAME AND SALARY OF ALL MANAGER OF BRANCH
SELECT Branch.mgr_id,Employee.first_name,Employee.last_name,Employee.salary
FROM Branch,Employee
WHERE Branch.mgr_id=Employee.emp_id
ORDER BY mgr_id;

-- 4)EMP ID AND GENDER TOP 5 EMPLOYEES WHO MADE MOST SALES  
SELECT Employee.emp_id,Employee.sex,Works_With.total_sales
FROM Employee,Works_With
WHERE Employee.emp_id=Works_With.emp_id
ORDER BY Works_With.total_sales DESC
LIMIT 5;

-- 5)FIND ALL EMPLOYEES
SELECT * 
FROM EMPLOYEE;

-- 6)ALL EMPLOYEES ORDERED BY SALARY
SELECT *
FROM EMPLOYEE
ORDER BY EMPLOYEE.SALARY DESC;

-- 7)Find all employees ordered by sex then name
SELECT *
FROM EMPLOYEE
ORDER BY EMPLOYEE.SEX,EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME;

-- 8)Find the forename and surnames names of all employees
SELECT first_name AS forename, employee.last_name AS surname
FROM employee;


-- 9)Find out all the different genders
SELECT DISTINCT EMPLOYEE.SEX AS GENDER
FROM EMPLOYEE;

-- 10)FIND ALL MALE EMPLOYEES
SELECT EMPLOYEE.FIRST_NAME , EMPLOYEE.LAST_NAME
FROM EMPLOYEE
WHERE EMPLOYEE.SEX='M';

-- 11)Find all employees at branch 2
SELECT *
FROM EMPLOYEE
WHERE EMPLOYEE.BRANCH_ID=2;

-- 12)Find all employee's id's and names who were born after 1969
SELECT EMPLOYEE.EMP_ID, EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME,EMPLOYEE.BIRTH_DATE
FROM EMPLOYEE
WHERE EMPLOYEE.BIRTH_DATE>'1969-1-1'
ORDER BY EMPLOYEE.BIRTH_DATE;

-- 13)Find all female employees at branch 2
SELECT *
FROM EMPLOYEE
WHERE branch_id='2' AND sex='F';

-- 14)Find all employees who are female & born after 1969 or who make over 80000
SELECT *
FROM EMPLOYEE
WHERE (sex='F' and birth_date>='1970-1-1') or (salary>80000);

-- 15)Find all employees born between 1970 and 1975
SELECT *
FROM EMPLOYEE
WHERE (birth_date>='1970-1-1' AND birth_date<'1976-1-1');

-- 16)Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM EMPLOYEE
WHERE first_name='Jim'or first_name='Michael' or first_name='Johnny' or first_name= 'David';

-- or

-- 16)Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM EMPLOYEE
WHERE first_name IN ('Jim', 'Michael','Johnny' ,'David');




DROP TABLE Branch;
DROP TABLE Employee;
DROP TABLE Client;
DROP TABLE Works_With;
DROP TABLE Branch_Supplier;