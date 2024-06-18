--Day 4
-- Review
--1. 단일행 함수 : 결과값 여러개
--2. 다중행 함수 : 결과값 1개

--단일행 ex
select floor (sysdate- hire_date) from employee;
--------------------------------------------------
--1.1 단일행 함수 종류

--1.1.1 숫자 처리 함수
-- ABS,MOD,TRUNC , FLOOR , ROUND ,CEIL

--1.1.2 문자 처리 함수 
-- A.LENGTH , LENGTHB: 길이 구함
-- B.INSTR , INSTRB : 위치 구함
-- C. LPAD , RPAD : 빈 곳을 채워줌 
-- D. LTRIM, RTRIM : 특정 문자 제거( 주로 공백 제거 )
-- E. TRIM : 공백 제거
-- F. SUBSTR : 문자열 잘라줌
-- G. CONCAT : 문자열 합쳐줌
-- H. REPLACE : 문자열 바꿔줌
-- 사용 법은 함수명(value1 , value2 ...) 적고 값에는 리터널이나 컬럼명 들어감.
--1.1.3 날짜 처리 함수
-- ADD_MONTHS() , MONTHS_BETWEEN() , LAST_DAY() , EXTRACT , SYSDATE
--1.1.4 형변환 함수
-- a. TO.CHAR()
-- b. TO_DATE()
-- c. TO_NUMBER() 자동 형변환 됨.
/* =================== TO_CHAR 형식 문자(숫자) ========================
Format		 예시			설명
,(comma)    9,999		콤마 형식으로 변환
.(period)	99.99		소수점 형식으로 변환
9           99999       해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		    09999		해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		    $9999		$ 통화로 표시
L		    L9999		Local 통화로 표시(한국의 경우 \)
XXXX		XXXX		16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/
/*  =================== TO_DATE 형식 문자(날짜) =======================
YYYY	    년도표현(4자리)
YY	        년도 표현 (2자리)
RR          년도 표현 (2자리), 50이상 1900, 50미만 2000
MONTH       월을 LOCALE설정에 맞게 출력(FULL)
MM	        월을숫자로표현  
MON	        월을 알파벳으로 표현(월요일아님)
DDD         365일 형태로 표현
DD	        31일 형태로 표현	
D           요일을 숫자로 표현(1:일요일...) 
DAY	        요일 표현	  
DY	        요일을 약어로 표현	

HH HH12     시각
HH          시각(24시간)
MI
SS
AM PM A.M. P.M. 오전오후표기
FM          월, 일, 시,분, 초앞의 0을 제거함.
*/
--1.1.5 기타 함수
/* a.NVL : NULL 처리 하는 함수
    b. decode(IF문)
    c.case(Switch문)
 */
 --nvl
 select NVL(bonus , 0 )* salary from employee;
 
 --decode
 --사용법: decode (값 , 조건값 , 참일때 값 , 조건 값 ,참일 때 값, 모두 아닐 때 값)
--  ex) decode(변하는 값 , 1 , '빨강 , 2 '노랑,'파랑);
select decode(substr(emp_no ,8,1),'1','남','2','여','3','남','4','여','무') from employee;

--case 
--case when 변하는 값 = 조건값 then 참일 떄 값 else 모두 아닐 때 값 end
--ex 
--case when 변하는 값 = 1 then ' 빨강' when 변하는 값 = 2 then ' 노랑' else ' 파랑' END
select case when substr(emp_no ,8,1)='1' then 
'남' when substr(emp_no, 8,1) = '2' then '여' else '무' end 성별 from employee;
--2.1 다중행 함수(그룹 함수)
--2.1.1 SUM : 합
--2.1.2 AVG : 평균
--2.1.3 COUNT : 개수
select sum(salary) from employee;
select avg(salary) from employee;
select count(*) from employee;
--2.1.4 MAX/MIN
select Max(salary) from employee;
select Min(salary) from employee;
--group by
select dept_code ,sum(salary) from employee group by dept_code order by dept_code asc;

--Rollup & cube ----
select dept_code , job_code ,sum(salary) from employee group by Rollup (dept_code , job_code) order by 1 asc; 
select dept_code , job_code ,sum(salary) from employee group by cube (dept_code , job_code) order by 1 asc; 

-------------------------------------------------------------------------------
 select decode(
--EMPLOYEE에서 입시일이 00/01/01 ~10/01/01 사이의 직원 정보 출력
select * from employee where hire_date between to_date ('00/01/01') and to_date ('10/01/01');

select 500+ 300  from dual;
select '500' + 300 from dual; -- 자동 형 변환
--자동 형 변환 안되는 경우
select '1,000,000'- '500,000' from dual;
-- -> 
select To_number('1,000,000','9,999,999') - to_number('500,000','999,999') from dual;

select emp_name, dept_code , substr(emp_no ,1,2)||'년'||substr(emp_no ,3,2)||'월'||substr(emp_no,5,2)||'일' ,extract (year from sysdate) - ('19'|| substr(emp_no,1,2))  from employee;
-- ->
select to_char(hire_date,'YYYY"년"MM"월"DD"일"') from employee;




/* EX
    오늘부로 일용자씨가 군대에 끌려갑니다.
    군복무 기간이 1년 6개월을 한다라고 가정하면
    첫번째, 제대일자는 언제인지 구하고
    두번째, 제대일짜까지 먹어야 할 짬밤의 그릇수를 구해주세요!!
    (단, 1일 3끼를 먹는다고 한다.)
*/

select sysdate 오늘, ADD_MONTHS(sysdate,18) 제대 ,
 (ADD_MONTHS(sysdate,18) - sysdate)*3 짬밥수 from dual; -- 오늘 날짜
-----------------------------------------------------------------------
-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex)  홍길동 , hong@kh.or.kr   	  13
--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0
----------------------------------------------------------------------------------------
--ex1
select emp_name 이름, email 이메일, length(email) 이메일길이 from employee;

--ex2
select emp_name 이름 , RTRIM(email ,'@kh.or.kr') from employee;
--선생님 ver. 
select emp_name ,substr(email,1, instr(email,'@')-1) ,instr(email,'@') from employee; 
--ex3
--선생님 ver.
select emp_name 이름 ,  '19'||substr(emp_no,1,2) 년생 , NVL(bonus,0) 보너스값 from employee where substr(emp_no ,1,2) between 60 and 69;

select emp_name 이름 ,  '19'||substr(emp_no,1,2) 년생 , NVL(bonus,0) 보너스값 from employee where emp_no like '6%';
-------------------------------------------------------------------------------------------
--4. '010' 핸드폰 번호를 쓰지 않는 사람의 전체 정보를 출력하시오.
--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력 하시오
--	ex) 홍길동 771120-1******
----------------------------------------------------------------------------------
select * from employee where phone not like '010%';

