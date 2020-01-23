--IN ������
--Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ�� 
--�μ� ��ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ 

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10,20);

--IN�����ڸ� ������� �ʰ� OR������ ��� 
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10 OR deptno = 20;

--emp���̺��� ����̸��� smith, jones�� ������ ��ȸ(empno, ename, deptno)
--���� ��� ���� 
--AND / OR
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN('SMITH','JONES');

--��ü �����͸� ��ȸ�ϴ� ����� ���� 
SELECT * 
FROM users
WHERE userid = userid;

SELECT * 
FROM users
WHERE 1 = 1;

--users���̺��� uerid�� brown, cony, sally�� �����͸� ��ȸ 
SELECT usernm AS �̸�, userid AS ���̵�, alias AS ����
FROM users
WHERE usernm IN('����','�ڴ�','����');

--���ڿ� ��Ī ������: LIKE, %, _
--������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٸ� 
--�̸��� BR�� �����ϴ� ����� ��ȸ 
--�̸��� R ���ڿ��� ���� ����� ��ȸ 

--����̸��� s�� �����ϴ� ��� ��ȸ 
--SMITH, SMILE, SKC
--%: � ���ڿ�(�ѱ���, ���ڰ� ���� ���� �ְ�, ���� ���ڿ��� �� ���� �ִ�)
SELECT * 
FROM emp
WHERE ename LIKE 'S%';

--���ڼ� ������ ���� ��Ī 
--_��Ȯ�� �ѹ���
--���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5������ ���� 
--s____
SELECT * 
FROM emp
WHERE ename LIKE 'S____';

--��� �̸��� s���ڰ� ���� ��� ��ȸ
SELECT * 
FROM emp
WHERE ename LIKE '%S%';

--ȸ���� ���� �ž��� ����� mem_id, mem_name ��ȸ 
SELECT mem_id, mem_name 
FROM member
WHERE mem_name LIKE '��%';

--ȸ���� �̸��� �̰� ���� ��� �����  mem_id, mem_name ��ȸ 
SELECT mem_id, mem_name 
FROM member
WHERE mem_name LIKE '%��%';

--null �� ���� (IS)
--comm �÷��� ���� null�� �����͸� ��ȸ (WHERE comm = null)

--SELECT * 
--FROM emp 
--WHERE comm =  null;
--null�� equls�����ڸ� ����x 

SELECT * 
FROM emp 
WHERE comm IS null;

--null�� �ƴ� ������ ��ȸ 
SELECT * 
FROM emp 
WHERE comm IS NOT null;

--�󿩴� ������ ���� ������ 0���� ũ�� null�� �ƴ��� �����Ͽ� �˻� 
SELECT * 
FROM emp 
WHERE comm >= 0;

--������(NOT)
--����� �����ڰ� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ 

--**NOT IN �����ڿ��� NULL���� ���Խ�Ű�� �ȵȴ�. 
SELECT * 
FROM emp 
WHERE mgr NOT IN(7698, 7839, NULL);

--����� ���� �Ǹ� 
SELECT * 
FROM emp 
WHERE mgr NOT IN(7698, 7839) AND mgr IS NOT NULL;

--�ǽ� where7�� ���� 
SELECT * 
FROM emp 
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO != 10 AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO NOT IN(10) AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO IN(20,30) AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO LIKE '78%';
--���������� int -> ���ڿ� 

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO >= 7800 AND EMPNO < 7900;

--������ �켱���� 
--*,/ �����ڰ� +,-���� �켱������ ����. 
--�켱���� ���� : ()
-- AND > OR OR���� AND�� �켱���� ���� 

--emp���̺��� ����̸��� SMITH�̰ų� ����̸��� ALLEN�̸鼭 �������� SALESMAN�� ��� ��ȸ 
--��ȣ�� ���ִ� �� ��Ȯ 
SELECT * 
FROM emp 
WHERE ENAME = 'SMITH' OR (ENAME = 'ALLEN' AND JOB = 'SALESMAN');

--����̸��� SMITH�̰ų� ALLEN�̸� �������� SALESMAN�� ��� ��ȸ
SELECT * 
FROM emp 
WHERE (ENAME = 'SMITH' OR ENAME = 'ALLEN') AND JOB = 'SALESMAN';

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO LIKE '78%' AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD') ;

--����
--TABLE��ü���� �����͸� ����/��ȸ�� ������ �������� ����
--SELECT * 
--FROM table
--[WHERE}
--ORDER BY (Į��|��Ī|�÷��ε��� ([ASC |DESC], ...) 
--ASC�� �⺻ ��(�־ ��� ��)

--emp ���̺��� ��� ����� ename Į�� ���� �������� �������� ������ ��� ��ȸ
SELECT * 
FROM emp
ORDER BY ename; 

--emp ���̺��� ��� ����� ename Į�� ���� �������� �������� ������ ��� ��ȸ
SELECT * 
FROM emp
ORDER BY ename DESC; 

DESC emp; --DESC : DESRIBE (�����ϴ�)
ORDER BY ename DESC; --DESC: DESCENDING (����)

--emp ���̺��� ��� ������ ename�÷����� ��������, 
--ename ���� ���� ��� mgr�÷����� �������� �����ϴ� ���� �ۼ� 
SELECT * 
FROM emp
ORDER BY ename DESC, mgr; 

--���Ľ� ��Ī�� ��� 
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;
-- sal*12 year_sal�� ��Ī���� ����� ���İ��� 
--FROM���� ���� SELECT�� ���� �� ORDER BY�� ���� (��Ī���� ����)

--�÷� �ε���(�÷� ��ȣ)�� ���� 
--java array[0]
--SQL COLUMN INDEX : 1���� ���� 
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

--�������� ���� 
SELECT *
FROM dept
ORDER BY DNAME;

--�������� ����
SELECT *
FROM dept
ORDER BY LOC DESC;

--�� ������ �ִ� ����鸸 ��ȸ, �� ���� �޴� ����� ���� ��ȸ 
--�󿩰� ���� ���, ������� �������� ���� (�󿩰� 0�� ����� �󿩰� ���� ������ ����)
SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm > 0 
ORDER BY comm DESC ,EMPNO;

--�����ڰ� �ִ� ����鸸 ��ȸ �� ���� ������ �������� ����, ������ ���� ��� ����� ū ����� ���� ��ȸ
SELECT *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY job, EMPNO DESC;


