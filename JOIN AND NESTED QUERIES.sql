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

-- JOIN AND NESTED QUERIES

-- Find the names of all branches and names of their managers
SELECT Employee.first_name,Employee.last_name,Branch.branch_name
FROM Employee,Branch
WHERE Employee.emp_id=Branch.mgr_id;
--OR
SELECT Employee.first_name,Employee.last_name,Branch.branch_name
FROM Employee
INNER JOIN Branch
ON employee.emp_id=Branch.mgr_id;
--OR
SELECT Employee.first_name,Employee.last_name,Branch.branch_name
FROM Employee
LEFT JOIN Branch
ON employee.emp_id=Branch.mgr_id;
--OR
SELECT Employee.first_name,Employee.last_name,Branch.branch_name
FROM Employee
RIGHT JOIN Branch
ON employee.emp_id=Branch.mgr_id;


-- Inner Join: Returns only the matching rows from both tables based on the specified join condition. It excludes any unmatched rows from either table.

-- Left Join (or Left Outer Join): Returns all the rows from the left (or first) table and the matching rows from the right (or second) table. If there are no matches, NULL values are included for the columns of the right table.

-- Right Join (or Right Outer Join): Returns all the rows from the right (or second) table and the matching rows from the left (or first) table. If there are no matches, NULL values are included for the columns of the left table.


-- Find names of all employees who have sold over 50,000
SELECT Works_with.emp_id,Employee.first_name,SUM(Works_with.total_sales) AS Total_Sales
FROM Works_with,Employee
WHERE Total_Sales>50000 AND Works_With.emp_id=Employee.emp_id
GROUP BY Works_with.emp_id;
-- OR
SELECT Employee.first_name
FROM Employee
WHERE Employee.emp_id IN (
    SELECT Works_with.emp_id
    FROM Works_with
    WHERE Works_with.total_sales>50000
    GROUP BY Works_with.emp_id
);



-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT Client.cliet_name
FROM Client
WHERE Client.branch_id IN(
    SELECT Branch.branch_id
    FROM Branch
    WHERE Branch.mgr_id = 102
);


-- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
SELECT Client.cliet_name
FROM Client
WHERE Client.branch_id IN(
    SELECT Branch.branch_id
    FROM Branch
    WHERE Branch.mgr_id IN (
        SELECT Employee.emp_id
        FROM Employee
        WHERE Employee.first_name='Michael' AND
        Employee.last_name='Scott'
    )
);

-- Find the names of employees who work with clients handled by the scranton branch
SELECT Employee.First_Name,Employee.Last_Name
FROM Employee
WHERE Employee.emp_id IN (
    SELECT Works_With.emp_id
    FROM Works_With
    WHERE Works_With.client_id IN (
        SELECT Client.client_id
        FROM Client
        WHERE Client.branch_id IN (
            SELECT Branch.branch_id
            FROM Branch
            WHERE Branch_name = 'Scranton'
        )
    )
);

-- Find the names of all clients who have spent more than 100,000 dollars
SELECT Client.cliet_name,SUM(Works_With.total_sales) AS Total_Sales 
FROM   Client,Works_With 
WHERE  Total_Sales> 100000 AND Works_With.client_id=Client.client_id
GROUP BY Works_With.client_id ;
-- OR

SELECT client.cliet_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000
);




SELECT Works_with.emp_id,Employee.first_name
FROM Works_with,Employee
WHERE SUM(Works_with.total_sales)>50000 AND Works_With.emp_id=Employee.emp_id
GROUP BY Works_with.emp_id;

SELECT * 
FROM Employee;

SELECT * 
FROM Branch;

SELECT * 
FROM Client;

SELECT * 
FROM Works_With;

SELECT * 
FROM Branch_Supplier;


DROP TABLE Branch;
DROP TABLE Employee;
DROP TABLE Client;
DROP TABLE Works_With;
DROP TABLE Branch_Supplier;