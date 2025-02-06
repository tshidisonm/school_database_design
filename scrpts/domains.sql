-- to validate names
create domain check_only_letters as varchar(20)
check(value ~'^[A-Za-z ]+$');

-- to validate emails
create domain check_email_validation as varchar(255)
check(value ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- to validate phone numbers
create domain check_validate_phone_numbers as text
check (value ~ '^\+?[0-9]{10,15}$')
not null;



