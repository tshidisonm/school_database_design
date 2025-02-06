--Dummy data

-- Insert Principals
INSERT INTO principal (
    emp_firstname, emp_lastname, emp_date_of_birth, emp_email,
    emp_phone_number, emp_address, emp_status, emp_salary,
    emp_type, qualification
) VALUES 
    ('Sarah', 'Thompson', '1975-03-15', 'sarah.thompson@school.com',
    '+12025550181', '789 Leadership Ave, New York, NY 10001', 'Active', 95000,
    'Principal', 'PhD in Educational Leadership');

-- Insert Teachers
INSERT INTO teacher (
    emp_firstname, emp_lastname, emp_date_of_birth, emp_email,
    emp_phone_number, emp_address, emp_status, emp_salary,
    emp_type, qualification
) VALUES 
    ('John', 'Smith', '1985-06-12', 'john.smith@school.com',
    '+12025550101', '123 Teacher Lane, New York, NY 10003', 'Active', 65000,
    'Teacher', 'Masters in Mathematics Education');

-- Insert Secretary 
INSERT INTO secretary (
    emp_firstname, emp_lastname, emp_date_of_birth, emp_email,
    emp_phone_number, emp_address, emp_status, emp_salary,
    emp_type, principal_id
) VALUES 
    ('Patricia', 'Martinez', '1990-02-28', 'patricia.martine@zschool.com',
    '+12025550201', '123 Staff Road, New York, NY 10008', 'Active', 45000,
    'Secretary', 1015);


