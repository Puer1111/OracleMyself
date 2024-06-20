--Day 5 sub query--
/* 
Sub Query: 하나의sql 문 안에 포함되어 있는 또 다른sql문
메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계
서브쿼리는 반드시 소괄호로 묶어야 함
서브쿼리 안에 order by는 지원 안됨 주의
------------------------------------------
--1.2 서브 쿼리의 종류
1.단일 행 서브쿼리
2.다중행 서브쿼리
3.다중열 서브쿼리
4.다중행 다중열 서브쿼리
5.상(호연)관 서브쿼리
6.스칼라 서브쿼리

1.2.5 상(호연)관 서브쿼리 ※많이 어려움
그룹 합수 시에는 exists 잘 안씀 상관 쿼리라고 무조건 exists 를 사용하는게 아니다.
메인쿼리의 값이 서브쿼리에 사용되고 있는 것
메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음 그 결과를 다시 메인 쿼리로 반환해서 수행하는 것
상호연관 관계를 가지고 실행하는 쿼리이다
*/
select * from employee where emp_id = '200';
--1.
select * from employee where exists(select 1 from dual);
--2.
 select * from employee where exists(select 1 from employee where emp_id = '2000');
-- 서브 쿼리가 false 면 결과값 안나옴 2번문제가 예시 
--select 실행 순서--
--from,      where,                 select
--              group by - Having
--                                          order by
-----------------------------------------------

--1.2.6 스칼라 서브쿼리
--결과 값이 1개인 상관서브쿼리 , select 문 뒤에 사용됨
-- sql 에서 단일값을 스칼라 값이라 함.

-- 스칼라 실습문제1
-- 사원명, 부서명, 부서의 평균임금(자신이 속한 부서의 평균임금)을 스칼라 서브쿼리를 이용해서
-- 출력하세요.

select dept_title , emp_name ,(select avg(salary) from employee where dept_code = e.dept_code) from employee e LEFT OUTER join department on dept_code = dept_id;

-- 스칼라 실습문제2
-- 모든 직원의 사번, 이름, 소속부서를 조회한 후 부서명을 오름차순으로 정렬하시오.
select * from employee;
select * from department;
select emp_name , emp_id , (select dept_title from department where dept_id = e.dept_code) from employee e order by 3 asc; 

-- 스칼라 실습문제3
-- 직급이 J1이 아닌 사원 중에서 자신의 부서 평균급여보다 적은 급여를 받는 사원출력하시오
-- 부서코드, 사원명, 급여, 부서의 급여평균을 출력하시오.
    select dept_code, emp_name , salary, floor((select avg(salary) from employee where dept_code = e.dept_code)) from employee e where job_code != 'J1' and salary < (select avg(salary) from employee where dept_code = e.dept_code);

    select avg(salary) from employee where dept_code = e.dept_code;

-- 스칼라 실습문제4
-- 자신이 속한 직급의 평균급여보다 많이 받는 직원의 이름, 직급, 급여를 출력하시오.
select emp_name,job_name , salary from employee e join job j on e.job_code = j.job_code where salary > (select avg(salary) from employee where job_code = e.job_code);

select avg(salary) from employee where dept_code = e.dept_code


--[전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.]
--서브 쿼리를 쓰지 않는 경우
select avg(salary) from employee; -- 3047663
select emp_id , emp_name , job_code , salary from employee 
where salary>3047663;
--서브 쿼리를 쓰는 경우
select emp_id , emp_name ,job_code ,salary from employee where salary>(select avg(salary) from employee);
-----------------------------------------------------------------------------------------------------------
-- 단일 행 서브쿼리 ex1
--전지연 직원의 관리자 이름을 출력하세요
select manager_id from employee where emp_name = '전지연';
select emp_name from employee where emp_id = '214';
select emp_name from employee where emp_id = (select manager_id from employee where emp_name = '전지연');
-----------------------------------------------------------------------------------------------------------
--다중 행 서브쿼리 ex1

--송종기나 박나라가 속한 부서에 속한 직원들의 전체 정보를 출력하세요
select * from department;
select * from employee;
select * from employee where dept_code IN(select dept_code from employee where emp_name IN ('박나라' , '송종기'));

-- 실습문제2
-- 차태연, 전지연 사원의 급여등급과 같은 사원의 직급명, 사원명을 출력하세요.
select * from job;
select * from employee where emp_name in ('차태연','전지연');
select job_name ,e.emp_name from employee e join job using (job_code) where sal_level in (select sal_level from employee where emp_name in ('차태연','전지연')); 
-- 실습문제3
-- Asia1지역에 근무하는 직원의 정보(부서코드, 사원명)를 출력하세요.
select * from location;
select * from department;
select * from employee;
select dept_code , emp_name from employee where dept_code in (select dept_id from department d join location L on d.location_id = L.local_code where local_name = UPPER('Asia1'));
select e.dept_code , e.emp_name from employee e join department d on e.dept_code = d.dept_id join location L on d.location_id = L.local_code where local_name = (select local_name from location where local_name =UPPER('ASIA1')) ;
--실습 문제 4
--직급이 J1,J2,J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는 직원의 부서코드 , 사원명,급여,(부서별 급여평균)을 출력하라
select dept_code ,emp_name , salary , salary from employee where job_code not in('J1','J2','J3') AND dept_code = 'D6' 
AND salary > (select avg(salary) from employee where dept_code ='D6'); 

select dept_code ,emp_name , salary , salary from employee where job_code not in('J1','J2','J3') AND dept_code = 'D5' 
AND salary > (select avg(salary) from employee where dept_code ='D5'); 

select dept_code ,emp_name , salary , salary from employee where job_code not in('J1','J2','J3') AND dept_code = 'D1' 
AND salary > (select avg(salary) from employee where dept_code ='D1'); 

select dept_code ,emp_name , salary , salary from employee where job_code not in('J1','J2','J3') AND dept_code = 'D8' 
AND salary > (select avg(salary) from employee where dept_code ='D8'); 

select avg(salary) from employee where dept_code ='D6';

--상관커리로 만들기
select dept_code ,emp_name , salary , floor((select avg(salary) from employee where dept_code =e.dept_code)) from employee e where job_code not in('J1','J2','J3')  
AND salary > (select avg(salary) from employee where dept_code =e.dept_code); 
------------------------------------------------------------------------------------------------------------------------------------
