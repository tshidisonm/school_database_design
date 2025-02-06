create sequence exam_number
cycle
start with 1000
increment by 1
cache 1;

select * from exam

create table exam(
	exam_id int default nextval('exam_number') primary key,
	exam_name text not null,
	exam_description text not null,
	exam_date date,
	subject_id int references subject(subject_id)
);

insert into exam(exam_id, exam_name, exam_description, exam_date, subject_id)
values
	(nextval('exam_number'),'BSc Physics','Fluid dynamics', '11/10/2026', 103),
	(nextval('exam_number'),'BSc Biology','Anatomy', '11/09/2026', 104),
	(nextval('exam_number'),'BSc English','Pronouncing', '11/08/2026', 106)