create database functions; 
use functions; 
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50), 
    email VARCHAR(100)
);

INSERT INTO employees (name, department, email) VALUES 
('Alice Johnson', 'Sales', 'alice.johnson@example.com'),
('Bob Smith', 'Marketing', 'bob.smith@example.com'),
('Charlie Brown', 'IT', 'charlie.brown@example.com'),
('David Williams', 'HR', 'david.williams@example.com');

SELECT name, LENGTH(name) AS name_length FROM employees;

SELECT name, UPPER(name) AS name_uppercase, LOWER(name) AS name_lowercase FROM employees;

-- first & last characters
SELECT name, LEFT(name, 5) AS first_five_letters FROM employees;

SELECT department, RIGHT(department, 3) AS last_three_letters FROM employees;

SELECT email, SUBSTRING_INDEX(email, '@',1) AS name1 FROM employees;
SELECT email, SUBSTRING_INDEX(email, '@',-1) AS domain_name FROM employees;

SELECT email, INSTR(email, '.') AS dot_position FROM employees; 
select * from employees; 

SELECT name, department, REPLACE(department, 'Marketing', 'Digital Marketing') AS updated_department FROM employees;

-- SELECT name, TRIM(name) AS trimmed_name FROM employees;

SELECT CONCAT(name, ' (', department, ')') AS employee_info FROM employees;

SELECT CONCAT(name, " ", department) AS employee_info FROM employees;
SELECT CONCAT(name, " ", "yadav") AS employee_info FROM employees;

SELECT name, REVERSE(name) AS reversed_name FROM employees;

-- math functions

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT
);

INSERT INTO products (name, price, quantity) VALUES 
('Laptop', 750.50, 5),
('Smartphone', 499.99, 10),
('Tablet', 299.49, 8),
('Smartwatch', 199.99, 15);

select * from products;
select name,price*quantity as total from products;

SELECT name, price, (price +500) AS price_difference FROM products;
SELECT name, price, ABS(price - 500) AS price_difference FROM products;

SELECT name, price, CEIL(price) AS ceiling_price, FLOOR(price) AS floor_price FROM products;

SELECT name, price, ROUND(price) AS rounded_price FROM products; 

SELECT name, price, SQRT(price) AS sqrt_price FROM products;

SELECT name, price, POWER(price, 2) AS squared_price FROM products;
SELECT POWER(10, 2);
SELECT RAND() AS random_number;
select mod(14  ,3) reminder;
SELECT name, price, MOD(10, 3) AS remainder FROM products;
SELECT name, price, MOD(price , 3) AS remainder FROM products;
select sum(price/2) as half from products;

-- date function

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE
);

INSERT INTO orders (customer_name, order_date, delivery_date) VALUES 
('Alice', '2024-02-01', '2024-02-07'),
('Bob', '2024-02-03', '2024-02-10'),
('Charlie', '2024-02-05', '2024-02-12'),
('David', '2024-02-07', '2024-02-15');
use functions;
select * from orders;
-- SELECT CURDATE() AS current_date;
SELECT NOW() AS current_datetime;

SELECT order_date, YEAR(order_date) AS year1, MONTH(order_date) AS month, DAY(order_date) AS day FROM orders;

SELECT order_date, YEAR(order_date) AS year FROM orders;

SELECT order_date, DAYNAME(order_date) AS day_name FROM orders;
 
SELECT order_date, DAYOFYEAR(order_date) AS day_of_year FROM orders;
  
SELECT order_date, DATE_ADD(order_date, INTERVAL 7 DAY) AS new_date FROM orders;

SELECT order_date, DATE_ADD(order_date, INTERVAL 1 MONTH) AS new_date FROM orders;

SELECT order_date, DATE_SUB(order_date, INTERVAL 3 DAY) AS new_date FROM orders;

SELECT order_date, DATE_FORMAT(order_date, '%M %d, %Y') AS formatted_date FROM orders;

SELECT order_date, LAST_DAY(order_date) AS last_day_of_month FROM orders;

use functions;
SELECT name, price, 
       IF(price > 500, 'Expensive', 'Affordable') AS price_category
FROM products;

SELECT name, price,
       CASE 
		   WHEN price > 700 THEN 'Very Expensive'
           WHEN price BETWEEN 400 AND 700 THEN 'Moderate'
           ELSE 'Cheap'
       END AS price_category 
FROM products;

UPDATE products
SET price = 
    CASE 
        WHEN price > 700 THEN price * 0.90  -- 10% discount for expensive items
        WHEN price BETWEEN 400 AND 700 THEN price * 0.95  -- 5% discount
        ELSE price  -- No discount for cheap items
    END;

use functions;
show tables;

select * from employees;
insert into employees
values(1,"mohan","HR","mohan@gmail.com"),
(2,"sohan","Marketing","sohan@gmail.com");
# tCL

# Commit
# rollback
# savepoint

start transaction ;

select * from employees;

delete from employees where id = 1 ;

rollback ;

select * from employees ;

start transaction ;

select * from employees ;
   
delete from employees where id in (1,2);
savepoint first_savepoint;
insert into employees() values (100, 'virat', 'cricket','sdfg') ;
rollback to first_savepoint  ;
select * from employees ;
delete from employees where id =101;
select * from employees;


start transaction;
delete from employees where id =1;
select * from employees;

rollback;
select * from employees;

start transaction;
insert into employees
values(1001,'rohan','AI','rohan@gmail.com');

select * from employees;

rollback;
select * from employees;

start transaction;

delete from employees where id in(1,2);
select * from employees;

rollback;
select * from employees;

start transaction;
delete from employees where id =102;

commit;

insert into employees
values(23,'pooja','IT','pooja@gmail.com');

rollback;
select * from employees; 

start transaction;
savepoint first_savepoint;

delete from employees where id=1;

savepoint second_savepoint;
delete from employees where id=2;
select * from employees;
rollback to second_savepoint;

select * from employees; 
commit;
delete from employees where id=3;
rollback; 

-- List all customers who have at least one completed booking. 
--  Show all feedback with a rating below 4.
--  Find the total fare paid in completed bookings by each customer.
-- List all drivers' names and their assigned cab numbers.
-- Which cab type has generated the highest revenue so far?
--  For each pickup location, what is the average trip distance?
-- Which driver has received the lowest average feedback rating?
-- Find all customers whose last booking was cancelled.







