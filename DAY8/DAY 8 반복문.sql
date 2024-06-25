--DAY 8 PL/SQL 반복문
--1. LOOP
--2.WHILE LOOP
--3.FOR LOOP

--WHILE LOOP
-- 제어 조건이 TRUE 인 동안만 문장이 반복 실행 됨
-- LOOP를 실행할 때 조건이 처음부터 FALSE 면 한번도 수행되지 않을 수 있음
--EXIT 절이 없어도 조건절에 반복문 중지 조건을 기술할 수 있음.
--WHILE ( 조건식 )  LOOP 실행문 END LOOP;

--FOR LOOP
-- FOR LOOP 문에서 카운트용 변수는 자동선언됨 , 따로 선언할 필요가 없음
--카운트 값은 자동으로 1씩 증가함



DECLARE 
  N NUMBER:=1;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        EXIT WHEN N> 5;
    END LOOP;
    END;
    /
---LOOP EX---------------------------
-- @실습문제1
-- 1 ~ 10 사이의 난수를 5개 출력해보시오.
DECLARE 
N NUMBER :=1;
BEGIN 
    LOOP
        DBMS_OUTPUT.PUT_LINE(FLOOR(DBMS_RANDOM.VALUE(1,11))); -- 랜덤 함수
        N := N+1;
        EXIT WHEN N >5;
        END LOOP;
    END;
    /

DECLARE 
    N NUMBER := 1;
BEGIN 
    WHILE(N <=5)
    LOOP
      DBMS_OUTPUT.PUT_LINE(N);
      N := N+1;
    END LOOP;
    
END;
/
--------EX WHILE --------
-- @실습문제2
-- 사용자로부터 2~9사이의 수를 입력받아 구구단을 출력하시오.
DECLARE 
 N NUMBER :=2;
 DAN NUMBER;
 BEGIN 
    DAN := '&몇단';
    IF(DAN BETWEEN 2 AND 9) 
    THEN 
    WHILE (N <=9)
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN ||'*'|| N ||'= '||N*DAN);
        N:= N+1;
    END LOOP;
    ELSE DBMS_OUTPUT.PUT_LINE('2~9사이 입력하세요');
    END IF;
END;
/
-- @실습문제3
-- 1 ~ 30까지의 수 중에서 홀수만 출력하시오~
DECLARE 
     N NUMBER :=1;
    BEGIN 
    WHILE (N<30)
    
    LOOP 
    DBMS_OUTPUT.PUT_LINE(N);
    N:= N+2;
    END LOOP;
    END;
    /
--선생님 VER.
DECLARE 
 N NUMBER := 0;
 BEGIN
    WHILE (N<30)
    LOOP
        N:=N+1;
        CONTINUE WHEN MOD (N,2) = 0;
        DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
        END;
        /
------------------------------------------------------------------------------
BEGIN 
FOR D IN 1..100
LOOP
DBMS_OUTPUT.PUT_LINE(D);
END LOOP;
END;
/
----------FOR EX-------------
-- @실습문제4
-- EMPLOYEE 테이블의 사번이 200 ~ 210인 직원들의 사원번호, 사원명, 이메일을 출력하시오~!
DECLARE 
 EINFO EMPLOYEE%ROWTYPE;

BEGIN
    FOR D IN 200..210 
    
    LOOP
    SELECT * INTO EINFO FROM EMPLOYEE WHERE EMP_ID = D;
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || D);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EINFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EINFO.EMAIL);
    END LOOP;
    
END;
/
-- @실습문제5
-- KH_NUMBER_TBL은 숫자타입의 컬럼 NO와 날짜타입의 컬럼 INPUT_DATE를 가지고 있다.
-- KH_NUMBER_TBL 테이블에 0 ~ 99 사이의 난수를 10개 저장하시오. 날짜는 상관없음.
CREATE TABLE KH_NUMBER_TBL(
NO NUMBER,
INPUT_DATE DATE DEFAULT SYSDATE
);
DROP TABLE KH_NUMBER_TBL;

BEGIN
    FOR N IN 1..10
LOOP
    INSERT INTO KH_NUMBER_TBL
    VALUES(FLOOR(DBMS_RANDOM.VALUE(0,99)),DEFAULT);

    END LOOP;
    END;
    /
    SELECT *  FROM KH_NUMBER_TBL;
