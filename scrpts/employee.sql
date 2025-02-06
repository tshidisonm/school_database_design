-- Create the base table
CREATE TABLE employee (
    emp_id INT DEFAULT nextval('employee_id_seq') PRIMARY KEY,
    emp_firstname check_only_letters NOT NULL,
    emp_lastname check_only_letters NOT NULL,
    emp_date_of_birth DATE NOT NULL,
    emp_email check_email_validation,
    emp_phone_number check_validate_phone_numbers,
    emp_address TEXT NOT NULL,
    emp_status TEXT NOT NULL,
    emp_salary INT NOT NULL CHECK (emp_salary > 0),
    emp_type VARCHAR(20) CHECK (emp_type IN ('Teacher', 'Principal', 'Secretary'))
);

-- Create specialized tables
CREATE TABLE principal (
    principal_id INT DEFAULT nextval('special_pk_id') UNIQUE NOT NULL,
    qualification TEXT NOT NULL
) INHERITS (employee);

CREATE TABLE teacher (
    teacher_id INT DEFAULT nextval('special_pk_id') UNIQUE NOT NULL,
    qualification TEXT NOT NULL
) INHERITS (employee);

CREATE TABLE secretary (
    secretary_id INT DEFAULT nextval('special_pk_id') UNIQUE NOT NULL,
    principal_id INT NOT NULL,
    CONSTRAINT secretary_principal_fk FOREIGN KEY (principal_id) REFERENCES principal(principal_id)
) INHERITS (employee);

-- Create a unique index on email across all tables in the inheritance hierarchy
CREATE UNIQUE INDEX unique_email_idx ON ONLY employee(emp_email);
CREATE UNIQUE INDEX principal_email_idx ON principal(emp_email);
CREATE UNIQUE INDEX teacher_email_idx ON teacher(emp_email);
CREATE UNIQUE INDEX secretary_email_idx ON secretary(emp_email);

-- Create a constraint trigger function to ensure email uniqueness across all tables
CREATE OR REPLACE FUNCTION check_email_unique()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM (
            SELECT emp_email FROM employee
            UNION ALL
            SELECT emp_email FROM principal
            UNION ALL
            SELECT emp_email FROM teacher
            UNION ALL
            SELECT emp_email FROM secretary
        ) all_emails
        WHERE emp_email = NEW.emp_email
        AND emp_email IS NOT NULL
    ) THEN
        RAISE EXCEPTION 'Email address must be unique across all employee types';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for each table
CREATE TRIGGER employee_email_unique
    BEFORE INSERT OR UPDATE ON employee
    FOR EACH ROW
    EXECUTE FUNCTION check_email_unique();

CREATE TRIGGER principal_email_unique
    BEFORE INSERT OR UPDATE ON principal
    FOR EACH ROW
    EXECUTE FUNCTION check_email_unique();

CREATE TRIGGER teacher_email_unique
    BEFORE INSERT OR UPDATE ON teacher
    FOR EACH ROW
    EXECUTE FUNCTION check_email_unique();

CREATE TRIGGER secretary_email_unique
    BEFORE INSERT OR UPDATE ON secretary
    FOR EACH ROW
    EXECUTE FUNCTION check_email_unique();