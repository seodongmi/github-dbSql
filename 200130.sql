SELECT empno, ename
       ,CASE
          WHEN deptno = 10 THEN  'ACCOUNTING'
          WHEN deptno = 20 THEN  'RESEARCH'
           WHEN deptno = 30 THEN 'SALES'
           WHEN deptno = 40 THEN 'OPERATIONS'
          ELSE 'DDIT'
        END DNAME
FROM emp;


SELECT empno, ename,
        DECODE(deptno, 10,  'ACCOUNTING',
                       20, 'RESEARCH',
                       30, 'SALES',
                       40, 'OPERATIONS', 'DDIT'
           ) DNAME
FROM emp;

SELECT *
FROM emp;

--올해년도가 짝수인지 홀수인지 확인 
--DATE타입 -> 문자열 (여러가지 포맷, YYYY_MM_DD HH24:MI:SS)
SELECT empno, ename, hiredate,
       DECODE (MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')),2),
                 MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2),'건강검진 대상자', '건강검진 비대상자'
        )CONTACT_NO_DECTOR
FROM emp;

--숙제) 과제3 

--GROUP BY 행을 묶을 기준
--부서번호 같은 ROW끼리 묶는 경우 : GROUP BY deptno
--담당업무가 같은 ROW끼리 묶는 경우: GROUP BY job 
--MGR가 같고 담당업무가 같은 ROW끼리 묶는 경우 : GROUP BY mgr, job 

--그룹함수의 종류 
-- sum : 합계
-- count : 갯수 --NULL값이 아닌 ROW의 갯수 
-- MAX : 최대값
-- MIN : 최소값
-- AVG : 평균

--그룹함수의 특징 
--해당 컬럼에 NULL값을 갖는 ROW가 존재할 경우 값은 무시하고 계산한다.
--(NULL 연산의 결과는 NULL)

--부서별 급여 합
--그룹함수 주의점 
--GROUP BY절에 나온 컬림이외에 다른 컬럼이 SELECT절에 표현되면 에러를 발생 
SELECT deptno, ename, --에러
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno; 

--GROUP BY 절이 없는 상태에서 그룹함수를 사용한 경우 
-- --> 전체 행을 하나의 행으로 묶는다.   --> SELECT deptno, ename,나오지 않음 
SELECT deptno, ename,
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp;

--이렇게는 사용가능 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp;


SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm컬럼의 값이 null이 아닌 row의 개수 
       COUNT(*) --몇건의 데이터가 있는지
FROM emp;

--GROUP BY기준이 COMM이면 결과수가 몇건? 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm컬럼의 값이 null이 아닌 row의 개수 
       COUNT(*) --몇건의 데이터가 있는지
FROM emp
GROUP BY empno;

--그룹화와 관련이 없는 임의의 문자열, 함수, 숫자들은 SELECT절에 나오는 것이 가능  
SELECT 1, SYSDATE,'ACOUNTING', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm컬럼의 값이 null이 아닌 row의 개수 
       COUNT(*) --몇건의 데이터가 있는지
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION의 경우 WHERE절에서 사용하는 것이 가능하나
--MULTI ROW FUNDION(GROUP FUNCTION)의 경우 WHERE절에서 사용하는 것이 불가능 하고 
--HAVING절에서 조건을 기술한다 

--부서별 급여 합 조회, 단 급여합이 9000이상인 row만 조회 
--deptno, 급여합 

SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) AVG_SAL , SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(MGR) count_mgr, COUNT(*) count_all
FROM emp;

SELECT *
FROM emp;

SELECT deptno, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) AVG_SAL , SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(MGR) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT CASE
  WHEN deptno = 10 THEN  'ACCOUNTING'
          WHEN deptno = 20 THEN  'RESEARCH'
           WHEN deptno = 30 THEN 'SALES'
            END DNAME,
                MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) AVG_SAL , SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(MGR) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno ORDER BY deptno;

SELECT 
        DECODE(deptno, 10, 'ACCOUNTING',
                       20, 'RESEARCH',
                       30 , 'SALES'
                       )DNAME,
                MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) AVG_SAL , SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(MGR) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno ORDER BY deptno;

--ORACLE 9 이전까지는 GROUP BY절에 기술한 컬럼으로 정렬을 보장 
--       10 이후부터는  GROUP BY절에 기술한 컬럼으로 정렬을 보장하지 않는다 (GROUP BY 연산시 속도UP)
SELECT TO_CHAR( HIREDATE , 'YYYYMM') HIRE_YYYYMM, COUNT(*) CNT
FROM emp
GROUP BY TO_CHAR( HIREDATE , 'YYYYMM');

SELECT TO_CHAR( HIREDATE , 'YYYY') HIRE_YYYY, COUNT(*) CNT
FROM emp
GROUP BY TO_CHAR( HIREDATE , 'YYYY');

SELECT COUNT(*) cnt
FROM dept;

SELECT COUNT(COUNT(DEPTNO)) CNT 
FROM emp
GROUP BY DEPTNO;

SELECT COUNT(*) 
FROM 
(SELECT deptno
FROM emp
GROUP BY deptno);

--GROUP BY, JOIN
