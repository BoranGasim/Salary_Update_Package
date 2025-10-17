#  Employee Salary Update Package (PL/SQL)

# Overview
This project is a PL/SQL package designed to automatically update employee salaries to meet a minimum salary of the company standart(for example, the salary of every employee will be over 5000), while also keeping a detailed log of every update or failure. In this example I will increase the low salaries based on salary increase rate. The high salaries will not be increased.But the low ones will be increased for once.After that increase, if any of employees still has the salary lower than company standart, it will be rounded to the minimum salary standart  

#Components

#EMPLOYEES_COPY
A working copy of the HR.EMPLOYEES table.  
Used for testing and updates without affecting real data.

sql
CREATE TABLE employees_copy AS
SELECT * FROM hr.employees;
