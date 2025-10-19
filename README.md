#  Employee Salary Update Package (PL/SQL)

This project demonstrates a PL/SQL implementation for managing and auditing employee salary updates in an Oracle database.
It showcases:

Modular PL/SQL design (packages, subprograms)

Automatic logging using database triggers

Use of associative arrays and bulk operations for performance

# Overview

The goal of the system is to:

Identify employees whose salaries are below a company-defined minimum.
Increase those salaries automatically to meet a standard or add a raise.
Record every salary update in a log table, including old vs new salary and the user who performed the change.

Two approaches were designed:
A logging procedure (commented out for reference).
A simpler trigger-based logging mechanism — the active method.

#Components

#EMPLOYEES_COPY
A working copy of the HR.EMPLOYEES table.  
Used for testing and updates without affecting real data.

sql
CREATE TABLE employees_copy AS
SELECT * FROM hr.employees;

# How to Run

Execute salary_log_table.sql to create the logging table.
Run salary_log_trigger.sql to create the trigger.
Optionally review or uncomment the logging procedure in salary_log_procedure.sql.
Compile and execute salary_update_package.sql.
Call the package procedure:

BEGIN
    EMP_PKG.increase_low_salaries;
END;
/


Check the log table:

SELECT * FROM salary_update_log;