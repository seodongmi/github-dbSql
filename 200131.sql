--JOIN: 다른 테이블과 결합하여 데이터를 조회 

SELECT * 
FROM emp;
--emp테이블에 ename, deptno존재 
--dept테이블에 dname칼럼 존재 
--emp테이블에 ename, deptno, dname칼럼이 있다고 가정  
--부서명이 바뀌면?
--별도로 생성해 연결 
--> 중복을 최소화하는 RDBMS로 설계 
--191이미지 조인예시 

--JOIN문법 
--1. ANSI 문법
--2. ORACLE 문법

--Natual Join
--두 테이블 간 컬럼명이 같을 때  해당 컬럼으로 연결(조인)
--emp, dept 테이블에는 deptno라는 컬럼이 존재 

SELECT * 
FROM emp NATURAL JOIN dept;

--한정자를 이용하여 컬럼을 보여준다. 
SELECT emp.ename, emp.empno, dept.dname
FROM emp NATURAL JOIN dept;

SELECT emp.ename, emp.empno, dept.dname,deptno
FROM emp NATURAL JOIN dept;
--조인에 사용된 컬럼은 한정자를 사용할 수 없다. 
--NATURAL JOIN에 사용된 조인 컬럼(deptno)는 한정자(ex)테이블명, 테이블 별칭)을 사용하지 않고 
--컬럼명만 기술한다. (dept.deptno -> deptno)

--테이블에 대한 별칭도 사용가능 
SELECT e.ename, e.empno, d.dname,deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM절에 조인할 테이블 목록을 ,로 구분하여 나열한다
--조인할 테이블의 연결 조건을 WHERE절에 기술한다. 
--emp, dept 테이블에 존재하는 deptno칼럼이 (같을 때) 조인 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--다른 것과 연결 (42건의 데이터) 
--부서번호가 다를 때 조인 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

--오라클 조인의 테이블 명칭 
SELECT e.empno, e.name, d.name
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.empno, e.name, d.name, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;
--oracle JOIN에 사용된 조인 컬럼(deptno)은 한정자를 써주어야함 

SELECT * 
FROM emp;

SELECT * 
FROM dept;

--ANSI : JOIN WITH USING
--조인하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만 
--하나의 컬럼으로만 조인을 하고자 할 때 조인하려는 기준 컬럼을 기술 
--emp, dept 테이블의 공통 컬럼 : deptno;

SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING (deptno);

--JOIN WITH USING을 ORACLE로 표현하면?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--조인하려고 하는 테이블의 컬럼의 이름이 서로 다를 때 
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept ON (emp.deptno=dept.deptno);



