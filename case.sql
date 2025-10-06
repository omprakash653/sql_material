use itv;
select amount*100 from orders;
select amount+100 from orders;
select amount%100 from orders;

select * from orders;

select amount+id from orders;

select  * from person;

select  name+role from person; 

use world;

select name,continent,population from country order by population asc limit 1;

select name,continent,population from country order by population desc limit 1;

select name,continent,population from country where continent in("europe") order by population asc;

select name,continent,population from country where continent in("europe") order by population desc;

select * from city where countrycode="ind" order by population desc limit 5;

select * from city where countrycode in("ind","usa") order by population desc limit 5;

select * from city where countrycode="ind" order by population desc limit 1 offset 1;

select * from city where countrycode="ind" order by population desc limit 1,1;
select * from city where countrycode="ind" order by population desc limit 1,2;
select * from city where countrycode="ind" order by population desc limit 2,1;

select count(distinct(countrycode)) from city ;
select distinct countrycode from city;

select sum(population) from city;

select countrycode,sum(population) as total from city group by countrycode order by total desc;
select continent,sum(population) as total from country group by continent order by total desc;
select continent,sum(population) as total from country group by continent order by total desc limit 1,1;

select continent,count(name) as total from country group by continent;




select sum(population) from city where countrycode in("ind","usa");

select sum(population) from country where continent in("asia");
select sum(population) as total_population from country where continent in("europe");

select distinct countrycode from city where population>5000000;

select continent,sum(population) as total from country group by continent having total>500000000;

select countrycode ,sum(population) as total from city group by countrycode having total>80000000;


------------------------------------------ case
use ps321;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

INSERT INTO students (id, name, marks) VALUES
(1, 'om', 95),
(2, 'omkar', 82),
(3, 'rahul', 67),
(4, 'David', 50),
(5, 'ravi', 30);

select name,marks ,if(marks<35,"fail","pass") as status1 from students;
select name,marks ,if(marks>90,"A",if(marks>70,"B",if(marks>50,"C",if(marks>=35,"D","fail"))))
as status1 from students;

create view st_grade as select name,marks,
    CASE 
        WHEN marks >= 90 THEN 'A'
        WHEN marks >= 75 THEN 'B'
        WHEN marks >= 60 THEN 'C'
        WHEN marks >= 40 THEN 'D'
        ELSE 'F'
    END AS grade
FROM students;
select * from st_grade;
ALTER TABLE students ADD COLUMN status VARCHAR(10);

UPDATE students
SET status = 
    CASE 
        WHEN marks >= 90 THEN 'Topper'
        WHEN marks >= 75 THEN 'Excellent'
        WHEN marks >= 60 THEN 'Good'
        WHEN marks >= 40 THEN 'Average'
        ELSE 'Fail'
    END;

SELECT id, name, marks, status
FROM students
ORDER BY 
    CASE status
        WHEN 'Topper' THEN 1
        WHEN 'Excellent' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Average' THEN 4
        WHEN 'Fail' THEN 5
        ELSE 6
    END;
    
-------------------------------- windows function
    CREATE TABLE sales (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    region VARCHAR(20),
    amount INT
);
use itv;

select * from sales;

-- ROW_NUMBER() – Rank employees per region by amount
SELECT employee,region,amount,
ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num
FROM sales;

SELECT employee,region,amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) AS row_num
FROM sales;

-- RANK() vs DENSE_RANK() – See ranking with and without gaps
SELECT employee,region,amount,
    RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank1,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS dense_rank1
FROM sales;

SELECT employee,region,amount,
    RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank1 
FROM sales;

-- SUM() – Running total per region
SELECT employee,region,amount,
SUM(amount) OVER (PARTITION BY region ORDER BY amount) AS running_total
FROM sales;

SELECT employee,region,amount,
SUM(amount) OVER (ORDER BY amount) AS running_total
FROM sales;

-- LAG() – Show previous employee's amount
SELECT employee,region,amount,
LAG(amount) OVER (PARTITION BY region ORDER BY amount) AS previous_amount
FROM sales;
