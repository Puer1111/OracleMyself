create table job(
job_code char(2) not null,
job_name varchar2(35)
);
drop table job;
select * from job;
comment on column job.job_code IS '직급코드';
comment on column job.job_name IS '직급명';


create table department(
job_code char(2) not null,
job_name varchar2(35),
location_id char(2) not null
);

comment on column department.job_code IS '부서코드';
comment on column department.job_name IS '부서명';
comment on column department.location_id IS '지역코드';


create table employee(
emp_id varchar2(3) not null,
emp_name varchar2(20) not null,
emp_no char(14) not null,
email varchar2(25),
phone varchar2(12),
dept_code char(2),
job_code char(2) not null,
sal_level char(2) not null,
salary number,
bonus number,
mananger_id varchar2(3),
hire_date date,
ent_date date,
ent_yn char(1) default 'N'
);
drop table employee;
comment on column employee.emp_id IS '사원번호';
comment on column employee.emp_name IS ' 직원명';
comment on column employee.emp_no IS '주민등록번호';
comment on column employee.email IS '이메일';
comment on column employee.phone IS '전화번호';
comment on column employee.dept_code IS '부서코드';
comment on column employee.job_code is'직급 코드';
comment on column employee.sal_level is '급여 등급';
comment on column employee.salary is '급여';
comment on column employee.bonus is ' 보너스율';
comment on column employee.mananger_id is '관리자 사번';
comment on column employee.hire_date is '입사일';
comment on column employee.ent_date is '퇴사일';
comment on column employee.ent_yn is '퇴직 여부';


-- 200, 선동일 ,621231-1986634 ,sun-di#kh.or.kr, 01099546325
-- D9,J1,S1,8000000, 0.3 , x ,2013,02,06 ,X ,N 

Insert into employee values (200,'선동일','621231-1986634','sun-di@kh.or.kr',01099546325,
'D9','J1','S1',8000000,0.3,null,'2013/02/06',null ,default); 
select * from employee;
select * from employee where emp_id = '200';