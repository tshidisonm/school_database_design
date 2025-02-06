-- must link to class
create table student(
	student_no int default nextval('student_id_seq') primary key,
	student_firstname check_only_letters not null,
	student_lastname check_only_letters not null, 
	student_gender varchar(6) check (student_gender in ('Male', 'Female')) not null,
	student_email check_email_validation not null,
	student_phone_number check_validate_phone_numbers not null,
	student_national_id int not null
);
alter table student 
add column class_id int
references classroom(class_id)

select * from student


create table student_exam(
	student_exam_id serial primary key,
	student_no int references student(student_no),
	exam_id int references exam(exam_id),
	mark_attained int check(mark_attained between 0 and 100),
	exam_outcome text check(exam_outcome in ('Pass', 'Fail'))
);

create table student_subject(
	id serial primary key,
	student_no int references student(student_no) not null,
	subject_id int references subject(subject_id)not null
);

create sequence test_number
cycle
start with 1000
increment by 1
cache 1;

create table test(
	test_id int default nextval('test_number') primary key,
	test_name text not null,
	test_description text not null,
	test_date date,
	subject_id int references subject(subject_id)
);

create table student_test(
	student_test_id serial primary key,
	student_no int references student(student_no),
	test_id int references test(test_id),
	mark_attained int check(mark_attained between 0 and 100),
	weight int not null,
	test_outcome text check(test_outcome in ('Pass', 'Fail'))
);

create sequence classroom_seq
no cycle
start with 10
increment by 1

create table classroom(
	class_id int default nextval('classroom_seq') primary key,
	class_name varchar(30) not null,
	class_capacity int,
	class_type varchar(30)
);

INSERT INTO classroom (class_id, class_name, class_capacity, class_type)
VALUES 
    (nextval('classroom_seq'),'Mathematics Room', 30, 'Lecture'),
    (nextval('classroom_seq'),'Physics Lab', 45, 'Laboratory'),
    (nextval('classroom_seq'),'Biology Lab', 45, 'Laboratory'),
    (nextval('classroom_seq'),'Chemistry Lab', 35, 'Laboratory'),
    (nextval('classroom_seq'),'English Room', 30, 'Lecture'),
    (nextval('classroom_seq'),'History Room', 30, 'Lecture'),
    (nextval('classroom_seq'),'Geography Room', 30, 'Lecture');

create table subject_classroom(
	id serial primary key,
	class_id int references classroom(class_id),
	subject_id int references subject(subject_id),
	date_assign date not null,
	time_slot timestamp not null
);

