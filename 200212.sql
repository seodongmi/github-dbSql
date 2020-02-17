--2번째 인덱스가 있다는 가정하 
--1. table full
--1. index1 :empno 
--3. index2 : job -index2가 더 좋다고 판단
--access("JOB"='MANAGER') -> filter("ENAME" LIKE 'C%')
--테이블에 접근 후 3가지 데이터를 읽고 필터링

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);


--3번째 인덱스 만들기 
CREATE INDEX idx_n_emp_03 ON emp (job,ename); --복합인덱스 

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);

SELECT job, ename, rowid 
FROM empno;

--access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
--인덱스만 읽어주고 테이블에 접근하는 행은 단 한개 

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE '%C';

SELECT * 
FROM TABLE(dbms_xplan.display);

SELECT * 
FROM TABLE(dbms_xplan.display);
--실행계획은 동일하나, 조건에 만족하는 것이 없음 
--%가 앞쪽에 나오면 index를 거의 못사용한다 

--1. table full 
--2. indx1 : empno
--3. indx2 : job
--4. index3 : job + ename 
--5. index4 : ename + job 

--복합 인덱스 컬럼의 순서 
--3번쨰 인덱스를 지우자 
--3,4 번째 인덱스가 칼럼 구성이 동일하고 순서만 다르다 

DROP INDEX idx_n_emp_03;

CREATE INDEX idx_n_emp_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);

--   2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
--       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')


SELECT ename, job, rowid 
FROM emp 
ORDER BY empno, job; --4번째 인덱스는 이렇게 생겼음 
EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE 'J%';

SELECT * 
FROM TABLE(dbms_xplan.display);

--조인에서의 인덱스 
--emp - table full , pk_emp(empno) 
--dept - table full , pk_dept(deptno)

--1. 순서 
--(emp - table full, dept - table full ) 
--(dept - table full, emp - table full)
--
--(emp - table full, dept - pk_dept)
--(dept - pk_dept, emp - table full) 
--
--(emp - pk emp, dept - table full)
--(dept - table full, emp - pk emp)
--
--(emp - pk emp,dept - pk_dept)
--(dept - pk_dept, emp - pk emp)

--2개 테이블 조인 
--각각의 테이블에 인덱스 5개씩 있다면 한 테이블에 접근 전략 : 6
--36 * 2 = 72 

--ORACLE - 실시간 응담 : OLTP (ON LINE TRANDSCTION PROCESSING)
--        전체 처리시간 : OLAP (ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는데(30M-1H)

--EMP부터 읽을까 dept부터 읽을까? 
EXPLAIN PLAN FOR
SELECT ename, dname, loc 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno IN(7788);

SELECT *
FROM emp;

SELECT * 
FROM TABLE(dbms_xplan.display);

--PK가 없는 상황 
--4-3-5-2-6-1-0
-- INDEX RANGE SCAN  
-- TABLE ACCESS BY INDEX ROWID| EMP    :  테이블에 접근 : 행을 얻어냄 
-- 부서번호 20번을 갖고서 인덱스를 탐색 

--INDEX : 소수의 데이터 조회시 유리 
--TABLE full access : 테이블 모든 데이터 읽어서 처리하는 경우 

--CTAS : 제약조건 복사가 NOT NULL만 된다 
--백업이나 테스트용 

CREATE TABLE DEPT_TEST2 AS 
SELECT * 
FROM DEPT 
WHERE 1=1;

--1
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON DEPT_TEST2(deptno);

--2
CREATE INDEX idx_n_dept_test2_02 ON DEPT_TEST2(dname);

--3
CREATE INDEX idx_u_dept_test2_03 ON DEPT_TEST2(deptno, dname);

DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_n_dept_test2_02;
DROP INDEX idx_u_dept_test2_03;

-----------------------
CREATE TABLE emp_test3 AS 
SELECT * 
FROM emp;
DESC emp;

CREATE TABLE dept_test3 AS 
SELECT * 
FROM dept;
DESC dept;

---------------------------------------------------------
EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3
WHERE empno = 7369;

--access pattern 
--empno (=) ==> empno (중복됨으로 지우기X)
--ename (=) ==> ename 
--deptno (=), empno(LIKE 직원번호%) ==> empno, deptno 
--
--deptno(=) , sal(BETWEEN)  
--deptno(=) / mgr 동반하면 유리 
--empno(=) (지워도됨)
--deptno, hiredate가 인덱스에 존재하면 유리 
--
--deptno, sal, mgr, hiredate  

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3 
WHERE ename = 'SMITH';

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3 e, dept_test3 d
WHERE e.deptno = d.deptno
AND e.deptno = 20
AND e.empno Like 7369 || '%';

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp 
WHERE sal BETWEEN 1000  AND 3000
AND deptno = 20;

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT B.* 
FROM emp A, emp B
WHERE A.mgr = b.empno
AND A.deptno = 20;

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'), COUNT(*)CNT
FROM emp 
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');

SELECT * 
FROM TABLE(dbms_xplan.display);

--empno (=) ==> empno (중복됨으로 지우기)
--ename (=) ==> ename 
--deptno (=), empno(LIKE 직원번호%) ==> empno, deptno
--
--deptno(=) , sal(BETWEEN)  
--deptno(=) / mgr 동반하면 유리 
--empno(=) (지워도됨)
--deptno, hiredate가 인덱스에 존재하면 유리 

DROP INDEX idx_n_emp_05;
CREATE UNIQUE INDEX idx_n_emp_05 ON  emp_test3(ename);

DROP INDEX idx_n_emp_06;
CREATE INDEX idx_n_emp_06 ON  emp_test3(empno, deptno);

DROP INDEX idx_n_emp_09;
CREATE INDEX idx_n_emp_9 ON  emp_test3(deptno, sal);

DROP INDEX idx_n_emp_08;
CREATE INDEX idx_n_emp_08 ON  emp_test3(deptno, mgr);

DROP INDEX idx_n_emp_10;
CREATE INDEX idx_n_emp_10 ON  emp_test3(empno, hiredate);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3
WHERE empno = 7369;

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM dept_test3 
WHERE deptno = 20;

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3 e, dept_test3 d
WHERE e.deptno = d.deptno
AND e.deptno = 20
AND e.empno Like 7369 || '%';

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3
WHERE sal BETWEEN 1000  AND 3000
AND deptno = 20;

SELECT * 
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT * 
FROM emp_test3, dept_test3
WHERE emp_test3.deptno = 20
AND dept_test3.loc = 'NEW YORK';

SELECT * 
FROM TABLE(dbms_xplan.display);

--empno (=) ==> empno 
--deptno (=) ==> detno 
--deptno (=), deptno(LIKE 직원번호%) ==>deptno, deptno
--
--deptno(=) , sal(BETWEEN)  
--deptno(=) / loc


DROP INDEX idx_n_emp_05;
CREATE INDEX idx_n_emp_05 ON  dept_test3(deptno);

DROP INDEX idx_n_emp_06;
CREATE INDEX idx_n_emp_06 ON  emp_test3(empno); -- 

DROP INDEX idx_n_emp_08;
CREATE INDEX idx_n_emp_08 ON  emp_test3(deptno,sal);

DROP INDEX idx_n_emp_09;
CREATE INDEX idx_n_emp_09 ON dept_test3(loc);

