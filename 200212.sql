--2��° �ε����� �ִٴ� ������ 
--1. table full
--1. index1 :empno 
--3. index2 : job -index2�� �� ���ٰ� �Ǵ�
--access("JOB"='MANAGER') -> filter("ENAME" LIKE 'C%')
--���̺� ���� �� 3���� �����͸� �а� ���͸�

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);


--3��° �ε��� ����� 
CREATE INDEX idx_n_emp_03 ON emp (job,ename); --�����ε��� 

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE 'C%';

SELECT * 
FROM TABLE(dbms_xplan.display);

SELECT job, ename, rowid 
FROM empno;

--access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
--�ε����� �о��ְ� ���̺� �����ϴ� ���� �� �Ѱ� 

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE '%C';

SELECT * 
FROM TABLE(dbms_xplan.display);

SELECT * 
FROM TABLE(dbms_xplan.display);
--�����ȹ�� �����ϳ�, ���ǿ� �����ϴ� ���� ���� 
--%�� ���ʿ� ������ index�� ���� ������Ѵ� 

--1. table full 
--2. indx1 : empno
--3. indx2 : job
--4. index3 : job + ename 
--5. index4 : ename + job 

--���� �ε��� �÷��� ���� 
--3���� �ε����� ������ 
--3,4 ��° �ε����� Į�� ������ �����ϰ� ������ �ٸ��� 

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
ORDER BY empno, job; --4��° �ε����� �̷��� ������ 
EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' AND ename LIKE 'J%';

SELECT * 
FROM TABLE(dbms_xplan.display);

--���ο����� �ε��� 
--emp - table full , pk_emp(empno) 
--dept - table full , pk_dept(deptno)

--1. ���� 
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

--2�� ���̺� ���� 
--������ ���̺� �ε��� 5���� �ִٸ� �� ���̺� ���� ���� : 6
--36 * 2 = 72 

--ORACLE - �ǽð� ���� : OLTP (ON LINE TRANDSCTION PROCESSING)
--        ��ü ó���ð� : OLAP (ON LINE ANALYSIS PROCESSING) - ������ ������ �����ȹ�� ����µ�(30M-1H)

--EMP���� ������ dept���� ������? 
EXPLAIN PLAN FOR
SELECT ename, dname, loc 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno IN(7788);

SELECT *
FROM emp;

SELECT * 
FROM TABLE(dbms_xplan.display);

--PK�� ���� ��Ȳ 
--4-3-5-2-6-1-0
-- INDEX RANGE SCAN  
-- TABLE ACCESS BY INDEX ROWID| EMP    :  ���̺� ���� : ���� �� 
-- �μ���ȣ 20���� ���� �ε����� Ž�� 

--INDEX : �Ҽ��� ������ ��ȸ�� ���� 
--TABLE full access : ���̺� ��� ������ �о ó���ϴ� ��� 

--CTAS : �������� ���簡 NOT NULL�� �ȴ� 
--����̳� �׽�Ʈ�� 

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
--empno (=) ==> empno (�ߺ������� �����X)
--ename (=) ==> ename 
--deptno (=), empno(LIKE ������ȣ%) ==> empno, deptno 
--
--deptno(=) , sal(BETWEEN)  
--deptno(=) / mgr �����ϸ� ���� 
--empno(=) (��������)
--deptno, hiredate�� �ε����� �����ϸ� ���� 
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

--empno (=) ==> empno (�ߺ������� �����)
--ename (=) ==> ename 
--deptno (=), empno(LIKE ������ȣ%) ==> empno, deptno
--
--deptno(=) , sal(BETWEEN)  
--deptno(=) / mgr �����ϸ� ���� 
--empno(=) (��������)
--deptno, hiredate�� �ε����� �����ϸ� ���� 

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
--deptno (=), deptno(LIKE ������ȣ%) ==>deptno, deptno
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

