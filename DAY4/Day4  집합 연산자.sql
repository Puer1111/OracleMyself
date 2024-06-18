--Day 4 집합 연산자
--1.1 합집합
----union , union all (중복 허용)
-- union 사용 조건: 컬럼이 같아야 한다. , 컬럼의 데이터 타입이 같아야 한다.
select emp_name , salary from employee
where dept_code = 'D5'
union
select emp_name, salary from employee
where salary >= 2400000;

select emp_name , salary from employee
where dept_code = 'D5'
union all
select emp_name, salary from employee
where salary >= 2400000;
-------------------------------------------------
--1.2 교집함
--1.2.1 INTERSECT

select emp_name , salary from employee
where dept_code = 'D5'
INTERSECT
select emp_name, salary from employee
where salary >= 2400000;
-----------------------------------------------------
--1.3 차집합
--1.3.1 minus
select emp_name , salary from employee
where dept_code = 'D5'
MINUS
select emp_name, salary from employee
where salary >= 2400000;
------------------------------------------------------