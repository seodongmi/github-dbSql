--Function (data 실습 fn1)
SELECT TO_DATE('2019/12/31', 'YY-MM-DD') LASTDAY,
TO_DATE('2019/12/31', 'YY-MM-DD') - 5 LASTDAYBEFORE5,
SYSDATE NOW,
SYSDATE - 3 NOW_BEFORE3
FROM dual;


--DATE : TO_DATE 문자열 -> 날짜(DATE)
--       TO_CHAR 날짜 -> 문자열 (날짜 포맷 지정)
--JAVA에서는 날짜 포맷의 대소문자를 가린다( MM / mm -> 월 , 분)

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS')
FROM dual;

--주간일자(1~7) D : 일요일 1 ,월요일 2 ... 토요일 7
--주차 IW : ISO표준  - 해당 주의 목요일의 기준으로 주차를 산정 
-- 2019/12/31 (화요일) --> 2020/01/02 (목요일) -> 그렇기 때문에 1주차로 선정 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
    TO_CHAR(SYSDATE,'D'),
    TO_CHAR(SYSDATE,'IW'),
    TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'), 'IW')
FROM dual;

--emp 테이블의 hiredate(입사일지)컬럼의 년월일 시:분:초 
SELECT ename, hiredate,
TO_CHAR(hiredate, 'YYYY-MM/DD HH24:MI:SS'),--시분초 데이터가 왜 안나오는지? 시분초 정보를 넣지 않았기떄문 
TO_CHAR(hiredate + 1, 'YYYY-MM/DD HH24:MI:SS'), 
TO_CHAR(hiredate + 1/24, 'YYYY-MM/DD HH24:MI:SS'),
--hiredate에 30분을 더하여 TO_CHAR로 표현 
TO_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM/DD HH24:MI:SS')  
FROM emp;

--Function (data 실습 fn2)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME ,
TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--날짜 조작
-- ROUND(DATE, format)
-- TRUNC(DATE, format)

--MONTHS_BETWEEN(DATE,DATE)
--인자로 들어온 두 날짜 사이의 개월 수를 리턴 
SELECT ename, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate), --입사한지 몇개월이 지났는지(순서중요)
       MONTHS_BETWEEN(TO_DATE('2020-01-17', 'yyyy-mm-dd'), hiredate), 469/12 --39년이 지남 
FROM emp
WHERE ename='SMITH';

--ADD MONTHS(DATE, 정수-가감할 개월 수)
SELECT ADD_MONTHS(SYSDATE, 5),  --  2020/01/29 --> 2020/06/29
        ADD_MONTHS(SYSDATE, -5) --  2020/01/29 --> 2019/08/29
FROM dual;

--NEXT_DAY(DATE, 주간일자), ex) NEXT_DAY(SYSDATE , 5) --> SYSDATE이후 처음 등장하는 주간날자 5(목)에 해당하는 일자
--                              SYSDATE 2020/01/29(수) 이후 처음 등장하는 5(목)요일 -> 2020/01/30 (목)
                               
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

--LAST DATNEXT(DAY) DATE가 속한 월의 마자막 일자를 리턴 
SELECT LAST_DAY(SYSDATE) --SYSDATE 2020/01/29 --> SYSDATE 2020/01/31
FROM dual;

--LAST_DAY를 통해 인자로 들어온 date가 속한 월의 마지막 일자를 구할 수 있는데
--date의 첫번째 일자는 어떻게 구할까?
SELECT SYSDATE, 
LAST_DAY(SYSDATE),
TO_DATE('01','DD'),
ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),
TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM dual;

