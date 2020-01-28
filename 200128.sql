--ROWNUM: ���ȣ�� ��Ÿ���� �÷�
SELECT ROWNUM, empno,ename
FROM emp
WHERE (deptno = 10 OR deptno = 30) AND sal > 1500 
ORDER BY ename;

--��Ī�� �ִ� ���� �Ϲ��� (rn)

--ROWNUM�� WHERE�������� ��밡�� 
--�����ϴ� ��: ROWNUM = 1, ROWNUM <= 2 --> ROWNUM = 1, ROWNUM <= N
--�������� �ʴ� ��:  ROWNUM = 2, ROWNUM >= 2 -->ROWNUM = N(N�� 1�� �ƴ� ����), ROWNUM >= N(N�� 1�� �ƴ� ����)
--ROWNUM �̹� ���� �����Ϳ��ٰ� ������ �ο� 
-- **������1. ���� ���� ������ ����(ROWNUM�� �ο����� ���� ��)�� ��ȸ�� �� ����
-- **������2. ORDER BY���� SELECT �� ���Ŀ� ���� 
--���뵵 : ����¡ ó��(���������� �� �� �ִ� �Խñ��� ������ ���������� - ���ɻ� ����)
--���̺� �ִ� ��� ���� ��ȸ�ϴ� ���� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�Ѵ�
--����¡ ó�� �� �������: 1����¡ �Ǽ�, ���� ���� (�ұ� �ۼ��ð�)

--emp���̺��� �� row �Ǽ� : 14�� 
--����¡ �� 5���� �����͸� ��ȸ 
--1page = 1~5
--2page = 6~10
--3page = 11~15

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM = 1;

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM >= 2;

--���v�� �����͸� �Է��� ������� 
--SELECT �� ORDER BY ���� 
--������ �����ϸ鼭 ������ �� ������?
SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;

--���ĵ� ����� ROWNUM�� �ο��ϱ� ���ؼ��� IN LIKE VIEW�� ����Ѵ�
--�������� : 1. ���� 2. ROWNUM �ο� 
--IN LIKE VIEW = ��ȸ��, ��Ī�ο� 

--SELECT���� *�� ����� ���, �ٸ� EXPRESSION�� ǥ���ϱ� ���ؼ� 
--���̺��.* ���̺� ��Ī.*���� ����ؾ��Ѵ�. 
SELECT ROWNUM, *
FROM emp;

--���̺��.* , ��Ī ��� 
SELECT ROWNUM, e.*
FROM emp e;

--N�̻��� �Ѿ�� ���� �ȵ�  IN LIKE VIEW��ø��� 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn = 2;

-- ROWNUM > rnó�� ���� 
--*page size : 5 , ���ı����� ename
--1page = rn 1~5
--2page = rn 6~10
--3page = rn 11~15
--����¡ ó�� 
--n page : rn (page-1)*pageSize + 1 ~ page * pageSize

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn >= 1 AND rn <= 5;

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN 6 AND 10;

--����ȭ �� ��� 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN (1-1)*5 AND 1*5;

--BEETWEEN�� 1�� ���� �о��� �� ���� 

--����1) ROWNUM�� ���� 1~10���� ��ȸ�ϴ� ���� �ۼ� (����x)
--empno,ename, rn�� ����� ��ȸ�� �� 

-- ���� (���Ұ�) 
SELECT ROWNUM rn, empno, ename 
FROM emp
WHERE rn BETWEEN 1 AND 10;

--��
SELECT ROWNUM rn, empno, ename 
FROM emp
WHERE ROWNUM<= 10;

SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename 
FROM emp)
WHERE rn<= 10;

--����2
SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename 
FROM emp)
WHERE rn BETWEEN 11 AND 20;

--����3
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename
    ) a )
WHERE rn BETWEEN 11 AND 14;
--���̺� �̸��� ���� ������ ���̺� ���� ��Ī�� �ξ�� �� 
--�ѹ� �� ���ξ� SELECT ROWNUM rn ��� ���� 

SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN 11  AND 14;

--�Ϲ�ȭ 
SELECT * 
FROM 
(SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename) a )
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page * :pageSize;

--�Լ� 
--�������� �������� �۾�, �������� �������� �۾��ϴ� ����� ���� 
--character : �ҹ���, �빮��, �ձ��ڸ� �빮�� �ޱ��� ��� �ҹ��� 
--trim: ���ڿ��� �����ؼ� ���� (���̳� �ڿ� ������ ������ �װ��� ���� ����)
--REPLACE: ��ü (����� �Ǵ� ���ڿ�, �ٲ� ���ڿ��� ���ڿ��� �ڹٲ���) 
--LPAD, RPAD: ����, �����ʿ� ���ڿ� ���� 
--INSTR: ���ڿ��� Ư�� ���� ����ִ��� 

--DUAL table : �����Ϳ� �������, �Լ��� �׽�Ʈ �غ� �������� ���
--�÷� �ϳ��� �����ϸ� ���� X �̸� �����ʹ� �� �ڸ� ���� 

--���ڿ� ��ҹ��� : LOWER, UPPER, SELECT * SELECT * 
SELECT   LOWER('Hello, World!'), UPPER('Hello, World!'), INITCAP('Hello, World!')  
FROM dual;
--FROM emp �� �Ѵٸ�? ����� emp���̺��� �� �� ��ŭ ���´� 
SELECT   LOWER(ename), UPPER(ename), INITCAP(ename)  
FROM emp;

