## stored Prodcedure--Compiled format
## functions
## Triggers

USE FUNCTIONS;


create table student_info(
id int,
student_code varchar(30),
first_name varchar(25),
subjects varchar(30),
marks float
);

insert into student_info values(1,"100","Om","Data Science",50),
(2,"102","Onkar","Machine Learning",70),
(3,"103","John","Physics",80),
(4,"104","Rohan","Chemistry",90),
(5,"105","Virat","Cricket",100),
(6,"106","tony","Dhoni",70);

select * from student_info;
DROP PROCEDURE `rank`;

call  new_procedure();

/* CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`()
BEGIN
select * from student_info where marks>80;
END */

/*CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(in marks float)
BEGIN
select * from student_info where student_info.marks>marks;
END */
call  new_procedure(85);

use world;
show tables;

desc city;

call city_pop('maharashtra');


# multiple o/p procedure
/* CREATE DEFINER=`root`@`localhost` PROCEDURE `ranked_stud`(in marks float)
BEGIN
select * from student_info where marks.student_info>marks;
select count(id) as total from student_info;
END */
call ranked_stud(70);

/*output
CREATE DEFINER=`root`@`localhost` PROCEDURE `top_merks`(out highestmarks float)
BEGIN
select max(marks) into highestmarks from student_info;
END
*/
call top_merks(@output);
select @output;

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_marks`(inout student_code varchar(25))
BEGIN
select marks into student_code from student_info where student_info.student_code=student_code limit 1;
END
*/
set @om=110;
call display_marks(@om);
select @om;

select * from student_info;
insert into student_info
values(10,110,'ram','AI',95);


use erdiagram;
show tables;
show databases;
use itvedant;

show tables;
select * from employee1;
-- tcl
 start transaction;
 SET SQL_SAFE_UPDATES = 0;

 update employee1 
 set salary=700 where name="om";
 
commit;
 
start transaction;
 
savepoint first_savepoint;

delete from employee1 where name="HR";
 
rollback to first_savepoint;


-- trigger
-- create trigger triggername
-- before/after update/delete/insert
-- on tablename for each row
-- begin
-- statement
-- end

-- create table empcopy 
-- (id int, name varchar(20), salary int);

DELIMITER $

-- create trigger insertemp
-- before insert
-- on employee1 for each row
-- begin
-- insert into empcopy(id,name,salary) values(new.id, new.name, new.salary);
-- end$





