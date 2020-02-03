select *
FROM CUSTOMER;

select * 
FROM product;

select * 
FROM cycle;

--�Ǹ��� : 200 ~ 250
--���� 2.5�� ��ǰ 
--�Ϸ� : 500~750 
--�Ѵ� : 1500~17500

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

--join�� �ϸ鼭 3���� ���̺� row�� �����ϴ� ������ ����, �׷��Լ��� ���� 
SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) 
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, pnm, cycle.pid;

SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) 
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, pnm, cycle.pid;

--���� 
SELECT cycle.pid, pnm, sum(cnt) 
FROM cycle, product 
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;  

-- ���� 8 ~ 13(ppt 126����)

--�ش� ����Ŭ ������ ��ϵ� �����(����)��ȸ 

SELECT * 
FROM dba_users;

--HR ������ ��й�ȣ�� JAVA�� �ʱ�ȭ 
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

-- inner ���� : ������ ������ �����ϸ� �����Ͱ� ������ ���� 
-- outer ����: �÷� ������ �����ص� ������ �Ǵ� ���̺��� �����Ͱ� �������� 

--OUTER  JOIN 
--�� ���̺��� ������ �� ���� ������ ���� ��Ű�� ���ϴ� �����͸� 
--�������� ������ ���̺��� �����͸��̶� ��ȸ�ǰԲ� �ϴ� ���� ���;

--���� ���� : e.mgr = e.empno : KING�� MGR NULL�̱� ������ ���ο� ����
--emp ���̺��� �� 14�������� �Ʒ��� ���� ���������� ����� 13�� �ȴ�. (1�� ���ν���)
SELECT e.empno, e.ename, e.mgr, e.mgr , m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER 
--1. ���ο� �����ϴ��� ��ȸ�� �� ���̺��� ���� (�Ŵ��� ������ ��� ��������� �����Բ�)

SELECT *
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e RIGHT OUTER JOIN emp m ON e.mgr = m.empno;

--ORACLE JOIN 
--�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+) ��ȣ�� �ٿ��ش�. 
SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

--���� SQL�� ANSI SQL(OUTER JOIN)���� �����غ����� 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

--���� SQL�� �Ƚ� SQL(OUTER JOIN)���� �����غ����� 
--�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10); --outer���� ����� ���� 

--�Ʒ� LEFT OUTER������ ���������� OUTER������ �ƴϴ� �Ʒ� INNER ���ΰ� ����� �����ϴ� 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno) --��������� ������ ��� 
WHERE m.deptno=10; -- outer������ ����� ������� ���� 

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON(e.mgr = m.empno) 
WHERE m.deptno=10; 

--����Ŭ OUTER JOIN
--����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ��� 
--�������� OUTER JOIN���� �����Ѵ�. 
--�� �÷��̶� (+)�� �����ϸ� INNER�������� ���� 

--�Ʒ�  ORACLE OUTER������ INNER�������� ���� : m.deptnoĮ���� (+)�� �������� 
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;-- outer������ ����� ������� ����

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

-- ��� - �Ŵ����� RIGHT OUTER JOIN 
SELECT empno, ename, mgr 
FROM emp e;

SELECT empno, ename 
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ�����
SELECT e.empno, e.ename                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno); --FULL OUT : 22��

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty 
FROM buyprod RIGHT OUTER JOIN prod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005-01-25', 'YYYY-MM-DD'));

--ORACLE OUTER JOIN������ (+)��ȣ�� �̿��Ͽ� FULL OUTER ������ �������� �ʴ´�. 

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty 
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('2005-01-25', 'YYYY-MM-DD');

SELECT nvl(buyprod.buy_date, TO_DATE('20050125', 'YYYYMMDD'))   , buy_date   , buy_prod, prod_id, prod_name, buy_qty 
FROM buyprod RIGHT OUTER JOIN prod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005-01-25', 'YYYY-MM-DD'))
