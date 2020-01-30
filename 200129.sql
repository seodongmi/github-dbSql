--Function (data �ǽ� fn1)
SELECT TO_DATE('2019/12/31', 'YY-MM-DD') LASTDAY,
TO_DATE('2019/12/31', 'YY-MM-DD') - 5 LASTDAYBEFORE5,
SYSDATE NOW,
SYSDATE - 3 NOW_BEFORE3
FROM dual;


--DATE : TO_DATE ���ڿ� -> ��¥(DATE)
--       TO_CHAR ��¥ -> ���ڿ� (��¥ ���� ����)
--JAVA������ ��¥ ������ ��ҹ��ڸ� ������( MM / mm -> �� , ��)

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS')
FROM dual;

--�ְ�����(1~7) D : �Ͽ��� 1 ,������ 2 ... ����� 7
--���� IW : ISOǥ��  - �ش� ���� ������� �������� ������ ���� 
-- 2019/12/31 (ȭ����) --> 2020/01/02 (�����) -> �׷��� ������ 1������ ���� 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
    TO_CHAR(SYSDATE,'D'),
    TO_CHAR(SYSDATE,'IW'),
    TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'), 'IW')
FROM dual;

--emp ���̺��� hiredate(�Ի�����)�÷��� ����� ��:��:�� 
SELECT ename, hiredate,
TO_CHAR(hiredate, 'YYYY-MM/DD HH24:MI:SS'),--�ú��� �����Ͱ� �� �ȳ�������? �ú��� ������ ���� �ʾұ⋚�� 
TO_CHAR(hiredate + 1, 'YYYY-MM/DD HH24:MI:SS'), 
TO_CHAR(hiredate + 1/24, 'YYYY-MM/DD HH24:MI:SS'),
--hiredate�� 30���� ���Ͽ� TO_CHAR�� ǥ�� 
TO_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM/DD HH24:MI:SS')  
FROM emp;

--Function (data �ǽ� fn2)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME ,
TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--��¥ ����
-- ROUND(DATE, format)
-- TRUNC(DATE, format)

--MONTHS_BETWEEN(DATE,DATE)
--���ڷ� ���� �� ��¥ ������ ���� ���� ���� 
SELECT ename, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate), --�Ի����� ����� ��������(�����߿�)
       MONTHS_BETWEEN(TO_DATE('2020-01-17', 'yyyy-mm-dd'), hiredate), 469/12 --39���� ���� 
FROM emp
WHERE ename='SMITH';

--ADD MONTHS(DATE, ����-������ ���� ��)
SELECT ADD_MONTHS(SYSDATE, 5),  --  2020/01/29 --> 2020/06/29
        ADD_MONTHS(SYSDATE, -5) --  2020/01/29 --> 2019/08/29
FROM dual;

--NEXT_DAY(DATE, �ְ�����), ex) NEXT_DAY(SYSDATE , 5) --> SYSDATE���� ó�� �����ϴ� �ְ����� 5(��)�� �ش��ϴ� ����
--                              SYSDATE 2020/01/29(��) ���� ó�� �����ϴ� 5(��)���� -> 2020/01/30 (��)
                               
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

--LAST DATNEXT(DAY) DATE�� ���� ���� ���ڸ� ���ڸ� ���� 
SELECT LAST_DAY(SYSDATE) --SYSDATE 2020/01/29 --> SYSDATE 2020/01/31
FROM dual;

--LAST_DAY�� ���� ���ڷ� ���� date�� ���� ���� ������ ���ڸ� ���� �� �ִµ�
--date�� ù��° ���ڴ� ��� ���ұ�?
SELECT SYSDATE, 
LAST_DAY(SYSDATE),
TO_DATE('01','DD'),
ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),
TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM dual;

