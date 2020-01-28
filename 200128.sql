--ROWNUM: 행번호를 나타내는 컬럼
SELECT ROWNUM, empno,ename
FROM emp
WHERE (deptno = 10 OR deptno = 30) AND sal > 1500 
ORDER BY ename;

--별칭을 주는 것이 일반적 (rn)

--ROWNUM을 WHERE절에서도 사용가능 
--동작하는 것: ROWNUM = 1, ROWNUM <= 2 --> ROWNUM = 1, ROWNUM <= N
--동작하지 않는 것:  ROWNUM = 2, ROWNUM >= 2 -->ROWNUM = N(N은 1이 아닌 정수), ROWNUM >= N(N은 1이 아닌 정수)
--ROWNUM 이미 읽은 데이터에다가 순서를 부여 
-- **유의점1. 읽지 않은 상태의 값들(ROWNUM이 부여되지 않은 행)은 조회할 수 없다
-- **유의점2. ORDER BY절은 SELECT 절 이후에 실행 
--사용용도 : 페이징 처리(한페이지에 볼 수 있는 게시글의 갯수가 정해져있음 - 성능상 좋음)
--테이블에 있는 모든 행을 조회하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회한다
--페이징 처리 시 고려사항: 1페이징 건수, 정렬 기준 (촤근 작성시간)

--emp테이블의 총 row 건수 : 14건 
--페이징 당 5건의 데이터를 조회 
--1page = 1~5
--2page = 6~10
--3page = 11~15

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM = 1;

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM >= 2;

--보틍은 데이터를 입력한 순서대로 
--SELECT 후 ORDER BY 실행 
--순서를 보장하면서 정렬할 수 없을까?
SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;

--정렬된 결과에 ROWNUM을 부여하기 위해서는 IN LIKE VIEW를 사용한다
--요점정리 : 1. 정렬 2. ROWNUM 부여 
--IN LIKE VIEW = 일회성, 별칭부여 

--SELECT절에 *를 기술할 경우, 다른 EXPRESSION을 표기하기 위해서 
--테이블명.* 테이블 명칭.*으로 기술해야한다. 
SELECT ROWNUM, *
FROM emp;

--테이블명.* , 별칭 기술 
SELECT ROWNUM, e.*
FROM emp e;

--N이상을 넘어가는 것은 안됨  IN LIKE VIEW중첩사용 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn = 2;

-- ROWNUM > rn처리 가능 
--*page size : 5 , 정렬기준은 ename
--1page = rn 1~5
--2page = rn 6~10
--3page = rn 11~15
--페이징 처리 
--n page : rn (page-1)*pageSize + 1 ~ page * pageSize

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn >= 1 AND rn <= 5;

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN 6 AND 10;

--공식화 한 결과 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN (1-1)*5 AND 1*5;

--BEETWEEN도 1번 부터 읽었을 떄 가능 

--문제1) ROWNUM의 값이 1~10값만 조회하는 쿼리 작성 (정렬x)
--empno,ename, rn을 결과로 조회할 것 

-- 예외 (사용불가) 
SELECT ROWNUM rn, empno, ename 
FROM emp
WHERE rn BETWEEN 1 AND 10;

--답
SELECT ROWNUM rn, empno, ename 
FROM emp
WHERE ROWNUM<= 10;

SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename 
FROM emp)
WHERE rn<= 10;

--문제2
SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename 
FROM emp)
WHERE rn BETWEEN 11 AND 20;

--문제3
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename
    ) a )
WHERE rn BETWEEN 11 AND 14;
--테이블 이름이 없기 때문에 테이블에 따로 별칭을 두어야 함 
--한번 더 감싸야 SELECT ROWNUM rn 사용 가능 

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN 11  AND 14;

--일반화 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page * :pageSize;

--함수 
--단일행을 기준으로 작업, 여러행을 기준으로 작업하는 방법이 있음 
--character : 소문자, 대문자, 앞글자만 대문자 뒷글자 모두 소문자 
--trim: 문자열을 복사해서 리턴 (앞이나 뒤에 공백이 있으면 그것을 뺴서 리턴)
--REPLACE: 교체 (대상이 되는 문자열, 바꿀 문자열로 문자열을 뒤바꿔줌) 
--LPAD, RPAD: 왼쪽, 오른쪽에 문자열 삽입 
--INSTR: 문자열에 특정 문자 들어있는지 

--DUAL table : 데이터와 관계없이, 함수를 테스트 해볼 목적으로 사용
--컬럼 하나만 존재하며 값은 X 이며 데이터는 한 핸만 존재 

--문자열 대소문자 : LOWER, UPPER, SELECT * SELECT * 
SELECT   LOWER('Hello, World!'), UPPER('Hello, World!'), INITCAP('Hello, World!')  
FROM dual;
--FROM emp 를 한다면? 결과가 emp테이블의 행 수 만큼 나온다 
SELECT   LOWER(ename), UPPER(ename), INITCAP(ename)  
FROM emp;

