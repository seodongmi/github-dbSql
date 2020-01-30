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

--���س⵵�� ¦������ Ȧ������ Ȯ�� 
--DATEŸ�� -> ���ڿ� (�������� ����, YYYY_MM_DD HH24:MI:SS)
SELECT empno, ename, hiredate,
       DECODE (MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')),2),
                 MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2),'�ǰ����� �����', '�ǰ����� ������'
        )CONTACT_NO_DECTOR
FROM emp;

--����) ����3 

--GROUP BY ���� ���� ����
--�μ���ȣ ���� ROW���� ���� ��� : GROUP BY deptno
--�������� ���� ROW���� ���� ���: GROUP BY job 
--MGR�� ���� �������� ���� ROW���� ���� ��� : GROUP BY mgr, job 

--�׷��Լ��� ���� 
-- sum : �հ�
-- count : ���� --NULL���� �ƴ� ROW�� ���� 
-- MAX : �ִ밪
-- MIN : �ּҰ�
-- AVG : ���

--�׷��Լ��� Ư¡ 
--�ش� �÷��� NULL���� ���� ROW�� ������ ��� ���� �����ϰ� ����Ѵ�.
--(NULL ������ ����� NULL)

--�μ��� �޿� ��
--�׷��Լ� ������ 
--GROUP BY���� ���� �ø��̿ܿ� �ٸ� �÷��� SELECT���� ǥ���Ǹ� ������ �߻� 
SELECT deptno, ename, --����
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno; 

--GROUP BY ���� ���� ���¿��� �׷��Լ��� ����� ��� 
-- --> ��ü ���� �ϳ��� ������ ���´�.   --> SELECT deptno, ename,������ ���� 
SELECT deptno, ename,
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp;

--�̷��Դ� ��밡�� 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp;


SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm�÷��� ���� null�� �ƴ� row�� ���� 
       COUNT(*) --����� �����Ͱ� �ִ���
FROM emp;

--GROUP BY������ COMM�̸� ������� ���? 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm�÷��� ���� null�� �ƴ� row�� ���� 
       COUNT(*) --����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

--�׷�ȭ�� ������ ���� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� ������ ���� ����  
SELECT 1, SYSDATE,'ACOUNTING', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(comm), --comm�÷��� ���� null�� �ƴ� row�� ���� 
       COUNT(*) --����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION�� ��� WHERE������ ����ϴ� ���� �����ϳ�
--MULTI ROW FUNDION(GROUP FUNCTION)�� ��� WHERE������ ����ϴ� ���� �Ұ��� �ϰ� 
--HAVING������ ������ ����Ѵ� 

--�μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ 
--deptno, �޿��� 

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

--ORACLE 9 ���������� GROUP BY���� ����� �÷����� ������ ���� 
--       10 ���ĺ��ʹ�  GROUP BY���� ����� �÷����� ������ �������� �ʴ´� (GROUP BY ����� �ӵ�UP)
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