select emp_name , extract(YEAR from hire_date) ||'년' || extract(month from hire_date)||'월' 입사년월 from employee; 

select emp_name , substr(emp_no ,1, 8)|| '*******' from employee;
select emp_name , Rpad(substr(emp_no ,1, 8),14 , '*') from employee;
---------------------------------------------------------------------------------
--7. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일
--8. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
--9. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함

--10. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
------------------------------------------------------------------------------------
--ex7
select emp_id , emp_name , dept_code , hire_date from employee where (dept_Code = 'D5' or dept_code = 'D9') ANd extract (year from hire_date) = '2004';
--ex8
select emp_name , hire_date , floor(months_between(sysdate , hire_date)*30) from employee;
--ex9
select emp_name, dept_code , substr(emp_no ,1,2)||'년'||substr(emp_no ,3,2)||'월'||substr(emp_no,5,2)||'일' ,extract (year from sysdate) - ('19'|| substr(emp_no,1,2))  from employee;
--ex10
select emp_name , dept_code , '￦'||salary*12 from employee;
--ex11
select emp_name , dept_code from employee;

--------------------------------------------------------------------------------
-- group by ex ---------------------------------------------------------------------

--employee 테이블에서 부서코드 , 그룹별 급여 합계 , 평균 (정수) 인원수를 조회하고 부서코드 순으로 정렬
select sum(salary) , floor(avg(salary)), count(salary) from employee group by dept_code;

--employee 에서 부서코드 , 보너스를 지급받는 사원수 조회 하고 부서코드 순으로 정렬
select dept_code , count(bonus) from employee where bonus is not null group by dept_code order by dept_code asc;
--bonus 컬럼의 값이 존재한다면 그 행을 1로 카운팅 보너스를 지급받은 사원이 없는 부서도 있음을 확인

-- EMPLOYEE 테이블에서 직급이 J1인 사람들을 제외하고 직급별 사원수 및 평균급여를 출력하세요.
select count(job_code) , floor(avg(salary)) from employee where job_code != 'J1';

-- 실습4
-- EMPLOYEE 테이블에서 직급이 J1인 사람들을 제외하고 입사년도별 인원수를 조회해서,
-- 입사년도 기준으로 오름차순으로 정렬하세요.
select extract(year from hire_date)||'년:'||count(extract(year from hire_date))||'명' from employee where job_code != 'J1' group by extract(year from hire_date) order by 1 asc;
select to_char(hire_date,'YYYY'),count(*) from employee where job_code != 'J1' group by to_char(hire_date , 'YYYY') order by 1 asc;

-- 실습5
-- EMPLOYEE 테이블에서 EMP_NO의 8번째 자리가 1, 3이면 '남', 2, 4이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬하시오.,'남',2,'여',3,'남','4','여')
select decode(substr(emp_no, 8,1) ,'1','남','2','여','3','남','4','여','무'), sum(salary) , floor(avg(salary)), count(salary) from employee group by decode(substr(emp_no, 8,1) ,'1','남','2','여','3','남','4','여','무');

--실습6
-- 부서 내 직급별 급여의 합계를 구하시오
select sum(salary) ,dept_code , job_code from employee group by dept_code , job_code order by 1 asc;

--실습7
--부서 내 성별 인원수를 구하시오
select decode(substr(emp_no, 8,1) ,'1','남','2','여','3','남','4','여','무') ,count(salary), dept_code from employee group by dept_code ,decode(substr(emp_no, 8,1) ,'1','남','2','여','3','남','4','여','무') order by 1 asc;
----------------------------------------------------------------------------------

--  select 문에선 조건을 걸 떄 where 을 쓰지만 Group by한 결과값에 조건을 걸땐 Having 을 쓴다
select sum(salary) ,dept_code , job_code from employee group by dept_code , job_code Having sum(salary)>= 5000000 order by 1 asc;

-- Having ex---------------------------------------------------------------------------------------
--부서별 인원수가 5명 미만 / 초과 인 레코드를 출력하라
select dept_code , count(*) from employee group by dept_code Having count(*)>5 or count(*) < 5;

-- 실습문제1
--부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요.
select dept_code , count(*) from employee group by dept_code Having count(*)>5;

-- 실습문제2
--부서내 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.
select dept_code , job_code , count(*) from employee group by dept_code , job_code Having count(*) >=3;

--실습문제 3 
--매니저가 관리하는 사원이 2명이상인 매니저 아이디와 관리하는 사원수를 출력하세요
select count(*), manager_id from employee group by manager_id Having count(*) >=2;

----------------------------------------------------------------------------------------------




