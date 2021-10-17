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
------updating values of created colomns------
update employee_payroll set PhoneNumber = '1252453698',Address = 'Chennai' where Name = 'Madhuri';
update employee_payroll set PhoneNumber = '2214587875',Address = 'Banglore',Department = 'Sales' where Name = 'Akhshya';
update employee_payroll set PhoneNumber = '9817753647',Address = 'Bhubaneswar' where Name = 'Akhil';
update employee_payroll set PhoneNumber = '7375787969',Address = 'Hyderabad', Department = 'Customer Service' where Name = 'kabir';

---Uc9---
---RenameColomn name in existing table(Salary renamed as Basic pay)---
Exec sp_rename 'employee_payroll.Salary', 'BasicPay','COLUMN';
alter table employee_payroll add TaxablePay float, Deduction float,IncomeTax float,NetPay float;
Update employee_payroll set Deduction = '4000' where Department = 'HR';
Update employee_payroll set Deduction = '3000' where Department = 'Sales';
Update employee_payroll set Deduction = '2000' where Department = 'Customer Service';
Update employee_payroll set NetPay = (BasicPay-Deduction);
Update employee_payroll set TaxablePay = '1000';
Update employee_payroll set IncomeTax = '200';
select * from employee_payroll;

---------UC10---------
------Create duplicate of person-------
INSERT INTO employee_payroll(Name,BasicPay,StartDate,Gender,PhoneNumber,Department,Address,TaxablePay,Deduction,IncomeTax,NetPay) VALUES('Terissa','525245','2018/03/01','F','7345787969','Sales','Chennai','1000','4000','200','522245');
INSERT INTO employee_payroll(Name,BasicPay,StartDate,Gender,PhoneNumber,Department,Address,TaxablePay,Deduction,IncomeTax,NetPay) VALUES('Terissa','525245','2018/03/01','F','7345787969','Marketing','Chennai','0','0','0','0');
---------Two ids for terissa created for single person, so to remove this we use ER diagram-------

-------------UC11-------------
------By implimentaing ER, redoing UC 7--------------
-----Create table--------Company Details---
create table company
(
company_Id int identity(1,1) primary key,
company_name varchar(255)
)
Insert into company values('Microsoft'),('Google')
select * from company

--Create table--Employee Details---
create table Employee
(
EmployeeId int identity(1,1) primary key,
EmployeeName varchar(255),
Gender char(1),
EmployeePhoneNumber bigint,
EmployeeAddress varchar(255),
StartDate date,
CompanyId int
Foreign key(CompanyId) references Company(company_Id)
)
Insert into Employee values('Veer','M','7812453698','Mumbai','2020-10-07','1'),('Venkat','M','7214587875','Banglore','2019-05-08','2'),('Priyanka','F','7345787969','Chennai','2021-01-17','2'),('Sushmita','F','9814753647','Mysore','2017-12-12','2');
select * from Employee;

--Create table---Payroll table---
create table payroll
(
empId int 
foreign key(empId) references Employee(EmployeeId),
BasicPay float,
TaxablePay float,
IncomeTax float,
Deductions float,
NetPay float
)
Insert into payroll(empId,BasicPay,IncomeTax,Deductions)values('1','950000','30000','25000'),('2','550000','20000','20000'),('3','450500','19000','20000'),('4','350500','20000','18400');
select * from payroll;
Update payroll set TaxablePay = (BasicPay-Deductions)
Update payroll set NetPay = (TaxablePay-IncomeTax)
select * from payroll;

-----Department and employee has many many relation so two diffrent table needed
---Dept Table---
create table department_table
(
DepartmentId int identity(1,1) primary key,
DeptName varchar(255)
)
insert into department_table values('Developement'),('Marketing'),('HR'),('Sales');
select * from department_table

----Creating Employee Department table-----
create table emp_Dept
(
EmpId int
foreign key(EmpId) references Employee(EmployeeId),
DeptId int
foreign key(DeptId) references department_table(DepartmentId),
)
insert into emp_Dept values('1','3'),('2','1'),('3','4'),('4','3');
--creating duplicate, means same person works at different dept--
insert into emp_Dept values('4','2');
select * from emp_Dept;

