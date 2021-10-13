-----UC1-------------
---Create DataBase---
Create database payroleservice;
use payroleservice;

---------UC2-----------
---Create table for DataBase---
CREATE TABLE employee_payroll(
	Id int Identity(1,1) PRIMARY KEY,
	--Identity is a method--
	Name varchar (200),
	Salary float,
	StartDate date
	);

--------UC3 insert operation--------
INSERT INTO employee_payroll VALUES('Akhshya','125245','2016/03/01') ,('Akhil','13335','2018/01/05'),('kabir','525245','2019/03/01');

--------UC4-----------
---Retrieve all data from employee_payroll
select * from employee_payroll;

-----------Uc5-----------------------
---------Retrieve Specific Data-------
select Name,StartDate from employee_payroll where Name='Akhil';
select * from employee_payroll where StartDate between cast('2005-01-01' as date) and getdate();

--------------Uc6------------------------
-----------Alter the table to add gender---
alter table employee_payroll add Gender char(1);
update employee_payroll set Gender='M';
update employee_payroll set Gender='F' where Id='1';

-------------------------Uc7----------------------------------------
----calculate sum,avergae,min,max,count of employee ased on gender---
select SUM(Salary) as TotalSalary,Gender from employee_payroll group by Gender;
select AVG(Salary) as AverageSalary from employee_payroll group by Gender;
select count(Salary) as TotalSalary,Gender from employee_payroll group by Gender;
select Min(Salary) as MinSalary,Gender from employee_payroll group by Gender;
select Max(Salary) as MaxSalary,Gender from employee_payroll group by Gender;

---Uc8---
alter table employee_payroll add PhoneNumber bigint;
alter table employee_payroll add Department varchar(250) not null default 'HR';
alter table employee_payroll add Address varchar(250) default 'bangaluru';
select * from employee_payroll;
