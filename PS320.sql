show databases;
create database ps320;
use ps320;
show tables;

create table course(
id int,
name varchar(50),
price float);

insert into course(id,name)
values(1,"ds"),
(2,"da"),
(3,"AI");

select * from course;
desc course;

insert into course
values(4,"fsd",78000);

select id,name from course;

-- sql contrainsts 
-- not null
select * from course;
insert into course(id,price)
values(4,45000);

create table course1(
id int ,
name varchar(50) not null,
price float);

desc course1;
insert into course1(id,name,price)
values(1,"ds",5678);

select * from course1;
-- unique
alter table course1
add unique(id);
desc course1;

insert into course1(id,name,price)
values(2,"da",56781);

 USE ps320;
 desc course1;
 
 create table customer(
 c_id int primary key,
 name varchar(50),
 age int check(age>=18)
 );
desc customer;
insert into customer
values(1,"om",18),
(2,"ravi",19),
(3,"rahul",20);

insert into customer
values(4,"OMKAR",28);

select * from customer;

create table orders(
o_id int auto_increment primary key,
amount float ,
c_id int,
foreign key (c_id) references customer(c_id));
show index from customers;

desc orders;

insert into orders(amount,c_id)
values(400,1),
(300,1),
(500,3);
select * from orders;

create index idx_id on orders(o_id);
show index from orders;

-- alter table orders drop index idx_id;

alter table orders modify amount float default 0;
desc orders;

insert into orders(c_id)
value(3);

select * from orders;

alter table customer modify column c_id int primary KEY;


use world;
select max(population) as maximum from country ;
select min(population) as minimum from country;
select sum(population) as total from country;
select count(population) as total from country;
select avg(population) as average_pop from country;

select * from country;
-- order by

select name,population from country
order by population;

select name,population from country
order by population asc;

-- top 5
select name,population from country
order by population desc limit 5;

-- bottom 5 
select name,population from country where population>0
order by population limit 5;

-- second 
select name,population from country
order by population desc limit 1 offset 1;

select name,population from country
order by population desc limit 1,1;

select name,population from country
order by population desc limit 2,3;

-- third
select name,population from country
order by population desc limit 1 offset 2;

-- group by 
select continent,sum(population) as total from country
group by continent;

select continent,sum(population) as total from country
group by continent order by total desc;


select continent,sum(population) as total from country
group by continent having total>500000000 order by total ;

select name,population from city where population>5000000;
select name,population from city having population>5000000; -- not recommended

desc city;

select countrycode, sum(population) as total from city group by countrycode
order by total desc limit 5;

select state,sum(population) as total from city where countrycode="ind" group  by state 
order by total desc;

alter table city rename column district to state;

select name,headofstate from country order by population desc limit 2;

select countrycode, count(name) as total from city where countrycode="ind";


