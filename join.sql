create database joins;
use joins;

-- -----------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);

-- -----------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
alter table orders add column amount float;

INSERT INTO orders (orderid, customerid, orderdate, amount) 
VALUES 
(101, 1, '2024-02-01', 1200),
(102, 2, '2024-02-02', 800),
(103, 1, '2024-02-03', 400),
(104, 3, '2024-02-04', 500),
(105, 37, '2024-02-05', 1500);

INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country) VALUES
(4, 'Rohan Kumar', 'rohan', 'bharat'),
(2, 'Anita Desai', 'Anita', 'India'),
(3, 'Amit Sharma', 'Amit', 'India'), 
(37, 'Suresh Gupta', 'Suresh', 'India');

-- inner join
use joins;

select customers.customerid,customers.customername ,orders.amount from customers 
inner join orders on customers.customerid=orders.customerid
order by amount desc limit 1 offset 1;
 
select c.customername,c.country ,o.orderid,o.orderdate from customers as c
left join orders as o on c.customerid=o.customerid ;

select c.customername,c.country ,o.orderid,o.orderdate from customers as c
right join orders as o on c.customerid=o.customerid ;

select c.customername,c.country ,o.orderid,o.orderdate from customers as c
cross join orders as o on c.customerid=o.customerid ;

select c.customername,c.country ,o.orderid,o.orderdate from customers as c
left join orders as o on c.customerid=o.customerid 
union
select  c.customername,c.country ,o.orderid,o.orderdate from customers as c
right join orders as o on c.customerid=o.customerid ;

use joins;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);

INSERT INTO employees (id, name, manager_id) VALUES 
(1, 'om', NULL),   
(2, 'omkar', 1),        
(3, 'rahul', 1),      
(4, 'rohan', 2),      
(5, 'karan', 2);     
select * from employees;
SELECT 
e1.id AS employee_id, 
e1.name AS employee_name, 
e2.id AS manager_id, 
e2.name AS manager_name
FROM employees e1
LEFT JOIN employees e2  
ON e1.manager_id = e2.id;
   
   
-- tcl
CREATE TABLE IF NOT EXISTS Products1 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    Price DECIMAL(10, 2),
    Stock INT
);
show tables;

INSERT INTO Products1 (Name, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 799.99, 50),
('Smartphone', 'Electronics', 599.99, 150),
('Shoes', 'Fashion', 49.99, 200),
('Headphones', 'Electronics', 89.99, 80),
('T-shirt', 'Fashion', 19.99, 300);

select * from products1;

SET SQL_SAFE_UPDATES = 0;

delete from products1 where name='laptop';

select * from products1;

rollback;

select * from products1;

start transaction ;

select * from products1;

delete from products1 where name='shoes';

rollback; -- undo the records

select * from products1;

start transaction;
SET SQL_SAFE_UPDATES = 0;

update products1 set name='abc' where id=4;
update products1 set stock=90 where id=4;

savepoint first_savepoint3; -- partial changes

insert into products1(Name, Category, Price, Stock)
values('apple','electronic',4567,25);

select * from products1;

rollback to first_savepoint3;

select * from products1;

commit; -- permanant changes

use joins;
show tables;
select * from products1;

delete from products1 where id=3;
select * from products1;

rollback; -- undo the records

select * from products1;

start transaction;

delete from products1 where id=4;
select * from products1;

rollback;

select * from products1;


CREATE TABLE IF NOT EXISTS Products2 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    Price DECIMAL(10, 2),
    Stock INT
);
show tables;

INSERT INTO Products2 (Name, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 799.99, 50),
('Smartphone', 'Electronics', 599.99, 150),
('Shoes', 'Fashion', 49.99, 200),
('Headphones', 'Electronics', 89.99, 80),
('T-shirt', 'Fashion', 19.99, 300);

select * from products2;

start transaction;

delete from products2 where id=2;

savepoint fourth_savepoint; -- partially delete but will not 

delete from products2 where id=1;

select * from products2;

rollback to fourth_savepoint;

select * from products2;



create database join1;
use join1;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);
-- -----------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
amount float
);
#alter table orders add column amount float;-- 

INSERT INTO orders (orderid, customerid, orderdate, amount) 
VALUES  
(101, 1, '2024-02-01', 1200),
(102, 2, '2024-02-02', 800),
(103, 3, '2024-02-03', 400),
(104, 4, '2024-02-04', 500),
(105, 37, '2024-02-05', 1500);

INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country) VALUES
(1, 'Rohan Kumar', 'rohan', 'bharat'),
(12, 'Anita Desai', 'Anita', 'India'),
(13, 'Amit Sharma', 'Amit', 'India'), 
(37, 'Suresh Gupta', 'Suresh', 'India');

select * from customers;
select * from orders;


select customers.customerid,customers.ContactName,orders.amount,orders.orderdate from customers inner join orders 
on customers.customerid =orders.customerid;

select c.customerid,c.ContactName,o.amount,o.orderdate from customers as c inner join orders as o 
on c.customerid =o.customerid;

select c.customerid,c.ContactName,o.amount,o.orderdate from customers as c left join orders as o 
on c.customerid =o.customerid;