--hiredate값을 이용하여 해당 월의 첫번째 일자로 표현 
SELECT ename, hiredate,
ADD_MONTHS(LAST_DAY(hiredate)+1,-1),
TO_DATE(TO_CHAR(hiredate, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM emp;

--명시적 형변환 
--묵시적 형변환 

--empno는 number타입, 인자는 문자열
--타입이 맞지 않기때문에 묵시적 형변환이 일어난다
--테이블 컬럼의 타입에 맞게 올바른 인자 값을 주는 것이 중요 
SELECT * 
FROM emp
WHERE empno='7369';

-수정
SELECT * 
FROM emp
WHERE empno=7369;

--hiredate의 경우 data타입, 인자는 문자열로 주어졌기때문에 묵시적 형변환이 발생
--날짜 문자열보다 날짜 타입으로 명시적으로 기술하는 것이 좋음
SELECT * 
FROM emp
WHERE hiredate = '1980/12/17';
--80/12/17 왜 안되나요? 설정을 YYYY/MM/DD로 바꿨기때문 

--수정
SELECT * 
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

--실행계획
--단계1
EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE empno='7369';

--단계2
SELECT * 
FROM table(dbms_xplan.display);

--Id  | Operation         | Name  -->  중요
--위에서 아래서 읽는 것 
--들어쓰기가 되어있으면 자식이라는 뜻 자식부터 읽음 
--emp라고 하는 테이블의 데이터를 다 읽는다
--1 - filter("EMPNO"=7369) --> filter로 거름
-- 자동적으로 형변환 

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE TO_CHAR(empno)='7369';

SELECT * 
FROM table(dbms_xplan.display);
-- 1 - filter(TO_CHAR("EMPNO")='7369') 

--숫자를 문자열로 변경하는 경우 : 포맷
--천단위 구분자
--1000이라는 숫자를 
--한국: 1,000.50
--독일 : 1.000,50

--emp테이블에 있는 sal컬럼(Number타입)을 포맷팅
--9 : 숫자
--0 : 강제 자리 맞춤(0으로 표기)
--L : 통화단위
SELECT ename, sal, TO_CHAR(sal, 'L0,999')
FROM emp;

--국제화 

--널 함수 

--NULL에 대한 연산의 결과는 항상 NULL
--emp 테이블의 sal컬럼에는 null테이터가 존재하지 않음 (14건의 데이터에 대해)
---emp 테이블의 comm컬럼에는 null테이터가 존재하지 않음 (14건의 데이터에 대해)
--sal + comm -> comm인 null인 행에 대해서는 결과 null로 나온다 
SELECT ename, sal, comm, sal+comm
FROM emp;

--요구사항이 comm이 null이면 sal컬럼의 값만 조회 
--요구사항이 충족 시키지 못한다 -> SW에서는 결함 

--NVL(타켓, 대체값)
--타겟의 값이 NULL이면 대체값을 반환하고 
--타겟의 값이 NULL이 아니면 타겟 값을 반환 
--if(타겟 == null)
--retrun 대체값;
--else
--   return 타겟;

SELECT ename, sal, comm, NVL(comm, 0), 
sal+NVL(comm,0),
NVL(sal+comm, 0)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(ecpr1 != null)
--return expr2
--else
--return expr3

SELECT ename, sal, comm, NVL2(comm, 10000, 0 ), --널이 아니면 10000부여  
sal+NVL(comm,0),
NVL(sal+comm, 0)
FROM emp;

--NULLIF(expr1, expr2)
--if(expr1 == expr2)
--return null;
--else
--return expr1;

SELECT ename, sal, comm, NULLIF(sal, 1250) --sal가 1250인 사람은 null을 리턴, 1250이 아닌 사람은 sal을 리턴
FROM emp;

--가변인자 
--COALESCE(expr1, expr2...) 인자 중에 가장 처음으로 등장하는 
--NULL이 아닌 인자를 반환
--if(expr1 != null)
--return expr1;
--else
--return COALESCE(expr2, expr3...);

--COALESCE(comm, sal) : comm이 null이 아니면 comm
--                      comm이 null이면 sal (단, sal컬럼 값이 NULL이 아닐 때)


SELECT ename,sal,comm, 
    COALESCE(comm, sal) coalesce_comm_sal 
FROM emp; 


--fn4
SELECT EMPNO, ENAME, MGR, 
NVL(mgr, 9999) mgr_n,
NVL2(mgr, mgr, 9999), 
coalesce(mgr, 9999) 
FROM emp;

--fn5
SELECT USERID, USERNM, REG_DT, NVL(REG_DT,SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

--CONDITION: 조건절 
--CASE : JAVA의 if-else if-else
--CASE 
-- WHEN 조건 THEN 리턴값1
-- WHEN 조건2 THEN 리턴값2
-- ELSE 기본값
-- END

--emp 테이블에서 kob컬럼 값이 SALESMAL SAL*1.05리턴 
--                          MANAGER이면  SAL * 1.1리턴
--                          KING이면 SAL * 1.2리턴
--                          그 밖의 사람들은 SAL을 리턴 

SELECT ename, job, sal
       ,CASE
          WHEN job = 'SALESMAN' THEN sal * 1.05
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
        END BONUS
FROM emp;

--DECODE함수 :CASE절과 유사 
--(다른점 CASE절은 WHEN절에 조건비교가 자유로운데 
--        DECODE 함수는 하나의 값에 대해서 = 비교만 허용
-- DECODE함수: 가변인자(인자의 개수가 상황에 따라서 늘어날 수가 있음)
-- DECODE(col | expr, 첫번째 인자와 비교할 값1, 두번째 인자가 같을 경우 반환 할 값, 
--                    첫번째 인자와 비교할 값2, 첫번째 인자와 네번째 인자가 같을 경우 반환 할 값...,
--                    option - else 최종적으로 반환할 기본값)

SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) BONUS
FROM emp;


--emp 테이블에서 kob컬럼 값이 SALESMAN이면서 sal가 1400보다 크면 SAL*1.05리턴 
--                         SALESMAN이면서 sal가 1400보다 작으면 SAL*1.1리턴 
--                          MANAGER이면  SAL * 1.1리턴
--                          KING이면 SAL * 1.2리턴
--                          그 밖의 사람들은 SAL을 리턴 

SELECT ename, job, sal
       ,CASE
          WHEN job = 'SALESMAN' AND sal>1400 THEN sal * 1.05
         WHEN job = 'SALESMAN' AND sal<1400 THEN sal * 1.1
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
        END BONUS
FROM emp;

SELECT ename, job, sal,
        DECODE(job, 'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2
           ,CASE
            WHEN job = 'SALESMAN' AND sal>1400 THEN sal * 1.05
            WHEN job = 'SALESMAN' AND sal<1400 THEN sal * 1.1
            ELSE sal
            END 
           ) BONUS
FROM emp;

