--Subject scipt
create sequence subject_code
cycle
increment by 1
start with 100
minvalue 100
maxvalue 999
cache 1;

create table subject(
	subject_id int 
);