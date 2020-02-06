--ROWNUM ���� ���� 
--1. SELECT == > ORDER BY 
--���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE_VIEW 
--2. 1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE������ ����� ���� 
--     ROWNUM = 1 (o)
--     ROWNUM = 2 (x)
--     ROWNUM <10 (o)
--     ROWNUM > 10 (x)

--ROWNUM - ORDERBY 
--ROUND
--GROUP BY SUM 
--JOIN
--DECODE
--NVN
--IN

SELECT b.sido, b.sigungu, 
FROM(SELECT ROWNUM rn1, a.*  
FROM(SELECT sido, sigungu, count(*) c1
     FROM fastfood
     WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
     GROUP BY sido, sigungu) a) A,       
(SELECT ROWNUM rn2, b.*     
FROM(SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC) b) B
WHERE a.rn1 = b.rn2

--������ �� 

--ROWNUM - ORDER BY
--ROUND
--GROUP BY SUM
--JOIN
--DECODE
--NVL
--IN
--
--SELECT b.sido, b.sigungu, b.burger_score, a.sido, a.sigungu, a.pri_sal
--FROM 
--(SELECT ROWNUM rn, a.*
--FROM 
--(SELECT sido, sigungu, ROUND(sal/people) pri_sal
-- FROM tax
-- ORDER BY pri_sal DESC) a) a,
--
--(SELECT ROWNUM rn, b.*
--FROM
--(SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot, 2) burger_score
--FROM 
--(SELECT sido, sigungu, 
--       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)), 0) BURGERKING,
--       NVL(SUM(DECODE(gb, '�Ƶ�����', 1)), 0) mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)), 1) lot       
--FROM fastfood
--WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
--GROUP BY sido, sigungu)
--ORDER BY burger_score DESC) b ) b
--WHERE a.rn = b.rn;

--empno�÷��� NOT NULL���� ������ �ִ� - INSERT�� �ݵ�� ���� �����ؾ� ���������� �Էµȴ� 
--empno�÷��� ������ ������ Į���� NULLABLE�̴� (NULL���� ����� �� �ִ�)
INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', NULL);

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN');

--���ڿ� : '���ڿ�' 
--���� :  10 
--��¥ : TO_DATE('20200206', 'YYYYMMDD')

--emp���̺��� hiredate �÷��� dateŸ�� 
--emp���̺��� 8���� �÷��� ���� �Է� 
--emp() <- �� �ڵ����� �Է��� �� �÷� ������� ��� 
INSERT INTO emp VALUES(9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99);

--Ʈ����� Ȯ�� 
ROLLBACK;

--�������� �����͸� �ѹ��� INSERT : 
--INSERT INTO ���̺�� (�÷���1, �÷���2...)
--SELECT 
--FROM 

INSERT INTO emp 
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99
FROM dual

UNION ALL 

SELECT 9999, 'brown' , 'CLEERK' , NULL, TO_DATE('20200205','YYYYMMDD'), 1100, NULL, 99 
FROM dual;

--UPDATE ���� 
--UPDATE ���̺�� �÷��� = ������ �÷� ��1, �÷���2 = ������ �÷� ��2,.....
--WHERE �� ���� ���� 
--������Ʈ ���� �ۼ��� WHERE���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��.
--UPDATE, DELECT���� WHERE���� ������ �ǵ��� ���� �´��� �ٽ� �ѹ� Ȯ���Ѵ�. 

--WHERE���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT�ϴ� ������ �ۼ��Ͽ� �����ϸ� 
--UPDATE ��� ���� ��ȸ�� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ� 

--99�μ���ȣ�� ���� �μ� ������ DEPT ���̺� �ִ� ��Ȳ 
--UINSERT IN dept VALES (99, 'ddit', 'daejeon');
--COMMIT;

--99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '��� IT', LOC���� '���κ���'���� ������Ʈ


UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM DEPT
WHERE deptno = 99;

--Ŀ���� ���� ���߱⶧���� �߸��� ���� �����ϸ� �ѹ��� �� �� 

--�Ǽ��� WHERE���� ������� �ʾ������ 
UPDATE dept SET dname = '���IT', loc = '���κ���';
ROLLBACK

--����� - �ý��� ��ȣ�� �ؾ���� -> �Ѵ޿� �ѹ��� ��� ������� ������� 
--                                 ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ 
--                                  �ý��� �����: �����, ������, ���� 

--�ý��� �����: ����� , ������, ���� 
--UPDATE ����� SET ��й�ȣ = �ֹι�ȣ ���ڸ� 
--WHERE���� ������ϸ� ��� ������Ʈ 

--UPDATE ����� SET ��й�ȣ = �ֹι�ȣ���ڸ� 
--WHERE ����ڱ��� = '�����';
--COMMIT

-- 10 --> SUBQUERY ; 
--SMITH, WORD �� ���� �μ��� �Ҽӵ� ���� ���� 
-- SELECT * 
-- FRPM emp 
-- WHERE deptno IN(20,30)

SELECT * 
FROM emp 
WHERE deptno IN((SELECT deptno
                           FROM emp
                           WHERE ename IN ('SMITH', 'WORD'));
--������Ʈ �ÿ��� �������� ��� ���� 

INSERT INTO emp(empno, ename) VALUES (9999, 'brown');
--9999�� ��� deptno, job������ SMITH����� ���� �μ���ȣ, �������� ������Ʈ 
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job =  (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT * 
FROM emp;

ROLLBACK;

--DELETE SQL : Ư�� ���� ���� 
--DELETE  [FROM] ���̺�� 
--WHERE �� ���� ���� 

SELECT *
FROM dept;

99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ���� 

DELETE dept
WHERE deptno = 99;

COMMIT

--subquery�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE
--�Ŵ����� 7698 ����� ������ �����ϴ� ������ �ۼ� 
DELECT emp 
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

DELETE emp 
WHERE mar = 7698;

DELETE emp 
WHERE empno IN (SELECT empno 
                FROM emp
                WHERE mgr = 7698);

ROLLBACK;

SELECT * 
FROM DBA_DATA_FIFLES:
--Ŀ���� ����

--���α׷����� ���ؿ� ���� 
--���缺 