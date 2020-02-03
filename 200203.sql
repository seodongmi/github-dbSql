select *
FROM CUSTOMER;

select * 
FROM product;

select * 
FROM cycle;

--판매점 : 200 ~ 250
--고객당 2.5개 제품 
--하루 : 500~750 
--한달 : 1500~17500

SELECT * 
FROM daily;

SELECT * 
FROM batch;

SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle 
WHERE customer.cid = cycle.cid AND (customer.cnm = 'brown' OR customer.cnm = 'sally');

SELECT cid, cnm, pid, day, cnt
FROM customer JOIN cycle USING (cid)
WHERE customer.cnm = 'brown' OR customer.cnm = 'sally';

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid AND (customer.cnm = 'brown' OR customer.cnm = 'sally');

--join을 하면서 3개의 테이블 row를 제한하는 조건을 결합, 그룹함수를 적용 
SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) 
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, pnm, cycle.pid;

SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) 
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, pnm, cycle.pid;

--숙제 
SELECT cycle.pid, pnm, sum(cnt) 
FROM cycle, product 
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;  

-- 숙제 8 ~ 13(ppt 126부터)

--해당 오라클 서버에 등록되 사용자(계정)조회 

SELECT * 
FROM dba_users;

--HR 계정의 비밀번호를 JAVA로 초기화 
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

-- inner 조인 : 데이터 연결이 실패하면 데이터가 나오지 않음 
-- outer 조인: 컬럼 연결이 실패해도 기준이 되는 테이블의 데이터가 나오도록 

--OUTER  JOIN 
--두 테이블을 조인할 때 연결 조건을 만족 시키지 못하는 데이터를 
--기준으로 지정한 테이블의 테이터만이라도 조회되게끔 하는 조인 방식;

--연결 조건 : e.mgr = e.empno : KING의 MGR NULL이기 떄문에 조인에 실패
--emp 테이블은 총 14건이지만 아래와 같은 쿼리에서는 결과가 13이 된다. (1건 조인실패)
SELECT e.empno, e.ename, e.mgr, e.mgr , m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER 
--1. 조인에 실패하더라도 조회가 될 테이블을 선정 (매니저 정보가 없어도 사원정보는 나오게끔)

SELECT *
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e RIGHT OUTER JOIN emp m ON e.mgr = m.empno;

--ORACLE JOIN 
--데이터가 없는 쪽의 테이블 컬럼 뒤에 (+) 기호를 붙여준다. 
SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

--위의 SQL을 ANSI SQL(OUTER JOIN)으로 변경해보세요 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

--위의 SQL을 안시 SQL(OUTER JOIN)으로 변경해보세요 
--매니저의 부서번호가 10번인 직원만 조회 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10); --outer조인 제대로 적용 

--아래 LEFT OUTER조인은 실질적으로 OUTER조인이 아니다 아래 INNER 조인과 결과가 동일하다 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno) --여기까지가 조인의 결과 
WHERE m.deptno=10; -- outer조인이 제대로 적용되지 않음 

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON(e.mgr = m.empno) 
WHERE m.deptno=10; 

--오라클 OUTER JOIN
--오라클 OUTER JOIN시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)을 붙여야 
--정상적인 OUTER JOIN으로 동작한다. 
--한 컬럼이라도 (+)을 누락하면 INNER조인으로 동작 

--아래  ORACLE OUTER조인은 INNER조인으로 동작 : m.deptno칼럼에 (+)가 붙지않음 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;-- outer조인이 제대로 적용되지 않음

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

-- 사원 - 매니저간 RIGHT OUTER JOIN 
SELECT empno, ename, mgr 
FROM emp e;

SELECT empno, ename 
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복제거
SELECT e.empno, e.ename                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno); --FULL OUT : 22건

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty 
FROM buyprod RIGHT OUTER JOIN prod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005-01-25', 'YYYY-MM-DD'));

--ORACLE OUTER JOIN에서는 (+)기호를 이용하여 FULL OUTER 문법을 지원하지 않는다. 

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty 
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('2005-01-25', 'YYYY-MM-DD');

SELECT nvl(buyprod.buy_date, TO_DATE('20050125', 'YYYYMMDD'))   , buy_date   , buy_prod, prod_id, prod_name, buy_qty 
FROM buyprod RIGHT OUTER JOIN prod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005-01-25', 'YYYY-MM-DD'))