--함수는 Where절에도 사용 가능 
--사원이름이 SMITH인 사원만 조회 
SELECT * 
FROM emp
WHERE ename = :ename;
--소문자 사용X 

SELECT * 
FROM emp
WHERE ename =  LOWER(:ename);

--SQL작성 시 아래 형태는 지양해야 한다. 
--좌변을 가공하지 말라 -> 인덱스를 사용하지 못하기 때문에  
--table의 컬럼을 가공하지 않는 형태로 SQL를 작성한다. 
--잘못된 SQL문 
SELECT * 
FROM emp
WHERE LOWER(ename) = :ename;

--문자열 결합 
SELECT CONCAT('Hello', 'world')
FROM dual;

--자바: 0,5 0-4번까지 가져오기 
--SQL: 1,5 1-5번까지 가져오기 
SELECT CONCAT('Hello', ', world') CONCAT,
       SUBSTR('Hello, World', 1, 5) sub, 
       LENGTH('Hello, World')len,
       INSTR('Hello, World', 'o') ins,
--6번쨰부터 검색 
       INSTR('Hello, World', 'o', 6) ins2,
--15글자를 앞쪽에 *을 넣어 채워라 
       LPAD('Hello, World', 15, '*') LP, 
       RPAD('Hello, World', 15, '*') RP,
       REPLACE('Hello, World', 'H', 'T') REP,
--문자열을 복사해서 리턴 (앞이나 뒤에 공백이 있으면 그것을 뺴서 리턴)
       TRIM(' Hello, World '), --공백을 제거 
--d라고 하는 문자열을 'Hello, World'로부터 제거 하겠다. 
       TRIM('d' FROM 'Hello, World') TR
FROM dual;


SELECT  LENGTH('TEST')
FROM dual;

--숫자함수
--ROUND : 반올림 (10.6을 소수점 첫번째 자리에서 반올림 -> 11)
--TRUNC: 절삭(버림) (10.6을 소수점 첫번째 자리에서 절삭 -> 10)
--ROUND, TRUNC : 몇번째 자리에서 반올림/절삭
--MOD : 나머지 (몫이 아니라 나누기 연산을 한 나머지 값) (13/5 -> 몫:2 나머지:3)

--ROUND(대상 숫자, 최종 결과 자리)
SELECT ROUND(105.54, 1), --반올림 결과가 소수 첫째 자리까지 나오도록 --> 두번째 자리에서 반올림을 한다
ROUND(105.55, 1),
ROUND(105.55, 0), --반올림 결과가 정수부만 --> 소수점 첫번째자리에서 반올림 
ROUND(105.55, -1), --반올림 결과가 십의 자리까지 -> 일의 자리에서 반올림 
ROUND(105.55) --두번째 인자의 기본값은 0이 적용 
FROM dual;

SELECT TRUNC(105.54, 1), --절삭의 결과가 소수점 첫번쨰 자리까지 나오도록 -> 두번째 자리에서 절삭
     TRUNC(105.55, 1), --절삭하는 것이기 떄문에 위에 결과와 동일 
     TRUNC(105.55, 0), --절삭의 결과가 정수부(일의 자리)까지 나오도록 -> 소수점 첫번째 자리에서 절삭 
     TRUNC(105.55, -1), --절삭의 결과가 10의 자리까지 나오도록 --> 일의 자리에서 절삭
     TRUNC(105.55) --두번째 인자의 기본값은 0이 적용 
FROM dual;

--emp테이블에서 사원의 급여(sal)를 1000으로 나눴을 때 몫을 구해보기 
SELECT ename, sal, TRUNC(sal/1000) mok
FROM emp;

--나머지 구하기
SELECT ename, sal, TRUNC(sal/1000) mok,
        MOD(sal,1000) --mod의 결과는 divisor보다 항상 작다 0~999까지 
FROM emp;

DESC emp;

--기본: 년도 2자리/월2자리/일자2자리
SELECT ename, hiredate
FROM emp;

--DATA는 툴에 의존적 (틀로 날짜가 어떻게 보이는지 따로 설정 가능)
--도구 -> 환경설정 -> 데이터 베이스 -> NLS

--SYSDATE : 현재 오라클 서버의 시분초가 포함된 날짜 정보를 리턴해주는 특수 함수 
--함수 명으로만으로 실행가능 

--DATE + 정수 = 일자연산 
-- 2020/01/28 + 5 (일자를 기준으로 변화)
-- 1 = 하루 
-- 1시간 = 1/24
--숫자 표기: 숫자
--문자 표기: 싱글 쿼테이션 + 문자열 + 싱글 쿼테이션 ==> '문자열'
--날짜 표기 : TO_DATE('문자열로 된 날짜값', '문자열로 된 날짜 값의 표기 형식)
--         ->TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE + 5
FROM dual;

SELECT SYSDATE + 5, SYSDATE + 1/24
FROM dual;

-- 숙제) Function (data 실습 fn1)





