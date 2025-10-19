
-- Package specification
CREATE OR REPLACE PACKAGE EMP_PKG AS
    TYPE emp_table_type IS TABLE OF employees_copy%ROWTYPE INDEX BY PLS_INTEGER;

    v_salary_increase_rate  NUMBER := 1000;
    v_min_employee_salary   NUMBER := 5000;

    FUNCTION get_employees RETURN emp_table_type;
    FUNCTION get_employees_to_be_incremented RETURN emp_table_type;
    FUNCTION arrange_for_min_salary(v_emp IN OUT employees_copy%ROWTYPE)
        RETURN employees_copy%ROWTYPE;
    PROCEDURE increase_low_salaries;
END EMP_PKG;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY EMP_PKG AS

    FUNCTION get_employees RETURN emp_table_type IS
        v_emps emp_table_type;
        TYPE t_emps IS TABLE OF employees_copy%ROWTYPE;
        v_temp t_emps;
    BEGIN
        SELECT * BULK COLLECT INTO v_temp FROM employees_copy;

        FOR i IN 1 .. v_temp.COUNT LOOP
            v_emps(v_temp(i).employee_id) := v_temp(i);
        END LOOP;

        RETURN v_emps;
    END;

    FUNCTION get_employees_to_be_incremented RETURN emp_table_type IS
        v_emps emp_table_type;
    BEGIN
        FOR r IN (SELECT * FROM employees_copy WHERE NVL(salary, 0) < v_min_employee_salary) LOOP
            v_emps(r.employee_id) := r;
        END LOOP;
        RETURN v_emps;
    END;

    FUNCTION arrange_for_min_salary(v_emp IN OUT employees_copy%ROWTYPE)
        RETURN employees_copy%ROWTYPE IS
    BEGIN
        v_emp.salary := NVL(v_emp.salary, 0) + v_salary_increase_rate;
        IF v_emp.salary < v_min_employee_salary THEN
            v_emp.salary := v_min_employee_salary;
        END IF;
        RETURN v_emp;
    END;

    PROCEDURE increase_low_salaries AS
        v_emps emp_table_type;
        v_emp  employees_copy%ROWTYPE;
        i      employees_copy.employee_id%TYPE;
        --v_old_salary NUMBER;
    BEGIN
        v_emps := get_employees_to_be_incremented;
        i := v_emps.FIRST;

        WHILE i IS NOT NULL LOOP
            BEGIN
               -- v_old_salary := v_emps(i).salary;
                v_emp := arrange_for_min_salary(v_emps(i));

                UPDATE employees_copy
                SET salary = v_emp.salary
                WHERE employee_id = i;
    /****************************************************
                log_salary_update(i, v_old_salary, v_emp.salary,
                                   'Salary updated successfully');
            EXCEPTION
                WHEN OTHERS THEN
                    log_salary_update(i, v_old_salary, NULL,
                                      'Error during salary update',
                                      SQLCODE, SQLERRM);
    *****************************************************************/
            END;
            i := v_emps.NEXT(i);
        END LOOP;
    END;

END EMP_PKG;