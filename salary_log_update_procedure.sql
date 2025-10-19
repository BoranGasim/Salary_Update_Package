
/***************************************
CREATE OR REPLACE PROCEDURE log_salary_update (
    p_employee_id   IN NUMBER,
    p_old_salary    IN NUMBER,
    p_new_salary    IN NUMBER,
    p_message       IN VARCHAR2,
    p_error_code    IN NUMBER DEFAULT NULL,
    p_error_message IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    INSERT INTO salary_update_log (
        employee_id, old_salary, new_salary, message, error_code, error_message
    )
    VALUES (
        p_employee_id, p_old_salary, p_new_salary, p_message, p_error_code, p_error_message
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Logging error: ' || SQLERRM);
END;
/
  ***************************************/
