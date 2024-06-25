--DAY 8 PL/SQL 예외처리
-- 시스템 오류(메모리 초과, 인덱스 중복 키등) 는 오라클이 정의하는 에러로
--보통 PL/SQL 실행 엔진이 오류 조건을 탐지하여 발생시키는 예외임.

-- NO_DATA_FOUND
-- SELECT INTO 문장의 결과로 선택된 행이 하나도 없을 경우
-- DUP_VAL_ON_INDEX
-- UNIQUE 인덱스가 설정된 컬럼에 중복 데이터를 입력할 경우
-- CASE_NOT_FOUND
-- CASE문장에서 ELSE 구문도 없고 WHEN절에 명시된 조건을 만족하는 것이 없을 경우
-- ACCESS_INTO_NULL
-- 초기화되지 않은 오브젝트에 값을 할당하려고 할 때
-- COLLECTION_IS_NULL
-- 초기화되지 않은 중첩 테이블이나 VARRAY같은 컬렉션을 EXISTS외에 다른 메소드로 접근을 시도할 경우
-- CURSOR_ALREADY_OPEN
-- 이미 오픈된 커서를 다시 오픈하려고 시도하는 경우
-- INVALID_CURSOR
-- 허용되지 않은 커서에 접근할 경우 (OPEN되지 않은 커서를 닫으려고 할 경우)
-- INVALID_NUMBER
-- SQL문장에서 문자형 데이터를 숫자형으로 변환할 때 제대로 된 숫자로 변환되지 않을 경우
-- LOGIN_DENIED
-- 잘못된 사용자명이나 비밀번호로 접속을 시도할 때

-- ORACLE 인덱스 실습 
--1. 100만개의 데이터를 넣을 데이블 생성
--2.100만개의 데이터 삽입(PL/SQL 반복문)
--3. 인덱스 설정 전 테스트
--4. 인덱스 설정
--5. 인덱스 설정 후 테스트


--#1 
--아이디 , 비번 , 이름 ,전번 , 주소 , 등록일 , 수정일
--KH_CUSTOMER_TBL
CREATE TABLE KH_CUSTOMER_TBL(
USER_ID VARCHAR2(20),
USER_PWD VARCHAR2(30),
USER_NAME VARCHAR2(30),
USER_PHONE VARCHAR2(30),
USER_ADDRESS VARCHAR2(500),
REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
FIX_DATE TIMESTAMP DEFAULT SYSTIMESTAMP
);
CREATE SEQUENCE SEQ_CUSTOMER_USER_ID
MINVALUE 1
MAXVALUE 999999999
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_CUSTOMER_USER_ID;

--#2
DECLARE     
    V_USERID VARCHAR2(200);
BEGIN
    FOR N IN 10..1000000
    LOOP
    V_USERID := '1'||LPAD(SEQ_CUSTOMER_USER_ID.NEXTVAL , 9,0); 
    INSERT INTO KH_CUSTOMER_TBL VALUES (
    V_USERID , '0000' , N || '용자', ' 010-0000-0000','서울시 중구 남대문로 ' || N, DEFAULT , DEFAULT);
     END LOOP;
END;
/
--#3 인덱스 걸기전 시간 체크
EXPLAIN PLAN FOR
SELECT * FROM KH_CUSTOMER_TBL WHERE USER_NAME LIKE '22%용자';

SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);
--4112 , 00:00:50 TABLE ACCESS FULL

--#4
CREATE INDEX IDX_CUSTOMER_USERNAME ON KH_CUSTOMER_TBL(USER_NAME);

--#5 인덱스 건 후 실행시간
EXPLAIN PLAN FOR
SELECT * FROM KH_CUSTOMER_TBL WHERE USER_NAME LIKE '22%용자';


SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);
--1853 , 00:00:23 , 00:00:01