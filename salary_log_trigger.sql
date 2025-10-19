CREATE OR REPLACE TRIGGER trg_salary_update_log
AFTER UPDATE OF salary ON employees_copy
FOR EACH ROW
BEGIN
    INSERT INTO salary_update_log (
        employee_id,
        old_salary,
        new_salary,
        log_user
    )
    VALUES (
        :OLD.employee_id,
        :OLD.salary,
        :NEW.salary,
        USER  
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Logging error: ' || SQLERRM);
END;
/