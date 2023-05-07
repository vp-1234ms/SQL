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

-- 1)FIND THE TOTAL EMPLOYEE:
SELECT COUNT(emp_id)
FROM EMPLOYEE;

-- 2)Find the average of all employee's salaries
SELECT AVG(emp_id)
FROM EMPLOYEE;

-- 3)Find the sum of all employee's salaries
SELECT SUM(emp_id)
FROM EMPLOYEE;

-- 4)Find out total distinct gender
SELECT COUNT(DISTINCT sex)
FROM EMPLOYEE;

-- 5)Find out how many males and females there are
SELECT COUNT(sex),sex
FROM EMPLOYEE
GROUP BY sex;

-- 6)Find the total sales of each salesman
SELECT Sum(total_sales) as total_sales,emp_id
FROM Works_With
GROUP BY emp_id
ORDER BY total_sales DESC;

-- 7)Find the total amount of money spent by each client
SELECT SUM(Works_With.total_sales) as Total_Money_Spent,Works_With.client_id,Client.cliet_name
FROM Works_With,Client
WHERE Works_With.client_id=Client.client_id
GROUP BY Client.client_id
ORDER BY  Total_Money_Spent DESC;



DROP TABLE Branch;
DROP TABLE Employee;
DROP TABLE Client;
DROP TABLE Works_With;
DROP TABLE Branch_Supplier;