--hiredate���� �̿��Ͽ� �ش� ���� ù��° ���ڷ� ǥ�� 
SELECT ename, hiredate,
ADD_MONTHS(LAST_DAY(hiredate)+1,-1),
TO_DATE(TO_CHAR(hiredate, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM emp;

--����� ����ȯ 
--������ ����ȯ 

--empno�� numberŸ��, ���ڴ� ���ڿ�
--Ÿ���� ���� �ʱ⶧���� ������ ����ȯ�� �Ͼ��
--���̺� �÷��� Ÿ�Կ� �°� �ùٸ� ���� ���� �ִ� ���� �߿� 
SELECT * 
FROM emp
WHERE empno='7369';

-����
SELECT * 
FROM emp
WHERE empno=7369;

--hiredate�� ��� dataŸ��, ���ڴ� ���ڿ��� �־����⶧���� ������ ����ȯ�� �߻�
--��¥ ���ڿ����� ��¥ Ÿ������ ��������� ����ϴ� ���� ����
SELECT * 
FROM emp
WHERE hiredate = '1980/12/17';
--80/12/17 �� �ȵǳ���? ������ YYYY/MM/DD�� �ٲ�⶧�� 

--����
SELECT * 
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

--�����ȹ
--�ܰ�1
EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE empno='7369';

--�ܰ�2
SELECT * 
FROM table(dbms_xplan.display);

--Id  | Operation         | Name  -->  �߿�
--������ �Ʒ��� �д� �� 
--���Ⱑ �Ǿ������� �ڽ��̶�� �� �ڽĺ��� ���� 
--emp��� �ϴ� ���̺��� �����͸� �� �д´�
--1 - filter("EMPNO"=7369) --> filter�� �Ÿ�
-- �ڵ������� ����ȯ 

EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE TO_CHAR(empno)='7369';

SELECT * 
FROM table(dbms_xplan.display);
-- 1 - filter(TO_CHAR("EMPNO")='7369') 

--���ڸ� ���ڿ��� �����ϴ� ��� : ����
--õ���� ������
--1000�̶�� ���ڸ� 
--�ѱ�: 1,000.50
--���� : 1.000,50

--emp���̺� �ִ� sal�÷�(NumberŸ��)�� ������
--9 : ����
--0 : ���� �ڸ� ����(0���� ǥ��)
--L : ��ȭ����
SELECT ename, sal, TO_CHAR(sal, 'L0,999')
FROM emp;

--����ȭ 

--�� �Լ� 

--NULL�� ���� ������ ����� �׻� NULL
--emp ���̺��� sal�÷����� null�����Ͱ� �������� ���� (14���� �����Ϳ� ����)
---emp ���̺��� comm�÷����� null�����Ͱ� �������� ���� (14���� �����Ϳ� ����)
--sal + comm -> comm�� null�� �࿡ ���ؼ��� ��� null�� ���´� 
SELECT ename, sal, comm, sal+comm
FROM emp;

--�䱸������ comm�� null�̸� sal�÷��� ���� ��ȸ 
--�䱸������ ���� ��Ű�� ���Ѵ� -> SW������ ���� 

--NVL(Ÿ��, ��ü��)
--Ÿ���� ���� NULL�̸� ��ü���� ��ȯ�ϰ� 
--Ÿ���� ���� NULL�� �ƴϸ� Ÿ�� ���� ��ȯ 
--if(Ÿ�� == null)
--retrun ��ü��;
--else
--   return Ÿ��;

SELECT ename, sal, comm, NVL(comm, 0), 
sal+NVL(comm,0),
NVL(sal+comm, 0)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(ecpr1 != null)
--return expr2
--else
--return expr3

SELECT ename, sal, comm, NVL2(comm, 10000, 0 ), --���� �ƴϸ� 10000�ο�  
sal+NVL(comm,0),
NVL(sal+comm, 0)
FROM emp;

--NULLIF(expr1, expr2)
--if(expr1 == expr2)
--return null;
--else
--return expr1;

SELECT ename, sal, comm, NULLIF(sal, 1250) --sal�� 1250�� ����� null�� ����, 1250�� �ƴ� ����� sal�� ����
FROM emp;

--�������� 
--COALESCE(expr1, expr2...) ���� �߿� ���� ó������ �����ϴ� 
--NULL�� �ƴ� ���ڸ� ��ȯ
--if(expr1 != null)
--return expr1;
--else
--return COALESCE(expr2, expr3...);

--COALESCE(comm, sal) : comm�� null�� �ƴϸ� comm
--                      comm�� null�̸� sal (��, sal�÷� ���� NULL�� �ƴ� ��)


SELECT ename,sal,comm, 
    COALESCE(comm, sal) coalesce_comm_sal 
FROM emp; 


--fn4
SELECT EMPNO, ENAME, MGR, 
NVL(mgr, 9999) mgr_n,
NVL2(mgr, mgr, 9999), 
coalesce(mgr, 9999) 
FROM emp;

--fn5
SELECT USERID, USERNM, REG_DT, NVL(REG_DT,SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

--CONDITION: ������ 
--CASE : JAVA�� if-else if-else
--CASE 
-- WHEN ���� THEN ���ϰ�1
-- WHEN ����2 THEN ���ϰ�2
-- ELSE �⺻��
-- END

--emp ���̺��� kob�÷� ���� SALESMAL SAL*1.05���� 
--                          MANAGER�̸�  SAL * 1.1����
--                          KING�̸� SAL * 1.2����
--                          �� ���� ������� SAL�� ���� 

SELECT ename, job, sal
       ,CASE
          WHEN job = 'SALESMAN' THEN sal * 1.05
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
        END BONUS
FROM emp;

--DECODE�Լ� :CASE���� ���� 
--(�ٸ��� CASE���� WHEN���� ���Ǻ񱳰� �����ο 
--        DECODE �Լ��� �ϳ��� ���� ���ؼ� = �񱳸� ���
-- DECODE�Լ�: ��������(������ ������ ��Ȳ�� ���� �þ ���� ����)
-- DECODE(col | expr, ù��° ���ڿ� ���� ��1, �ι�° ���ڰ� ���� ��� ��ȯ �� ��, 
--                    ù��° ���ڿ� ���� ��2, ù��° ���ڿ� �׹�° ���ڰ� ���� ��� ��ȯ �� ��...,
--                    option - else ���������� ��ȯ�� �⺻��)

SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) BONUS
FROM emp;


--emp ���̺��� kob�÷� ���� SALESMAN�̸鼭 sal�� 1400���� ũ�� SAL*1.05���� 
--                         SALESMAN�̸鼭 sal�� 1400���� ������ SAL*1.1���� 
--                          MANAGER�̸�  SAL * 1.1����
--                          KING�̸� SAL * 1.2����
--                          �� ���� ������� SAL�� ���� 

SELECT ename, job, sal
       ,CASE
          WHEN job = 'SALESMAN' AND sal>1400 THEN sal * 1.05
         WHEN job = 'SALESMAN' AND sal<1400 THEN sal * 1.1
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
        END BONUS
FROM emp;

SELECT ename, job, sal,
        DECODE(job, 'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2
           ,CASE
            WHEN job = 'SALESMAN' AND sal>1400 THEN sal * 1.05
            WHEN job = 'SALESMAN' AND sal<1400 THEN sal * 1.1
            ELSE sal
            END 
           ) BONUS
FROM emp;

