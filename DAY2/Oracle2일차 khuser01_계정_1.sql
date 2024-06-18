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
commit;