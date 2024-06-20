-- DAY 6 Oracle 객체

/*
=========================== 1. view ======================
1.개요
실제 테이블에 근거한 논리적인 가상의 테이블(사용자에게 하나의 테이블 처럼 사용 가능하게 함)
-SELECT 쿼리의 실행 결과를 화면에 저장한 논리적인 가상의 테이블(실질적인 데이터를 저장하고 있지 않지만 하나의 테이블처럼 사용 가능함).

1.2종류
1.2.1 Stored View (저장 O) - 이름을 붙혀서 저장함
1.2.2 Inline View (저장 X) - From 절 뒤에 적는 서브쿼리

1.3 특징
-테이블에 있는 데이터를 보여줄 뿐이며 데이터 자체를 포함하고 있는 것은 아님 
-저장장치 내에 물리적으로 존재하지 않고 가상 테이블로 만들어짐
-물리적인 실제 테이블과의 링크 개념
-컬럼에 산술연산을 하여도 view 생성가능
-join을 활용한 view 생성 가능

1.4 목적
-원본 테이블이 아닌 뷰를 통해 특정 데이터만 보이도록함
-특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게하는 것을 방지함.




*/
Create view emp_view 
as select emp_id , dept_code , job_code,Manager_id from employee;
-- View 를 만들떄에는 권한이 필요하다 권한명 : create view 
grant create view to KH;
select * from emp_view;
---Inline view 
select * from (select emp_id,dept_code , job_code , manager_id from employee);
--View ex ) 연봉 정보를 가지고 있는 view 를 생성하시오 ( ANNUAL_SALARY_ViEW)
--사번 이름 급여 연봉
create view annual_salary_view(사번,이름,급여,연봉)
as select emp_id , emp_name , salary , salary*12 from employee;
-- view ex) 전체 직원의 사번, 이름, 직급명, 부서명, 지역명을 볼 수 있는 VIEW를 생성하시오(ALL_INFO_VIEW)
select * from location;
select *from job;
select * from department;
select * from employee;

create View ALL_INFO_VIEW(사번,이름,직급명,지역명,부서명)
as select emp_id, emp_name , job_name,local_name,dept_title from employee join job using (job_code) join department on dept_code = dept_id join location on location_id = local_code;

--1.5 view 옵션

--view 수정 ,제거 ,생성
create view v_employee 
as select emp_id , emp_name ,dept_code,job_code from employee;
--선동일 dept_code를 db로 바꾼다
update employee set dept_code ='D8' where emp_id='200';
--결론: view 수정시 원본도 수정 됨
rollback;
--view에 컬럼 추가하여 만들고 싶다면
-- 제거 후 만들기
drop view v_employee;
create view v_employee 
as select emp_id , salary, emp_name ,dept_code,job_code from employee;

--1.5.1 --view 수정 ==  or replace
create or replace view v_employee 
as select emp_id , salary, emp_name ,dept_code,job_code from employee;
--1.5.2 FORCE/NOFORCE
--기본 테이블이 존재하지 않더라도 뷰를 생성하는 옵션
--1.5.3 WITH CHECK OPTION
--WHERE 조건에 사용한 컬럼의 값을 수정하지 못하게 하는 옵션
--1.5.4 WITH READ ONlY
--VIEW에 대해 조회만 가능하며 DML불가능하게 하는 옵션
create or replace view v_employee as select emp_id,emp_name,dept_code,job_code from employee with read only;

update V_employee set emp_name = '선동열' where emp_id = '200';
--read only 라 안됨

