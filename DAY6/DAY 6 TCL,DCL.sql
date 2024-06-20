--Day 6 TCL/DCL--
--TCL ( Transaction control language)

--COMMIT , ROLLBACK , SAVEPOINT

--트랜잭션이란?
--한꺼번에 수행되어야 할 최소한의 작업 단위
--ATM출금 ,계좌이체 등이 트랜잭션의 예

--1.카드 투입
--2. 메뉴 선택
--3. 금액 입력
--4. 비밀번호 입력
--5. 출금 완료

--1. 송금 버튼 터치
--2. 계좌번호 입력
--3. 은행명 선택
--4. 금액 입력
--5. 비밀번호 입력
--6. 이체 버튼 터치

--ORACLE DBMS 트랜잭션
--INSERT 수행 or update 수행 or delete 수행이 되었따면 그 뒤에 추가 작업이 
--있을 것으로 간주하고 처리 -> 트랜잭션이 걸렸다
desc user_grade;
alter table user_grade drop column reg_date;
insert into user_grade
values(10,'일반회원');

commit;
--commit :트랜잭션 작업이 완료 되어 변경 내용을 영구히 저장(모든 Save Point 삭제)
--rollback : 트랜잭션 작업을 모두 취소하고 가장 최근 commit 지점으로 이동.
--savepoint <savepoint명>: 현재 트랜잭션 작업 시점에 이름 저장.
-- 임시저장이라고 하고 하나의 트랜잭션에서 구역을 나눌 수 있음

create table user_tcl(
user_no number unique,
user_id varchar2(30) primary key,
user_name varchar2(20) not null
);
desc user_tcl;
insert into user_tcl values ( 1,'khuser01','일용자');
commit;
insert into user_tcl values ( 2,'khuser02','이용자');
commit;
insert into user_tcl values ( 3,'khuser03','삼용자');
savepoint until3;
select * from user_tcl;
commit;

rollback;
rollback to until3;
--DCL
--DB에 대한 보안,무결성,복구 등 DBMS를 제어하기 위한 언어다.
--GRANT , REVOKE ,(COMMIT , ROLLBACK )
--권한부여 및 회수는 System_계정에서만 가능

select * from CHUN.tb_class;
--KH에게는 chun에 있는 tb_class를 조회할 권한이 없음.
--권한 부여 해야한다.
grant select on CHUN.TB_CLASS to KH;
revoke select on CHUN.TB_CLASS From kh;
