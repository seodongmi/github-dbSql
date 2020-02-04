--? ���μ���

--CROSS JOIN -> īƼ�� ���δ�Ʈ(Cartesian product)
--�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ��� 
--������ ��� ���տ� ���� ����(����)�� �õ� 
--dept(4��), emp(14��) CROSS JOIN�� ����� 4*14 = 56�� 
--dept���̺�� emp���̺��� ������ �ϱ� ���� FROM���� �ΰ��� ���̺��� ��� 
--WHERE���� �� ���̺��� ���� ���� ���� 
SELECT dept.dname, emp.empno, emp.ename 
FROM dept, emp;

--������ ���� 
SELECT dept.dname, emp.empno, emp.ename 
FROM dept, emp
WHERE dept.deptno = 10
AND dept.deptno = emp.deptno;

SELECT * 
FROM dept;
--�� 4��

SELECT * 
FROM emp;

--ANSI������ 
SELECT ename, dname
FROM emp CROSS JOIN dept;

--clossjoin 1
SELECT *
FROM customer, product;

--SUBQUERY: ���� �ȿ� �ٸ� ������ �� �ִ� ���
--SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
--SELECT�� : SCALAR SUBQUERY (���� �ϳ���) : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ���� 
--FROM�� : INLINE - VIEW (VIEW)
--WHRER�� : SUB QUERY 

--���ϰ��� �ϴ� �� : smith�� ���� �μ��� ���ϴ� �������� ������ ��ȸ 
--1. SMITH�� ���ϴ� �μ���ȣ�� ���Ѵ� 
--2. 1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ� 

--1.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2. 1������ ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ 
SELECT * 
FROM emp
WHERE deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ���� 
SELECT * 
FROM emp
WHERE deptno = (SELECT deptno  --IN�� ����
                FROM emp
                WHERE ename = 'SMITH');

SELECT COUNT(*)
FROM emp 
WHERE sal > (SELECT AVG(SAL)
            FROM emp); 
            
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(SAL)
            FROM emp); 
            --1. ��� �޿� ����; 
            --2. ���� ��պ��� �޿��� �޴� ��� 

--������ ������ 
--IN : ���������� ������ �� ��ġ�ϴ� ���� ������ ��  
--ANY (Ȱ�뵵�� �ټ� ������) : ���������� ������ �� �� ���̶� ������ ������ �� 
--ALL (Ȱ�뵵�� �ټ� ������) : ���������� ������ ���� ��� �࿡ ���� ������ ������ �� 

--SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ 
--SMITH�� WARD ������ ���ϴ� �μ��� ��� ������ ��ȸ

--���� ������ ����� �������� ���� = �����ڸ� ������� ���Ѵ� 
SELECT  * 
FROM emp
WHERE deptno IN (SELECT deptno
                     FROM emp 
                     WHERE ename = 'SMITH'
                       OR  ename = 'WARD');

--SMITH WARD ����� �޿����� �޿��� ���� ����� ��ȸ 
SELECT  * 
FROM emp
WHERE sal < ANY (SELECT sal   --��� �߿� �����ϴ� �� �ϳ��� ������ �� 
                 FROM emp 
                 WHERE ename IN ('SMITH', 'WARD'));
                 

--SMITH WARD ����� �޿����� �޿��� ���� ����� ��ȸ (SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��) 
SELECT  * 
FROM emp
WHERE sal > ALL (SELECT sal    
                 FROM emp 
                 WHERE ename IN ('SMITH', 'WARD'));
                 -- SMITH:800 WARD:1250 -> 1250���� �޿��� ���� ��� 

 --IN, NOT IN�� NULL�� ���õ� ���ǻ��� 
 
 --������ ������ ����� 7902�̰ų�(OR) NULL
 SELECT * 
 FROM emp
 WHERE mgr IN(7902, null); --IN(7566); �� ������ ��� -> NULL �ν�X
 
 --IN�����ڴ� OR�����ڷ� ġȯ���� 
SELECT * 
 FROM emp
 WHERE mgr = 7902 OR mgr  = null;
 --NULL�񱳴� =�����ڰ� �ƴ϶� IS NULL�� �� �ؾ������� 
 --IN�����ڴ� =�� ����Ѵ� 
 
--empno NOT IN (7902, NULL) --AND 
--�����ȣ�� 7902�� �ƴϸ鼭(AND) NULL�� �ƴ� ������ 
 
SELECT * 
FROM emp
SELECT * 
 FROM emp
 WHERE mgr = 7902 OR mgr  = null;
 empno != 7902 
AND empno != NULL; --�׻� ���� (��ü�� NULL�� �� ó�� ���´�)

--�� 
SELECT * 
FROM emp
WHERE empno != 7902;

pairwise(������)
�������� ����� ���ÿ� ���� ��ų ��
(mgr, deptno)
(7698, 30) (7839,10)

WHERE(mgr, deptno) IN (SELECT mgr, deptno;
                      FROM emp 
                      WHERE empno IN (7499, 7782));

non-pairwise�� �������� ���ÿ� �������� �ʴ� ���·� �ۼ� 
(mgr, deptno)
mgr���� 7698�̰ų� 7849 �̸鼭 
deptno�� 10 �̰ų� 30���� ���� 
(7698,10)   (7698,30)
(7839,10)   (7839,30)
SELECT * 
FROM emp
WHERE mgr IN (SELECT mgr 
                      FROM emp 
                      WHERE empno IN (7499, 7782))
AND deptno IN (SELECT deptno
                      FROM emp 
                      WHERE empno IN (7499, 7782));

--��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ���� 
--��Į�� ���������� MAIN ������ �÷��� ����ϴ� �� �����ϴ� 

SELECT SYSDATE 
FROM dual;
SELECT (SELECT SYSDATE FROM dual), dept.* 
FROM dept

SELECT empno, ename, deptno, �μ���
FROM emp , dept;
WHERE emp.deptno = dept.deptno;

SELECT empno, ename, deptno, 
     (SELECT dname FROM dept WHERE deptno = emp.deptno) danme 
FROM emp; 
--�������� ���� ����� ���� 

--IN LIKE VIEW : FROM���� ���� ��������

MAIN������ ������ SUBQUERY���� ����ϴ� �� ������ ���� �з� 
����� ��� : correlated subqueury (��ȣ ��������), ���������� �ܵ����� �����ϴ� �� �Ұ��� 
            ��������� ������ �ִ� (main ==> sub)
������� ���� ���: non-correlated suvquery(���ȣ ���� ��������), ���������� �ܵ����� �����ϴ� �� �Ұ��� 
                 ��������� ������ ���� �ʴ� (main ==> sub, sub ==> main)
��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ 
SELECT * 
FRON enp
sal> WHERE
SELECT AVG(sal)
FROM emp); -���ȣ ���� ���� 

--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ 
SELECT * 
FROM emp m
WHERE sal > (SELECT avg(sal)
              FROM emp s
              WHERE s.deptno = m.deptno);
              
--���� ������ ������ �̿��ؼ� Ǯ��� 
--1. ���� ���̺� ���� 
--   emp, �μ��� �޿� ���(inline view)
SELECT emp.* --emp.ename, sal, emp.deptno, dept_sal.* 
FROM emp, (SELECT deptno, ROUNT(AVG(sal), avg_sal
           FROM emp 
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;

--������ �߰� 
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--ROLLBACK : Ʈ����� ��� 
--COMMIT : Ʈ����� Ȯ�� 

--���ȣ, NOT IN 
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

