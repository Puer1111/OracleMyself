--Select 
-- 원하는 column  or row 기입 후 검색
--row시 where 사용.
--데이터 조회 결과를 Result set 이라 한다.
--Result set 은 0개 이상 행 포함 가능.
--order by 시 조건에 따른 정렬 가능.
desc employee;
select emp_id,emp_name , emp_no from employee
order by emp_id asc;
--ex-----
--1.EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함),
    --   실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오.
--2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오.
  --  (SYSDATE를 사용하면 현재 시간 출력)
--3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율 출력하시오
----------------------------------------------------------
--ex1--
select emp_name AS 이름 ,salary*12+salary*NVL(Bonus,0) 총수령액 ,salary*12+salary*NVL(Bonus,0)-(salary*0.03) 실수령액 from employee;
--NVL : null 일 0으로 나오게 하는 함수
--ex2--
select emp_name 이름, round (sysdate - hire_date) 입사일 from employee;
--ex3--
select emp_name 이름, salary 월급 ,nvL(bonus,0) 보너스율 from employee where round (sysdate-hire_date) >= 365*20;

--------------------ex-----------------------
--1.EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
--2.EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오
--3.EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고 고용일이 90/01/01 ~ 00/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
-------------------------------------------------------------------
--ex1
 select emp_name AS 이름 from employee where emp_name like '%연'; 
 --ex2
 select emp_name , phone from employee where phone NOT LIKE '010%';
 --ex3
 select * from employee where EMAIL LIKE '%s%' AND (DEPT_Code in ('D9','D6')) AND (hire_date between '90/01/01' AND '01/12/01') AND salary >=2700000;
 
 ----------------------------ex---------------------------------
-- 최종 실습 문제

-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)

 -- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
--------------------------------------------------------------------
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
select emp_name 이름 , emp_no 주민번호 , salary 급여 , hire_date 입사일 from employee where round(sysdate-hire_date)>= 1825 and round(sysdate-hire_date)<=3650;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)
select emp_name 이름 , dept_code 부서코드 , hire_date 고용일 ,(ENT_DATE - HIRE_DATE) 근무기간 , ENT_DATE 퇴사일
from employee where ENT_YN = 'Y';

 -- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
--ex3 
select emp_name 이름 , salary * 1.5 급여, floor((sysdate-hire_date)/365) 근속년수 from employee where floor((sysdate-hire_date)/365) >= 10 order by floor((sysdate-hire_date)/365) asc;

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
select emp_name 이름, emp_no 주민번호, Email 이메일, phone 폰번호 , salary 급여 from employee where (hire_date between '99/01/01' and '10/01/01') and salary <= 2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
select emp_name "이름" ,EMP_NO "주민번호" , salary "급여",NVL(dept_code,'없음')"부서코드" from employee where (salary between 2000000 and 3000000) AND EMP_NO like '__04__-2%' order by EMP_NO DESC;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
select emp_name 이름 ,FLOOR(FLOOR((sysdate-hire_date)* 0.001))*salary * 0.1 특별보너스 from employee where bonus is null and emp_no like '______-1%' order by emp_name asc;

select emp_name , manager_ID ,dept_code from employee where manager_id is null and dept_code is null;

select * from employee where EMAIL LIKE '_ _ _ _ _@%';

select * from employee where email like'___\_%@%' escape '\';