select c.customerid,c.ContactName,o.amount,o.orderdate from customers as c right join orders as o 
on c.customerid =o.customerid;

select c.customerid,c.ContactName,o.amount,o.orderdate from customers as c inner join orders as o 
on c.customerid =o.customerid where ContactName="suresh";

select c.customerid,c.ContactName,o.amount,o.orderdate from customers as c inner join orders as o 
on c.customerid =o.customerid order by amount desc limit 1;

---------------------------------------------------------------------
use joins;
CREATE TABLE branch1_employees (
    employee_id INT,
    name VARCHAR(100)
);

CREATE TABLE branch2_employees (
    employee_id INT,
    name VARCHAR(100)
);

INSERT INTO branch1_employees VALUES
(1, 'Amit'),
(2, 'Priya'),
(3, 'Rahul');

INSERT INTO branch2_employees VALUES
(4, 'Sneha'),
(5, 'Amit'),    
(6, 'Kiran');

SELECT name FROM branch1_employees
UNION
SELECT name FROM branch2_employees;

SELECT name FROM branch1_employees
UNION ALL
SELECT name FROM branch2_employees;

show tables;
drop table employees;

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT,
    name VARCHAR(100),
    department_id INT
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance');

INSERT INTO employees (employee_id, name, department_id) VALUES
(101, 'Amit', 1),
(102, 'Priya', 2),
(103, 'Rahul', 1),
(104, 'Sneha', 3),
(105, 'Kiran', NULL);

select * from  departments;
select * from employees;  

-- inner join
select departments.department_name,employees.name from departments
inner join employees on employees.department_id =departments.department_id;

select d.department_name,e.name from departments as d
inner join employees as e on e.department_id =d.department_id; 

select * from departments as d
cross join employees as e on e.department_id =d.department_id; 

-- full join
select * from departments as d
left join employees as e on e.department_id =d.department_id
union
select * from departments as d
right join employees as e on e.department_id =d.department_id;

 


-- INNER JOIN: Only employees with a valid department_id
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT JOIN: All employees listed, department shown if it matches
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- RIGHT JOIN: All departments listed, employee shown if it matches
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;


-- full join

SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
union
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;


-----------------------------------------------------------------------------------------------------------------

CREATE TABLE employees_self (
    employee_id INT,
    name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees_self VALUES
(1, 'Amit', NULL),
(2, 'Priya', 1),
(3, 'Rahul', 1),
(4, 'Sneha', 2),
(5, 'Kiran', 2);

SELECT e.name AS employee_self,m.name AS manager
FROM employees_self as e
LEFT JOIN employees_self as m ON e.manager_id = m.employee_id;

use joins;
-- joins with three tables
CREATE TABLE Customers1 (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100)
);

CREATE TABLE Orders1 (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  FOREIGN KEY (customer_id) REFERENCES Customers1(customer_id)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100)
);
INSERT INTO Customers1 VALUES
  (1, 'rohit'),
  (2, 'rohan');
  
INSERT INTO Customers1 VALUES
  (3, 'om'),
  (4, 'omkar');

INSERT INTO Products VALUES
  (10, 'Laptop'),
  (20, 'Tablet');
 
INSERT INTO Orders1 VALUES
  (100, 1, 10), 
  (101, 2, 20); 

SELECT Customers1.customer_name,Orders1.order_id,Products.product_name
FROM Customers1
INNER JOIN Orders1 ON Customers1.customer_id = Orders1.customer_id
INNER JOIN Products ON Orders1.product_id = Products.product_id;

show tables;

select * from customers1;
select * from orders1;

SELECT customer_name
FROM Customers1
WHERE customer_id IN (
  SELECT customer_id FROM Orders1
);


-- create view
CREATE VIEW Brazil_Customers AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';

-- DROP VIEW view_name;


---------------------------------------
-- subquery in new database
create database subquery;
use subquery;

use subquery;
-- Create the Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);
select * from categories;

-- Insert sample data into Categories
INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Books'),
('Clothing'),
('Home Goods');

-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Insert sample data into Products
INSERT INTO Products (product_name, price, category_id) VALUES
('Laptop', 1200.00, 1),
('Smartphone', 800.00, 1),
('Headphones', 150.00, 1),
('The Great Gatsby', 15.99, 2),
('1984', 12.50, 2),
('T-Shirt', 25.00, 3),
('Jeans', 60.00, 3),
('Coffee Maker', 75.00, 4),
('Blender', 90.00, 4),
('Mystery Novel', 10.00, 2),
('Smartwatch', 300.00, 1);


SELECT product_name, price
FROM Products
WHERE price = (SELECT MAX(price) FROM Products);   

SELECT product_name, price
FROM Products
WHERE price = 1200; 

select product_name,price from products
where price= (select min(price) from products);


select product_name,price from products
where price< (select avg(price) from products);

select product_name,price from products
where price> (select avg(price) from products);

SELECT product_name, price
FROM Products
WHERE category_id IN (SELECT category_id FROM Categories WHERE category_name = 'Electronics');

SELECT product_name, price
FROM Products
WHERE category_id IN (1);