--�Լ��� Where������ ��� ���� 
--����̸��� SMITH�� ����� ��ȸ 
SELECT * 
FROM emp
WHERE ename = :ename;
--�ҹ��� ���X 

SELECT * 
FROM emp
WHERE ename =  LOWER(:ename);

--SQL�ۼ� �� �Ʒ� ���´� �����ؾ� �Ѵ�. 
--�º��� �������� ���� -> �ε����� ������� ���ϱ� ������  
--table�� �÷��� �������� �ʴ� ���·� SQL�� �ۼ��Ѵ�. 
--�߸��� SQL�� 
SELECT * 
FROM emp
WHERE LOWER(ename) = :ename;

--���ڿ� ���� 
SELECT CONCAT('Hello', 'world')
FROM dual;

--�ڹ�: 0,5 0-4������ �������� 
--SQL: 1,5 1-5������ �������� 
SELECT CONCAT('Hello', ', world') CONCAT,
       SUBSTR('Hello, World', 1, 5) sub, 
       LENGTH('Hello, World')len,
       INSTR('Hello, World', 'o') ins,
--6�������� �˻� 
       INSTR('Hello, World', 'o', 6) ins2,
--15���ڸ� ���ʿ� *�� �־� ä���� 
       LPAD('Hello, World', 15, '*') LP, 
       RPAD('Hello, World', 15, '*') RP,
       REPLACE('Hello, World', 'H', 'T') REP,
--���ڿ��� �����ؼ� ���� (���̳� �ڿ� ������ ������ �װ��� ���� ����)
       TRIM(' Hello, World '), --������ ���� 
--d��� �ϴ� ���ڿ��� 'Hello, World'�κ��� ���� �ϰڴ�. 
       TRIM('d' FROM 'Hello, World') TR
FROM dual;


SELECT  LENGTH('TEST')
FROM dual;

--�����Լ�
--ROUND : �ݿø� (10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� -> 11)
--TRUNC: ����(����) (10.6�� �Ҽ��� ù��° �ڸ����� ���� -> 10)
--ROUND, TRUNC : ���° �ڸ����� �ݿø�/����
--MOD : ������ (���� �ƴ϶� ������ ������ �� ������ ��) (13/5 -> ��:2 ������:3)

--ROUND(��� ����, ���� ��� �ڸ�)
SELECT ROUND(105.54, 1), --�ݿø� ����� �Ҽ� ù° �ڸ����� �������� --> �ι�° �ڸ����� �ݿø��� �Ѵ�
ROUND(105.55, 1),
ROUND(105.55, 0), --�ݿø� ����� �����θ� --> �Ҽ��� ù��°�ڸ����� �ݿø� 
ROUND(105.55, -1), --�ݿø� ����� ���� �ڸ����� -> ���� �ڸ����� �ݿø� 
ROUND(105.55) --�ι�° ������ �⺻���� 0�� ���� 
FROM dual;

SELECT TRUNC(105.54, 1), --������ ����� �Ҽ��� ù���� �ڸ����� �������� -> �ι�° �ڸ����� ����
     TRUNC(105.55, 1), --�����ϴ� ���̱� ������ ���� ����� ���� 
     TRUNC(105.55, 0), --������ ����� ������(���� �ڸ�)���� �������� -> �Ҽ��� ù��° �ڸ����� ���� 
     TRUNC(105.55, -1), --������ ����� 10�� �ڸ����� �������� --> ���� �ڸ����� ����
     TRUNC(105.55) --�ι�° ������ �⺻���� 0�� ���� 
FROM dual;

--emp���̺��� ����� �޿�(sal)�� 1000���� ������ �� ���� ���غ��� 
SELECT ename, sal, TRUNC(sal/1000) mok
FROM emp;

--������ ���ϱ�
SELECT ename, sal, TRUNC(sal/1000) mok,
        MOD(sal,1000) --mod�� ����� divisor���� �׻� �۴� 0~999���� 
FROM emp;

DESC emp;

--�⺻: �⵵ 2�ڸ�/��2�ڸ�/����2�ڸ�
SELECT ename, hiredate
FROM emp;

--DATA�� ���� ������ (Ʋ�� ��¥�� ��� ���̴��� ���� ���� ����)
--���� -> ȯ�漳�� -> ������ ���̽� -> NLS

--SYSDATE : ���� ����Ŭ ������ �ú��ʰ� ���Ե� ��¥ ������ �������ִ� Ư�� �Լ� 
--�Լ� �����θ����� ���డ�� 

--DATE + ���� = ���ڿ��� 
-- 2020/01/28 + 5 (���ڸ� �������� ��ȭ)
-- 1 = �Ϸ� 
-- 1�ð� = 1/24
--���� ǥ��: ����
--���� ǥ��: �̱� �����̼� + ���ڿ� + �̱� �����̼� ==> '���ڿ�'
--��¥ ǥ�� : TO_DATE('���ڿ��� �� ��¥��', '���ڿ��� �� ��¥ ���� ǥ�� ����)
--         ->TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE + 5
FROM dual;

SELECT SYSDATE + 5, SYSDATE + 1/24
FROM dual;

-- ����) Function (data �ǽ� fn1)