---------------------------------------------------------------------------------------------------
-- VIEW실습예제1
-- KH계정 소유의 한 EMPLOYEE, JOB, DEPARTMENT 테이블의 일부 정보를 사용자에게 공개하려고 한다.
-- 사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일의 컬럼정보를 뷰(V_EMP_INFO)를 (읽기 전용으로)
-- 생성하여라.
select* from employee;
select * from department;
select * from job;
CREATE or replace View kh.V_EMP_INFO(사원아이디,사원명,직급명,부서명,관리자명,입사일) as select emp_id ,emp_name , job_name , (select dept_title from department where dept_id = e.dept_code)   , 
nvl((select emp_name from employee where emp_id = e.manager_id) ,'없음') , hire_date from employee e join job using (job_code) with read only;
--선생님 ver.
CREATE or replace View kh.V_EMP_INFO(사원아이디,사원명,직급명,부서명,관리자명,입사일) as select emp_id ,emp_name , job_name , nvl(dept_title,'없음') , nvl((select emp_name from employee where emp_id = e.manager_id) ,'없음') , 
hire_date from employee e left outer join job using (job_code) left outer join department on dept_code = dept_id with read only;


select * from v_emp_info;
---------------------------------------------------------------------------------------------------------
--데이터 딕셔너리(DD, DataDictionary)
--> DBMS설치 시 자동으로 만들어지며 효율적으로 관리하기 위해 다양한 정보를 저장한 시스템 테이블
--> ex) user_ 
--> 데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의 작업을 할때 DM서버(오라클)에 의해 자동으로 갱신되는 테이블
-- 사용자는 데이터 디셔너리의 내용을 직접 수정하거나 삭제할 수 있음.
-- 데이터 딕셔너리 안에는 중요한 정보가 많이 있기 때문에 사용자는 이를 활용하기 위해서는 데이터 딕셔너리 뷰를 사용하게 됨.
--DD 종류
--1. user_XX : 접속한 계정이 소유한 객체등에 관한 정보 조회.
select * from user_views;
--2.ALL_XX: 접속한 계정이 권한부여 받은 것과 소유한 모든 것에 관한 정보 조회
select * from all_tables;
select* from all_views;
--3.DBA_XX: 데이터 베이스 관리자만 접근이 가능한 객체 등의 정보 조ㅚ
select * from dba_tables; --system으로만 가능
------------------------------------------------------------------------------------------------------------

--2. sequence 객체
select * from user_tcl;
--user_no 컬럼에 저장되는 데이터는 1부터 시작하여 1씩 증가함.
--일용자 일때는 1, 이용자 일때는 2 ....
--user_NO 컬럼에 들어가는 데이터는 누군가 기억하고 있어야함.
--마지막 번호가 몇번이였는지 몇씩 증가해서 들어가야하는지를 기억하고 있어야함.
-- 그 역할이 Sequence .

--2.1개요
--순차적으로 정수 값을 자동으로 새엇ㅇ하는 객체 , 자동번호 발생기의 역할
--사용법: create sequence[시퀀스명] ; -> 기본값으로 생성(1부터 1씩 증가)
-- 2.2 sequence 옵션
Create sequence seq_kh_suser_no;
drop sequence seo_kh_user_no;
--2.2.1 MINVALUE : 발생시킬 최소값 지정
select * from user_sequences;


--2.2.2 MAXVALUE : 발생시킬 최대값 지정
create sequence seq_kh_user_no minvalue 1 maxvalue 100000 start with 1 increment by 1 nocycle  nocache;
--2.2.3 START-WITH : 처음 발생시킬 시작값 지정, 기본값 1
--2.2.4 INCREMENT BY : 다음 값에 대한 증가치 , 기본값 1
--2.2.5 NOCYCLE: 시퀀스값이 최대값까지 증가를 완료하면 Cycle은 START WITH로 다시 시작함.
--2.2.6 NOCACHE: 메모리 상에서 시퀀스값을 관리 기본값20,nocache 를 안하면 갑자기 시퀀스값이 증가하게 됨.
--2.3 시퀀스 사용법
--.2.3.1 문법
 
--create sequence seo_kh_user minvalue 1 maxvalue 100000 start with 1 increment by 1 nocycle  nocache
--2.3.2 사용법
--시퀀스명.nextval 또는 시퀀스명 . currval을
--select 뒤 또는 insert into values 의 전달값으로 작성
select seq_kh_user_no.NEXTVAL from dual;
select seq_Kh_user_no.currval from dual;

delete from user_tcl;

