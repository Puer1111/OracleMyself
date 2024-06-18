show user;

create table employee(
 name varchar2(20),
 t_code varchar2(10),
 d_code varchar2(10),
 age number
 );
 
 -- 1. 컬럼의 데이터 타입없이 테이블 생성하여 오류남
 -- A. 데이터 타입 작성
 -- 2. 권한 없이 테이블을 생성하여 오류남
 -- A. system 계정에서 grant resource to khuser01 했음
 -- 3. 접속해제 후 재 접속, 새 워크시트가 아닌 기존 코드 작성된 워크시트에서 접속 선택
 -- 하여 명령어 재실행
 
 insert into employee(name,t_code,d_code,age) 
 values('일용자','t1','d1',13);
 insert into employee(name,t_code,d_code,age) 
 values('이용자','t2','d2',23);
 insert into employee(name,t_code,d_code,age) 
 values('삼용자','t3','d3',33);
 
 drop table employee;
 
 delete from employee
 where name= '일용자' and t_code='t2';
 
 update employee set t_code='t3'
 where name = '일용자';
 
 select * from employee;
 
 
 -- 이름이 Student_tbl 인 테이블 만들기
 -- 이름 나이 학년 주소 저장 할 수 있게 하고
 -- 일용자,21,1,서울시 중구를 저장해주세요
 --일용자를 사용자로 바꿔주세요
 --데이터를 삭제하는 쿼리문을 작성하고 삭제를 확인하고
 -- 테이블을 삭제하는 쿼리문을 작성하고 테이브리 사라진 걸 확인하라
 
 Create table Student_TBL(
name varchar2(20),
age number(20),
grade number,
address varchar2(20)
);

insert into Student_TBL
values('일용자',21,1,'서울시 중구');
Rollback; -- 커밋 시점으로 돌아감

update Student_TBL
set name = '사용자' where name = '일용자';
commit; -- 롤백 대비 저장.
delete from Student_TBL;

drop table Student_TBL;

select * from Student_TBL;

--아이디가 khuser02 , 비밀번호가 khuser02 생성.

show user;

-- khuser02 student table 
create table Student_tbl(
name varchar2(20),
age number,
grade number,
address varchar2(20)
);

