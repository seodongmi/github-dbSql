--JOIN: �ٸ� ���̺�� �����Ͽ� �����͸� ��ȸ 

SELECT * 
FROM emp;
--emp���̺� ename, deptno���� 
--dept���̺� dnameĮ�� ���� 
--emp���̺� ename, deptno, dnameĮ���� �ִٰ� ����  
--�μ����� �ٲ��?
--������ ������ ���� 
--> �ߺ��� �ּ�ȭ�ϴ� RDBMS�� ���� 
--191�̹��� ���ο��� 

--JOIN���� 
--1. ANSI ����
--2. ORACLE ����

--Natual Join
--�� ���̺� �� �÷����� ���� ��  �ش� �÷����� ����(����)
--emp, dept ���̺��� deptno��� �÷��� ���� 

SELECT * 
FROM emp NATURAL JOIN dept;

--�����ڸ� �̿��Ͽ� �÷��� �����ش�. 
SELECT emp.ename, emp.empno, dept.dname
FROM emp NATURAL JOIN dept;

SELECT emp.ename, emp.empno, dept.dname,deptno
FROM emp NATURAL JOIN dept;
--���ο� ���� �÷��� �����ڸ� ����� �� ����. 
--NATURAL JOIN�� ���� ���� �÷�(deptno)�� ������(ex)���̺��, ���̺� ��Ī)�� ������� �ʰ� 
--�÷��� ����Ѵ�. (dept.deptno -> deptno)

--���̺� ���� ��Ī�� ��밡�� 
SELECT e.ename, e.empno, d.dname,deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�
--������ ���̺��� ���� ������ WHERE���� ����Ѵ�. 
--emp, dept ���̺� �����ϴ� deptnoĮ���� (���� ��) ���� 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�ٸ� �Ͱ� ���� (42���� ������) 
--�μ���ȣ�� �ٸ� �� ���� 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

--����Ŭ ������ ���̺� ��Ī 
SELECT e.empno, e.name, d.name
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.empno, e.name, d.name, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;
--oracle JOIN�� ���� ���� �÷�(deptno)�� �����ڸ� ���־���� 

SELECT * 
FROM emp;

SELECT * 
FROM dept;

--ANSI : JOIN WITH USING
--�����Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ������� 
--�ϳ��� �÷����θ� ������ �ϰ��� �� �� �����Ϸ��� ���� �÷��� ��� 
--emp, dept ���̺��� ���� �÷� : deptno;

SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING (deptno);

--JOIN WITH USING�� ORACLE�� ǥ���ϸ�?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--�����Ϸ��� �ϴ� ���̺��� �÷��� �̸��� ���� �ٸ� �� 
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept ON (emp.deptno=dept.deptno);