select * from user_tcl;
insert into user_tcl values(SEQ_KH_USER_no.nextval,'khuser01','일용자');
insert into user_tcl values(SEQ_KH_USER_no.nextval,'khuser02','이용자');
insert into user_tcl values(SEQ_KH_USER_no.nextval,'khuser03','삼용자');
-----------------------------------------------------------------------------------------
---------------------------sequence ex)-------------------------------------------------
-- @실습문제1
-- 고객이 상품주문시 사용할 테이블 ORDER_TBL을 만들고, 다음과 같이 컬럼을 구성하세요.
-- ORDER_NO(주문NO) : NUMBER, PK
-- USER_ID(고객아이디) : VARCHAR2(40)
-- PRODUCT_ID(주문상품 아이디) : VARCHAR2(40)
-- PRODUCT_CNT(주문갯수) : NUMBER
-- ORDER_DATE : DATE, DEFAULT SYSDATE

-- SEQ_ORDER_NO 시퀀스를 생성하여 다음의 데이터를 추가하세요.
-- * kang님이 saewookkang상품을 5개 주문하셨습니다.
-- * gam님이 gamjakkang상품을 30개 주문하셨습니다.
-- * ring님이 onionring상품을 50개 주문하셨습니다.
Create table order_tbl(
order_no number primary key,
user_id varchar2(40),
product_id varchar2(40),
product_cnt number,
order_date date default sysdate
);

comment on column order_tbl.order_no is '주문번호';
comment on column order_tbl.user_id is '고객아이디';
comment on column order_tbl.product_id is '주문상품 아이디';
comment on column order_tbl.product_cnt is '주문갯수';
comment on column order_tbl.order_date is '주문일자';
drop table order_tbl;
select * from order_tbl;

SELECT SEQ_ORDER_NO.CURRVAL FROM DUAL; 

SELECT SEQ_ORDER_NO.NEXTVAL FROM DUAL;
insert into order_tbl values(1,'kang','saewookkang',SEQ_ORDER_NO.currVAL,default);
insert into order_tbl values(2,'gam','gamjakkang',SEQ_ORDER_NO.NEXTVAL,default);
insert into order_tbl values(3,'ring','onionring',SEQ_ORDER_NO.NEXTVAL,default);

Create sequence SEQ_ORDER_NO1 MINVALUE 1 MAXVALUE 51 start with 1 increment by 1 nocache nocycle;
alter sequence seq_order_no maxvalue 51;
alter sequence seq_order_no increment by 1;
------------------------------------------------------------------------------------------------
--ex2
-- @실습문제2
-- KH_MEMBER 테이블을 생성하세요
-- 컬럼 : MEMBER_ID, MEMBER_NAME, MEMBER_AGE, MEMBER_JOIN_COM
-- 자료형 : NUMBER, VARCHAR2(20), NUMBER, NUMBER
-- 1. ID값은 500번부터 시작하여 10씩 증가하여 저장
-- 2. JOIN_COM값은 1번부터 시작하여 1씩 증가하여 저장
-- MEMBER_ID    MEMBER_NAME     MEMBER_AGE      MEMBER_JOIN_COM
--  500             홍길동         20                  1
--  510             청길동         30                  2
--  520             외길동         40                  3
--  530             고길동         50                  4

create table kh_member(
member_id number,
member_name varchar2(20),
member_age number,
member_join_com number
);
create sequence kh_order_no start with 500 minvalue 500 maxvalue 530 increment by 10 nocycle nocache;
create sequence kh_order_no1 start with 1 minvalue 1 maxvalue 10 increment by 1 nocycle nocache;

insert into kh_member values (kh_order_no.nextval , '홍길동' , 20, kh_order_no1.nextval);
insert into kh_member values (kh_order_no.nextval , '청길동' , 30, kh_order_no1.nextval);
insert into kh_member values (kh_order_no.nextval , '외길동' , 40, kh_order_no1.nextval);
insert into kh_member values (kh_order_no.nextval , '고길동' , 50, kh_order_no1.nextval);
select * from kh_member;

-- sequence 수정 
--옵션들로 수정 하면된다 start with 은 안됌

alter sequence kh_order_no increment by 1;