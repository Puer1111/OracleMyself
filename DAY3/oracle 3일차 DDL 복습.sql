--Day 3 
--DDL review
--DDL : Data Definition Language
-- create, alter,drop
--create: user , table
--drop table (table)
--alter: table 명 변경 , column 명 , 데이터 타입 추가 , 수정 , 삭제
--constraint 추가 , 삭제 , 수정
---------------------------------------------------------------------------------
--ex1 user_foreign_key 테이블 user_date date 컬럼 추가
desc user_foreign_key;
alter table user_foreign_key add reg_date date;
--ex2 user_foreign_key 테이블 user_date date 컬럼 삭제
alter table user_foreign_key drop column reg_date;
--ex1 user_foreign_key 테이블 user_date date 컬럼 자료형 varchar2 로 수정
alter table user_foreign_key modify reg_date varchar2(10);
--ex1 user_foreign_key 테이블 reg_date 을 user_datee 로 변경
alter table user_foreign_key rename column reg_date to user_datee;
alter table user_foreign_key rename column user_datee to reg_date;
--ex1 user_foreign_key 테이블 user_date varchar2를 date 로 변경
alter table user_foreign_key modify reg_date date;
-- user_foreign_key 를 user_tbl로 바꾸기
alter table user_foreign_key rename to user_tbl;
rename user_tbl to user_foreign_key;
--제약 조건 추가 , 삭제 , 수정
select * from user_constraints;
select * from user_grade;
alter table user_constraints add user_tbl varchar2(10);
select * from user_constraints where table_name = 'USER_TBL';
-- 제약 조건 not null, default 추가는 살짝 다름
alter table USER_TBL modify USER_ID not null;
alter table USER_TBL modify USER_DATE default SYSDATE;
--user_grade 가 가지고 있는 pk 삭제 후 같은이름으로 재 생성
-- 제약 조건 수정은 삭제하고 추가하는거 단 이름은 바꿀 수 있다.
select * from user_constraints where table_name ='USER_GRADE' ; -- 조회

alter table USER_GRADE drop constraint PK_GRADE_CODE;--삭제

alter table user_grade add constraint pk_grade_code primary key (grade_code); -- 재 생성


alter table user_constraints add user_grade varchar2(20);
-- foreign key 등록
alter table user_tbl add foreign key(grade_code) references user_grade(grade_code);

alter table user_tbl drop constraint sys_c007147;
-- 제약조건 constraint fk_grade_code 이름 붙히기
alter table user_tbl add constraint fk_grade_code foreign key(grade_code) references user_grade(grade_code);
--제약조건 활성화  / 비활성화
alter table user_tbl enable constraint FK_GRADE_CODE;

alter table user_tbl disable constraint FK_GRADE_CODE;

select * from user_constraints where table_name= 'USER_TBL';

commit;
