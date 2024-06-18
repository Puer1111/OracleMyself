create table user_no_constraint(
user_num number,
user_id varchar2(20),
user_pwd varchar2(20),
user_name varchar2(30),
user_gender varchar(10),
user_phone varchar2(30),
user_email varchar2(50)
);
select * from user_no_constraint;
--1 khuser01 pass01 일용자 남 01028227373 khuser01@gmail.com
Insert into user_no_constraint
values(1,'khuser01','pass01','일용자','남',01028227373,'khuser01@gmail.com');

select * from user_no_constraint;
update user_no_constraint set user_phone = '01028227373'
where user_phone = 01028227373;
commit;
rollback;
insert INTO user_no_constraint
values(null,null,null,null,null,null,null);

create table user_notnull ( -- notnull
user_num number,
user_id varchar2(20) not null,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10),
user_phone varchar2(30),
user_email varchar2(50)
);
drop table user_notnull;
select * from user_notnull;
insert into user_notnull
values(1,'khuser01','pass01','일용자',null,null,null);

create table user_unique ( --unique 사용
user_num number,
user_id varchar2(20) unique,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10),
user_phone varchar2(30),
user_email varchar2(50)
);
insert into user_unique
values(1,'khuser01','pass01','일용자','남',01028227373,'khuser01@gmail.com');
select * from user_unique;

create table user_primary_key ( --primarykey 사용
user_num number,
user_id varchar2(20) PRIMARY key,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10),
user_phone varchar2(30),
user_email varchar2(50)
);
insert into user_primary_key
values(1,'khuser01','pass01','일용자','남',null,null);
select * from user_primary_key;
drop table primary_key;

create table user_check (
user_num number,
user_id varchar2(20) PRIMARY key,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10) check(user_gender in ('M','F')), --data에 해당 단어만 기입되게함
user_phone varchar2(30),
user_email varchar2(50)
);
insert into user_check values(1,'khuser01','pass01','일용자','M','01028227373','khuser01@gmail.com');
insert into user_check values(2,'khuser02','pass01','이용자','F','01028227373','khuser01@gmail.com');
select * from user_check;
delete from user_check where user_pwd = 'pass01';
commit;

create table user_default (
user_num number,
user_id varchar2(20) PRIMARY key,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10) check(user_gender in ('M','F')), --data에 해당 단어만 기입되게함
user_phone varchar2(30),
user_email varchar2(50),
user_date date default sysdate
);
-- default 값 미리 지정해두고 해당 위치에 default만 작성.
drop table user_default;
insert into user_default values (1,'khuser01','pass01','일용자','M','01082829292','khuser01@naver.com','24/06/14');
select * from user_default;
insert into user_default values (2,'khuser02','pass02','이용자','M','01082829292','khuser01@naver.com',sysdate);
insert into user_default values (3,'khuser03','pass03','일용자','M','01082829292','khuser01@naver.com',default);

create table user_grade(
    grade_code number ,
    grade_name varchar2(30)
);

select *from user_grade;
insert into user_grade values (10,'일반회원');
insert into user_grade values (20,'우수회원');
insert into user_grade values (30,'특별회원');
insert into user_grade values (40,'VIP회원');

delete from user_grade where grade_code = 40;

create table user_foreign_key1(
user_num number primary key,
user_id varchar2(20) unique not null,
user_pwd varchar2(30) not null,
user_name varchar2(30)not NULL,
user_gender varchar(10) check(user_gender in ('M','F')), --data에 해당 단어만 기입되게함
user_phone varchar2(30),
user_email varchar2(50),
user_date date default sysdate,
grade_code number references user_grade(grade_code) on delete cascade
);
drop table user_foreign_key1;
insert into user_foreign_key1 
values (1,'khuser01','pass01','일용자','M','01082829292','khuser01@naver.com',default,10);
insert into  user_foreign_key1 
values (2,'khuser02','pass02','이용자','M','01082829292','khuser01@naver.com',default,20);
insert into  user_foreign_key1  
values (3,'khuser03','pass03','삼용자','M','01082829292','khuser01@naver.com',default,30);
insert into  user_foreign_key1  
values (4,'khuser04','pass04','사용자','M','01082829292','khuser01@naver.com',default,40);

update user_foreign_key1 set grade_code = 40 where user_id = 'khuser04'; 

select * from user_foreign_key1;
delete from user_grade where grade_code=40;


--on delete set null
-- 해당 레코드 값이 지워질 시 null 로 자동 대체
--on delete cascade 
-- 부모 테이블의 레코드 값이 지워지면 해당 값을 외래키로 받은 테이블의 값도 지워진다.

--ex)
--table: shop_member
--data : 1. khuser01, pass01,일용자,M,01082829292,khuser01@gmail.com

--table: shop_buy
--data: 1. khuser01 , 농구화 ,24/06/14


--A. ID가 외래 키로 buy에서 member의 ID로 정보를 확인하는 시스템이기에 ID에 외래키 작성.
create table shop_member(
user_num number primary key,
user_id varchar2(20) unique not null,
user_pwd varchar2(30) not null,
user_name varchar2(30) not NULL,
user_gender varchar(10) check(user_gender in ('M','F')), --data에 해당 단어만 기입되게함
user_phone varchar2(30),
user_email varchar2(50)
);
insert into shop_member values(1, 'khuser01', 'pass01','일용자','M','01082829292','khuser01@gmail.com');
select * from shop_member;

create table shop_buy(
buy_no number primary KEY,
user_id varchar2(30) references shop_member(user_id) on delete set null,
user_purchase varchar2(20),
user_date date default sysdate
);

insert  into shop_buy values ( 1., 'khuser01' , '농구화' ,default);
insert  into shop_buy values ( 2., 'khuser02' , '축구화' ,default); 
-- khuser02 안되는 이유는 shop member에 khuser02가 없어서 이다.
select * from shop_buy;
drop table shop_buy;


--constraint
--Not null: null 못들어가게 한다
--unique : 고유한 값 중복 x ,null 가능
--primary key : 기본 키 , null+unique
--check : check(컬럼명 in (값) ) 지정 값만 들어가게 한다.
--default: 사전에 설정해둔 값 default만 작성 시 출력.
--foreign key: 자식 테이블에서 부모 테이블이 가지고 있는 컬럼의 필드값으롬나 insert하도록 하는 것
-- "참조 무결성" 을 보장하는 제약조건
--외래 키 명령어: references 부모테이블(컬럼명) 삭제옵션(on delete set null , on delete cascade)
-- 삭제 옵션
--1. on delete restricted 지우기 제한
--2. on delete cascade 연관된 모든 것 삭제
--3. on delete set null null로 만든다.