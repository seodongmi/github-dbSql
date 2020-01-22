SELECT * 
FROM LPROD;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT * 
FROM CART;

SELECT mem_id, mem_pass, mem_name
FROM MEMBER;

--users 테이블 조회 
SELECT * 
FROM users;

--테이블에 어떤 컬럼이 있는지 확인하는 방법 
--1. SELECT *
--2. TOOL의 기능 (사용자-TABLE  클릭 후 컬럼확인)
--3. DESC 테이블명 (DESC-DESCRIBE)
DESC users;

--users 테이블에서 userid, usernm, rog_dt 컬럼만 조회하는 sql를 작성하세요
--날짜 연산 (reg_dt 칼럼은 date정보를 담을 수 있는 타입)
--SQL 날짜 컬럼 + (더하기 연산) 
--수학적인 사칙연산이 아닌 것들 
--String h = "hello";
--String w = "world";
--String hw = h+w; --자바에서는 두 문자열을 결합
--SQL에서 정의된 날짜 연산: 날짜 + 정수 = 날짜에서 정수를 일자로 취급하여 더한 날짜가 된다.
--ex(2019/01/28 + 5 = 2019/02/02)
--reg_dt: 등록일자 컬럼
--NULL: 값을 모르는 상태
--NULL에 대한 연산결과는 항상 NULL * 

--reg_dt -> reg_dt_AFTER_5DAY(별칭) 
--AS를 써도 안써도 상관x
SELECT userid, usernm, reg_dt + 5 reg_dt_AFTER_5DAY
FROM users;

SELECT userid, usernm, reg_dt + 5 AS reg_dt_AFTER_5DAY
FROM users;

SELECT userid, usernm, red_dt, reg_dt + 5 reg_dt_AFTER_5DAY
FROM users;

--SELECT 쿼리에서만 영향을 받음
DESC user;

SELECT PROD_ID AS ID, PROD_NAME AS NAME
FROM PROD;

SELECT LPROD_GU AS GU, LPROD_NM AS NM
FROM LPROD;

SELECT BUYER_ID AS 바이어아이디, BUYER_NAME AS 이름
FROM BUYER;

--문자열 결합
--자바에서의 문자열 결합: + ("hello" + "world") 
--SQL에서는: || ('Hello || 'world')
--SQL에서는: concat('Hello' ,'world')

DESC users;

-- userid와 usernm 컬럼을 결합: 별칭은 id_name
SELECT userid || usernm  AS id_name, 
       CONCAT(userid, usernm) AS concat_id_name
FROM users;

--변수, 상수
--int a = 5; String msg = "Hello, world";

--//변수를 이용한 출력
--System.out.println(msg);  

--//상수를 이용한 출력
--System.out.println("Hello World"); 

--SQL에서 변수는 없음 
--(컬럼이 비슷한 역할 pl/sql에는 변수 개념이 존재)
--SQL에서는 문자열 상수는 싱글 쿼테이션으로 표현 
--"Hello, world" --> 'Hello, world'

--문자열 상수와 컬럼간의 결합
--user id : brown
--user id : cony
SELECT 'user id: ' || userid AS "use rid"
FROM users;

--오라클에서 제공하는 기본 테이블
SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables;

--CONCAT(arg1, arg2)
SELECT CONCAT('SELECT * FROM ', CONCAT(table_name, ';')) AS QUERY
FROM user_tables;

--int a = 5; //자바에서는 할당, 대입
--if(a == 5) (a의 값이 5인지 비교) 
--sql에서는 대입의 개념이 없다(PL/SQL)
--sql = --> equal

--같은 값: =
--!=, <> 다른값
-->=크거나 같을 때

--user의 테이블의 모든 행에 대해서 조회
--users에는 5건의 데이터가 존재
SELECT * 
FROM users;

--WEERE 절: 테이블에서 데이터를 조회할 때 조건에 맞는 행만 조회 
--ex: userid컬럼의 값이 brown인 행만 조회 
--brown, 'brown' 구분
--컬럼, 문자열 상수 
SELECT * 
FROM users
WHERE userid = 'brown';

--ex: userid컬럼의 값이 brown이 아닌 행만 조회 
--같을 때: =, 다를 때: !=, <>
SELECT * 
FROM users
WHERE userid != 'brown';

--emp 테이블에 존재하는 컬럼을 확인해보세요 - 오라클 기본 제공 
--사원번호,이름,직업,상사번호,고용일,급여,인센티브, 부서번호
SELECT * 
FROM emp;

--emp테이블에서 ename 컬럼 값이 JONES인 행만 조회 
--*SQL 키워드는 대소문자를 가리지 않지만 
--컬럼의 값이나 문자열 상수는 대소문자를 가린다
--'JONES', 'Jones'는 값이 다른 상수 
SELECT * 
FROM emp
WHERE ename = 'JONES';

--유형도 같이 출력
DESC emp;

--emp 테이블에서 deptno(부서번호)가 30보다 크거나 같은 사원들만 조회
SELECT * 
FROM emp
WHERE deptno >= 30;

--문자열 : '문자열'
--숫자 : 50
--날짜: 함수와 문자열을 결합하여 표현. 문자열만 이용하여 표현가능(권장하지 않음)
--국가별로 날짜 표기방법 다름
--한국: 년도자리 4 자리 월자리 2 자리 일자 2 자리 
--미국: 월자리 2 자리 일자 2 자리 년도 4 자리
--입사일자가 1980년 12월 17일 직원만 조회 SELECT * 

-- TO_DATE: 문자열을 date타입으로 변경하는 함수 
-- TO_DATE(날짜형식 문자열, 첫번쨰 인자의 형식)
SELECT * 
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-- 범위연산
-- sal컬럼의 값이 1000에서 2000사이인 사람 
--sal >= 1000
--sal <- 2000

SELECT * 
FROM emp
WHERE sal >= 1000 AND sal <= 2000;

--범의연산자를 부등호 대신에 BETWEEN AND연산자로 대체 
SELECT * 
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--3개의 조건도 가능 
SELECT * 
FROM emp
WHERE sal >= 1000 AND sal <= 2000 AND deptno = 30;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/1/1', 'YYYY/MM/DD') AND TO_DATE('1983/1/1', 'YYYY/MM/DD');


