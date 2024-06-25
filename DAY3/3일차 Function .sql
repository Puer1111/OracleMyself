--Function--
--1. 단일 행 함수 - result 여러개
--2. 다중 행 함수 - result 한개
--ex ) select sum(salary) from employee;

--A. 숫자
--ABS(절대값) , MOD(나머지 연산) , TRUNC(소수점 이하 버림), FLOOR(버림), ROUND(반올림),CEIL(올림) 
select sysdate - hire_date from employee;
select trunc(sysdate - hire_date,2) from employee;
select FLOOR(sysdate - hire_date) from employee;
select ROUND(sysdate - hire_date) from employee;
select ceil(sysdate - hire_date) from employee;

select MOD(35,3) from dual; -- dual 가상테이블 뷰 같은거.
--B. 문자

--C. 날짜
-- ADD_MONTHS(), MONTHS_BETWEEN(), LAST_DAy(), EXTRACT, SYSDATE
select ADD_MONTHS(SYSDATE,2)FROM dual; -- 2개월 뒤
select MONTHS_BETWEEN(sysdate ,'24/05/27') from dual;
select Last_day(sysdate) from dual;
select Last_day('24/02/23')+1 from dual;
select extract (year from sysdate) from dual;
SELECT TO_CHAR(TO_DATE('2020-12-25','YYYY-MM-DD'),'DAY') FROM DUAL;
---------------ex-------------------
-- ex1) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오.
-- ex2) EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오.
-- ex3) employee 테이블에서 사원이름 , 입사일 ,입사 월 의 마지막 날을 조회하세요
-- ex4) employee 테이블에서 사원이름 , 입사 년도 ,입사 월 , 입사 일을 조회하시오.
---------------------------------------------------------------
select emp_name , hire_date , ADD_MONTHS(hire_date , 3) from employee;
select emp_name, hire_date , FLOOR(MONTHS_Between(sysdate,hire_date)) 근무개월수 from employee;
select emp_name , hire_date , last_day(hire_date) from employee;
select emp_name ,extract(year from hire_date)||'년' 년도 ,extract(month from hire_date)||'월' 월,extract(day from hire_date)||'일' 일 from employee; 
