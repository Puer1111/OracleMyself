--DAY 7 오라클 객체 - ROLE 

-- Oracle object
--DB를 효율적으로 관리 또는 동작하게 하는 요소


-- 종류--
-- User, Table , View , Sequence ,Role ,Index
-- Procedure , Function, Trigger , SYSNONYM , CurSor , Package ...

--3. Role 
--3.1 개요
-- 사용자에게 여러 개의 권한을 한번에 부여할 수 있는 데이터베이스 객체
-- 사용자에게 권한을 부여할 때 한개씩 부여하게 된다면 권한 부여 및 회수의 관리가
--  불편하므로 사용하는 객체이다.
Select * from DBA_SYS_PRIVS; -- Only System

Grant Connect , Resource to KH;
-- connect , resource 는 권한이 모여있는 Role이다
--ROle 에 부여된 권한 확인


select * from DBA_sys_privs where grantee = 'Connect';
select * from DBA_SYS_PRIVS where GRANTEE = 'RESOURCE';
--create view 권한이 resource role 에 없었기에 따로 권한 부여
--grant create view to kh;
select * from role_sys_privs where role = 'Connect';
--Role에 부여된 테이블 권한
seelct * from roble_tab_privs;
--계정에 부여된 롤과 권한
select* from user_role_privs;
select * from USER_SYS_PRIVS;
------------------------------------------------------------------------------------------------------
--4. INDEX
-- 4.1 개요
-- SQL 명령문의 처리속도를 향상시키기 위해 컬럼에 대해서 생성하는 오라클 객체
-- KEY와 Value형태로 생성이 되며 KEY에는 인덱스로 만들 컬럼값 , VAlue 에는 행이 저장된 주소값이 저장됨

--장점:검색속도가 빨라지고 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상 시킬 수 있음

--단점: 인덱스를 위한 추가 저장 공간이 필요하고 인덱스를 생성하는데 시간이 걸림

--데이터의 변경 작업이 자주 일어나는 테이블에 INDEX생성시 오히려 성능 저하가 발생할 수 있음

-- 어떤 컬럼에 인덱스를 만들면 좋을것인가 
--데이터 값이 중복이 없는 고유한 데이터값을 가지는 컬럼에 만드는 것이 가장 좋음.

-- 그리고 자주 사용되는 컬럼에 만들면 좋음 - 절대적이진 않다.
-- * 효율적인 인덱스 사용 예
-- 1. WHERE절에 자주 사용되는 컬럼에 인덱스 생성
--  > 전체 데이터 중에 10 ~ 15% 이내의 데이터를 검색하는 경우, 중복이 많지 않은 컬럼이어야 함.
-- 2. 두 개 이상의 컬럼 WHERE절이나 조인(JOIN)조건으로 자주 사용되는 경우
-- 3. 한번 입력된 데이터의 변경이 자주 일어나지 않는 경우
-- 4. 한 테이블에 저장된 데이터 용량이 상당히 클 경우

select * from employee;

--인덱스 생성
create index ind_emp_ename on employee(emp_name);
select * from user_indexes;
select * from user_ind_columns;
--인덱스 삭제
Drop index ind_emp_ename;
--------------------------
Create Index ind_emp_info
on employee (emp_id , Emp_no , salary);
select emp_id , emp_no ,salary from employee;

--튜닝 시 사용되는 명령어
--#1 
Explain plan for select emp_id , emp_no , salary from employee where emp_id like '2%';
select * from table (DBMS_XPLAN.display);
--#2
SET TIMING ON select emp_id , emp_no , salary from employee where emp_id like '2%';
set timing off;
--F10 으로 실행하여 오라클 PLAN확인 가능, 튜닝시 사용됨.

-------------------------------------------------------------------------------------------------

--DCL Review 
--Data Control Language -> Grant / Revoke
--권한 부여 및 회수는 관리자 계정에서 가능
--관리자:
--System : 일반 관리자 , 대부분의 권한을 가지고 있다
--SYS : DB 생성/삭제 권한 있다 옵션으로 as sysdba적어야함