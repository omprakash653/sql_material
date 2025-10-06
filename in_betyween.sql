show databases;

create database ITvedant;

use ITvedant;

create table students(
roll_no int,
name varchar(30),
city varchar(30),
barnch varchar(30)
);

insert into students
values(1,"om","pune","pimpri"),
(2,"shreyash","pune","pimpri");

select * from students;
select name,city from students;

create database world;
use world;

show tables;

create database gemstone_data;
use gemstone_data;