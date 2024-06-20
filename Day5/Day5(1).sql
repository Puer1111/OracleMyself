--------------------------------------PRACTICE -------------------------------------------
create table 학과TB_DEPARTMENT(
department_no varchar2(10) primary key,
department_name varchar2(20) not null,
category varchar2(20),
OPEN_YN char(1),
CAPACITY number
);
drop table 학과TB_DEPARTMENT;
select * from 학과TB_DEPARTMENT;
comment on column 학과TB_DEPARTMENT.DePARTMENT_NO is '학과 번호';
comment on column 학과TB_DEPARTMENT.DePARTMENT_Name is '학과 이름';
comment on column 학과TB_DEPARTMENT.category is '계열';
comment on column 학과TB_DEPARTMENT.OPEN_YN is '개설 여부';
comment on column 학과TB_DEPARTMENT.capacity is '정원';

alter table 학과TB_DEPARTMENT rename constraint SYS_C007188 to department_no ;

create table tb_student(
student_no varchar2(10) primary key,
department_no varchar2(10) not null, FOREIGN key(department_no) REFEREnces 학과tb_department(department_no),
student_name varchar2(30) not null,
student_ssn varchar2(14),
student_address varchar2(100),
entrance_date date,
absence_yn char(1),
coach_professor_no varchar2(10)
);
comment on column tb_student.student_NO is '학생 번호';
comment on column tb_student.department_no is '학과 번호';
comment on column tb_student.student_name is '학생 이름';
comment on column tb_student.student_ssn is '학생 주민번호';
comment on column tb_student.student_address is '학생 주소';
comment on column tb_student.entrance_date is '입학 일자';
comment on column tb_student.absence_yn is '휴학 여부';
comment on column tb_student.coach_professor_no is '지도 교수 번호';

create table TB_class(
Class_no varchar2(10) primary key,
department_no varchar2(10) not null,
preattending_class_no varchar2(10),
class_name varchar2(30) not null,
class_type varchar2(10)
);


-----------------------------------------------------------------------------------------------------
commit;
