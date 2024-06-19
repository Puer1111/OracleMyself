--Day4 Oracle join
-- 1. join
-- 두개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 따로 분류하여 새로운 가상의 테이블을 만든다
-- -> 여러 테이블의 레코드를 조합하여 하나의 레코드로 만듬

---2. join 의 종류
/*
1. INNER JOIN: 교집함 , 일반적으로 사용하는 join
2. OUTER JOIN: 합집합 , 모두 출력하는 join

ex) 사원명 , 부서명 출력
select emp_name dept_title from employee join department on dept_code = dept_id; -21개
select count(*) from employee -23개
차이가 나는 이유는 dept_code 가 null 이면 빠진다
--> INNER JOIN

--LEFT OUTER JOIN 은 왼쪽 테이블이 가지고 있는 모든 데이터를 출력*/
select emp_name , dept_title
from employee 
LEFT OUTER join  department on dept_code = dept_id; -- 23개로 employee 다 출력

--RIGHT OUTER JOIN 은 오른쪽 테이블이 가지고 있는 모든 데이터를 출력*/
select emp_name , dept_title
from employee 
RIGHT OUTER join  department on dept_code = dept_id; -- 24개로 department 다 출력

--FULL OUTER JOIN 은 양쪽 테이블이 가지고 있는 모든 데이터 출력
select emp_name , dept_title
from employee 
FULL OUTER join  department on dept_code = dept_id;
--Oracle 전용 구문 join--
select emp_name , dept_title
from employee , department where dept_code = dept_id;
--Oracle , Left OUTER join --
select emp_name , dept_title
from employee , department where dept_code = dept_id(+);
--Oracle RIGHT OUTER JOIN--
select emp_name , dept_title
from employee , department where dept_code(+) = dept_id;
--Oracle , FULL OUTER JOIN--
--존재하지 않음.
---------ANSI 표준 구문-------------------
select emp_id , emp_name , dept_code dept_id , dept_title from employee
join department on dept_code = dept_id;

select emp_id , emp_name , employee.job_code ,job.job_code , job.job_name from employee
join job on employee.job_code = job.job_code; -- job code 이름이 같아서 명시 해야함
-----------------------------------
--------------- oracle 구문----------------
select emp_id , emp_name , employee.job_code , job.job_code job_name from employee, job
where employee.job_code = job.job_code;
---------------------------------------------
-----------------테이블에 별칭 부여----------------
select emp_id , emp_name , e.job_code , j.job_name from employee e
join job j on e.job_code = j.job_code;
-------------join 하는 컬럼명이 같을 때--------------
select emp_id , emp_name , job_code , job_name from employee e
join job j using (job_code);
---------------------------------------------------
-- join ex --------------
--부서명과 지역명을 출력하시오
select * from department;
select * from Location;

select dept_title,  L.local_name from department d join Location L on d.Location_id = L.Local_code; 

--사원명과 직급명을 출력하세요
select * from employee;
select * from job;

select  e.emp_name , j.job_name from employee e join job j using (job_code);
--지역명과 국가명을 출력하세요

select * from location;
select * from national;
select L.local_name ,  n.national_name from location  L join national n using(national_code);

-- @JOIN 종합실습
--1. 주민번호가 1970년대 생이면서 성별이 여자이고, 
-- 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
select * from employee;
select * from department;
select * from job;
select e.emp_name, j.job_name , emp_no , d.dept_title from employee e join job j 
using(job_code) join department d on  e.dept_code = d.dept_id where emp_no like '7%' AND emp_name like '전%';

--2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
select e.emp_id , e.emp_name,d.dept_title from employee e join department d on e.dept_code = d.dept_id where emp_name like '%형%'; 

--3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
select e.emp_name , j.job_name , e.dept_code , d.dept_title from employee e join job j using(job_code) join department d on e.dept_code = d.dept_id where d.dept_title like '해외영업%'; 

--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
--Table 순서 확인
select e.emp_name , e.bonus , d.dept_title , L.local_name from employee e join department d on d.dept_id = e.dept_code join location L on local_code = location_id where e.bonus is not null;

--5. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
select e.emp_name , j.job_name , d.dept_title , L.local_name from employee e join job j using(job_code) join department d on d.dept_id = e.dept_code join location L on local_code = location_id where e.dept_code like 'D2%';

--6. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
-- 데이터 없음!
select * from employee;
select * from sal_grade;
select e.emp_name , j.job_name , e.salary ,(e.salary*12+e.salary*nvl(bonus,0)) from employee e join sal_grade s using (SAL_LEVEL) join job j using (job_code) where s.MAX_sal< e.salary;

--7. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
select * from national;
select * from location;
select * from employee;
select * from department;

select e.emp_name , d.dept_title , l.local_name , n.national_name from employee e join department d on e.dept_code = d.dept_id 
join location l on d.location_id = l.local_code join national n on l.national_code = n.national_code
where n.national_code in('KO','JP');
--where (n.national_code like 'KO%' OR n.national_code like 'JP%'); 
--8. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 
--단, join과 IN 사용할 것
select * from employee;
select * from job;

select e.emp_name , job_code, j.job_name , e.salary from employee e join job j using (job_code) where e.bonus is null and j.job_name in('차장','사원');
-----------------------------------------------------------