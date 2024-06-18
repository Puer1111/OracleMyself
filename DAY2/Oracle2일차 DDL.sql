--DDL
--Data Definition Language 데이터 정의어
-- 오라클의 객체를 생성, 수정, 삭제하는 명령
-- Create , Alter , Drop, TRUNCATE...
commit;
comment on column EMPLOYEE .T_CODE IS '직급코드';
comment on column employee .name IS '사원명';
comment on column employee .D_code IS '부서코드';
comment on column employee .age IS '나이';

-- comment on column 테이블명.컬럼명 IS '변경 내용';

desc employee; -- Describe employee

--접속 정보 KH/ KH
-- 접속 권한 , 생성 권한 부여.
create user KH identified by KH;
grant connect to KH;
grant resource to KH;

--kh violet
-- alter(오라클 객체)
-- Alter: 제약조건 추가 , 수정 ,이름 변경
-- 컬럼 추가, 수정, 컬럼 데이터 타입 수정 , 컬럼명 수정, 테이블명 수정, 컬럼 삭제
select * from user_constraints where table_name ='EMPLOYEE';
select * from user_constraints where table_name ='DEPARTMENT';
alter table user_constraints modify 
---------------------------------------------------------------------------
desc user_grade;
--테이블 컬럼 추가 , 삭제 , 데이터타입 수정, 컬럼명 수정, 테이블 명 수정
alter TABLE user_grade add grade_date date; 
alter table user_grade DROP COLumn grade_date;
alter table user_grade modify grade_name char(12);
alter table user_grade rename column grade_date to reg_date;
alter table user_grade rename to grade_TBL;
rename grade_TBL to user_grade;
desc grade_TBL;
-----------------------------------------------------------------------------
create table user_grade(
    grade_code number ,
    grade_name varchar2(30) 
);
select *from user_grade;
insert into user_grade values (10,'일반회원');
insert into user_grade values (20,'우수회원');
insert into user_grade values (30,'특별회원');
insert into user_grade values (40,'VIP회원');
---------------------------------------------------------------

create table user_foreign_key1(
user_num number,
user_id varchar2(20),
user_pwd varchar2(30),
user_name varchar2(30),
user_gender varchar(10) , --data에 해당 단어만 기입되게함
user_phone varchar2(30),
user_email varchar2(50),
user_date date default sysdate,
grade_code number
);

insert into user_foreign_key1 
values (1,'khuser01','pass01','일용자','M','01082829292','khuser01@naver.com',default,10);
insert into  user_foreign_key1 
values (2,'khuser02','pass02','이용자','M','01082829292','khuser01@naver.com',default,20);
insert into  user_foreign_key1  
values (3,'khuser03','pass03','삼용자','M','01082829292','khuser01@naver.com',default,30);
insert into  user_foreign_key1  
values (4,'khuser04','pass04','사용자','M','01082829292','khuser01@naver.com',default,40);
-------------------------------------------------------------------------------
CREATE TABLE USER_FOREIGN_KEY(
    USER_NO NUMBER ,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) ,
    USER_NAME VARCHAR2(30),
    USER_GENDER VARCHAR2(10) ,
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE,
    GRADE_CODE NUMBER 
);
INSERT INTO USER_FOREIGN_KEY
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', null, null, DEFAULT, 10);
INSERT INTO USER_FOREIGN_KEY
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', null, null, DEFAULT, 20);
INSERT INTO USER_FOREIGN_KEY
VALUES(3, 'khuser03', 'pass03', '삼용자', 'M', null, null, DEFAULT, 30);
INSERT INTO USER_FOREIGN_KEY
VALUES(4, 'khuser04', 'pass04', '사용자', 'M', null, null, DEFAULT, 40);


drop table user_foreign_key;
select * from user_foreign_key;
------------------------------------------------------------------------------------------
-- 제약조건 & Alter 
--1. 제약 조건 추가
--2. 제약 조건 삭제
--3. 제약 조건 수정

------1-----
alter table user_grade add constraint pk_grade_code primary key(grade_code);
alter table user_foreign_key add constraint fk_grade_code foreign key(grade_code) references user_grade(grade_code);
------2------
alter table user_grade DROP constraint pk_grade_code ;

-----------------------------------------------------------------------------
--ex1 user_foreign_key 테이블에 suer_date date 컬럼 추가 
--ex1 user_foreign_key 테이블에 suer_date date 컬럼 삭제 
--ex1 user_foreign_key 테이블에 suer_date date 컬럼 자료형 varchar2(10)으로 변경
--ex1 user_foreign_key 테이블에 suer_date date 컬럼의 이름을 reg_date 로 변경
--ex1 user_foreign_key 테이블의 이름을 user_tbl로 바꿔주세요
------------------------------------------------------------------------
alter table user_foreign_key add user_date date;
alter table user_foreign_key DROP column user_date;
alter table user_foreign_key modify user_date varchar2(10); 
alter table user_foreign_key rename column user_date to REG_date;
alter table user_foreign_key rename to user_TBL;
rename user_TBL to user_foreign_key;