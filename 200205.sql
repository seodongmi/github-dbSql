--���ȣ, NOT IN 
--dept���̺��� 5���� �����Ͱ� ���� 
--emp���̺��� 14���� ������ �ְ� ������ �ϳ��� �μ��� ���� �ִ�
--�μ��� ������ ���� ���� ���� �μ� ������ ��ȸ 

--������������ �������� ������ �´��� ������ �ϴ� �������� �ۼ� 
SELECT * 
FROM emp;

SELECT * 
FROM dept;

--���ȣ, NOT IN 
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

--GROUP BY�� �̿��� �� 
SELECT deptno
FROM emp
GROUP BY deptno;

--�ӵ� �鿡�� �Ҹ�
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
                        FROM emp
                    GROUP BY deptno);

--DISTINT: ������ �÷��� ���ؼ� �ߺ��� ����
SELECT deptno
FROM emp
GROUP BY deptno;--�� �Ͱ� ������ ȿ�� 

SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno
                     FROM emp);
                     
--5                     
--���� - ���δ�Ʈ ���� - ����Ŭ 
SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1); 

SELECT *
FROM product;

SELECT * 
FROM cycle;

SELECT * 
FROM customer;

--6
SELECT *
FROM cycle
WHERE pid IN (SELECT pid
              FROM cycle
              WHERE cid =2 ) AND cid = 1;

--7
SELECT *
FROM product;

SELECT * 
FROM cycle;

SELECT * 
FROM customer;


SELECT  customer.*, product.* , cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = customer.cid AND product.pid = cycle.pid
                               AND product.pid IN (SELECT cycle.pid
                                                    FROM cycle
                                                    WHERE cycle.cid =2 ) AND customer.cid = 1;
--��Į�󼭺�� �ݺ������� ȣ���ϴ� ���� ���� 
--�����ϴ� ����X

--EXISTS������ 
--�Ŵ����� �����ϴ� ������ ��ȸ (ŷ�� ������ 13���� �����Ͱ� ��ȸ) 
SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

--EXISTS������ 
--EXSTS ���ǿ� �����ϴ� ���� �����ϴ��� Ȯ���ϴ� ������ 
--�ٸ� �����ڿ� �ٸ��� WHERE���� �÷��� ������� �ʴ´� 
WHERE empno - 7369
WHERE EXISTS (SELECT 'x' --������ ���? ���� �� 
              FROM .......);
              
--�Ŵ����� �����ϴ� ������ EXSTS�����ڸ� ���� ��ȸ �Ŵ����� ���� 
SELECT * 
FROM emp e;

SELECT * 
FROM emp e
WHERE EXISTS (SELECT 'X'
               FROM emp m 
               WHERE e.mgr = m.empno);
               
--9
SELECT  pid, pnm
FROM product 
WHERE EXISTS(SELECT 'X'
             FROM cycle 
             WHERE product.pid = cycle.pid AND cid=1 );

--10
SELECT * 
FROM cycle; 


SELECT  pid, pnm
FROM product 
WHERE NOT EXISTS(SELECT 'X'
                   FROM cycle 
                  WHERE product.pid = cycle.pid AND cid=1 );

--���տ��� 
--������ : UNION - �ߺ�����(���հ���) / UNION ALL - �ߺ��� �������� ���� (�ӵ� ���)
--������ : INTERSECT (���հ���) 
--������ : MINUS(���հ���)
--���տ��� ������� 
--�������� �÷��� ����, Ÿ���� ��ġ�ؾ��Ѵ�. 

--������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--union all
--ALL�����ڴ� UNION�����ڿ� �ٸ��� �ߺ��� ����Ѵ� 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--intersect (������) : �� �Ʒ� ���տ��� ���� ���� �ุ ��ȸ 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--mimus(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ���� 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--������ ��� ������ ������ ���� ���տ����� 
-- A UNION B =            B UNION A ==> ����
-- A UNION ALL B =        B UNION ALL A ==> ���� (����)
-- A INTERSECT B =        B INTERSECT A ==> ���� 
-- A MINUS B =            B MINUS A ==> �ٸ� 

--���� ������ Ư¡ 
--���� �̸��� ù��° ������ �÷��� ������ 
SELECT 'X', 'B'
FROM dual

UNION 

SELECT 'Y', 'A'
FROM dual;


--����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ��� 
SELECT deptno, dname, loc 
FROM dept
WHERE deptno IN (10,20) 

UNION

SELECT deptno, dname, loc  
FROM dept
WHERE deptno IN (30,40) 
ORDER BY deptno;

--union all�� �ζ������� ���� ��� 
SELECT *
FROM(SELECT deptno, dname, loc 
FROM dept
WHERE deptno IN (10,20) 
ORDER BY deptno);

UNION ALL

SELECT *
FROM(SELECT deptno, dname, loc 
FROM dept
WHERE deptno IN (30,40) 
ORDER BY deptno);

--�ܹ��� ���� �������� 
SELECT * 
FROM fastfood;

--�õ�, �ñ���, �������� 
--�������� ���� ���� ���ð� ���� �������� ���� 

--������ ����� �������� :
--������ �߱� �������� :
--������ ���� �������� :
--������ ������ �������� : 
--������ ���� �������� : 


--FROM(SELECT sido, sigungu, gb, count(gb) count  
--     FROM fastfood f
--     GROUP BY sido, sigungu, gb)
SELECT *
FROM fastfood;

SELECT sido || sigungu, count(*)
FROM fastfood 
WHERE gb in('�Ե�����')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, round(a.ac/b.bc) 
FROM(SELECT sido, sigungu, count(*) ac
     FROM fastfood 
     WHERE gb in('����ŷ', '�Ƶ�����', '������ġ', '�����̽�', 'KFC')
     GROUP BY sido, sigungu) a , (SELECT sido || sigungu, count(*) bc
                                   FROM fastfood 
                                   WHERE gb in('�Ե�����')
                                   GROUP BY sido, sigungu) b
WHERE  a.sido = b.sido AND a.sigungu, b.sigungu;                               

--SELECT a.sido, a.sigungu, b.cnt bmk, a.cnt l, ROUND(b.cnt/a.cnt,2) rank
--FROM
--    (SELECT sido, sigungu, count(*) cnt
--    FROM fastfood
--    WHERE gb='�Ե�����'
--    GROUP BY sido, sigungu) a, (SELECT sido, sigungu, count(*) cnt
--                                 FROM fastfood
--                                 WHERE gb in('����ŷ','�Ƶ�����','KFC')
--                                 GROUP BY sido, sigungu) b
--WHERE a.sido=b.sido AND a.sigungu = b.sigungu
--ORDER BY rank desc;

--�����ÿ� �ִ� 5���� ���� ���� �ܹ��� ���� 
--(KFC + ����ŷ + �Ƶ�����) / �Ե�����;
SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%����%'
GROUP BY sido;

--����(KFC, ��Ŀŷ, �Ƶ�����) 
SELECT sido, sigungu, count(*) 
FROM fastfood
WHERE sido = '���� ������'
AND gb IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu;

SELECT sido, sigungu, count(*) 
FROM fastfood
WHERE sido = '���� ������'
AND gb IN ('�Ե�����')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM(SELECT sido, sigungu, count(*) c1
FROM fastfood
WHERE /*sido = '���� ������'
AND*/ gb IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu) a , (SELECT sido, sigungu, count(*) c2
                            FROM fastfood
                            WHERE /*sido = '���� ������'
                            AND*/ gb IN ('�Ե�����')
                            GROUP BY sido, sigungu) b
WHERE a.sido = b.sido AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--fastfood���̺��� �ѹ��� �д� ������� �ۼ��ϱ�
SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'KFC', 1)),0) kfc, 
NVL(SUM(DECODE(gb, '����ŷ', 1)),0) bugger , 
NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0)mac, 
NVL(SUM(DECODE(gb, '�Ե�����',1)),1) lot 
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;

SELECT sido, sigungu, ROUND((kfc+bugger + mac ) / lot,2) burger_score
FROM 
(SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'KFC', 1)),0) kfc, 
NVL(SUM(DECODE(gb, '����ŷ', 1)),0) bugger , 
NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0)mac, 
NVL(SUM(DECODE(gb, '�Ե�����',1)),1) lot 
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;
--�ܹ��� ���� �õ�, �ܹ��� ���� �ñ���,          ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ�� 
--  ���� Ư���� �߱� 5.67        ����Ư����	������	70   --1������ ���� 
--  ���� Ư���� ������ 5          ����Ư����	���ʱ�	69  
--  ��⵵ ������    5           ����Ư����	��걸	57
--  ��⵵	��õ��	54
--  ����Ư����	���α�	47
--�ܹ��� ����, ���κ� �ٷ� �ҵ� �ݾ� ������ ���� �õ����� (����)
--����, ���κ� �ٷμҵ� �ݾ����� ���� �� ROWNUM�� ���� ���� �ο�
--���� ������ �ೢ�� ���� 

SELECT ROWNUM nm, hap.*
FROM((SELECT ROWNUM nm1
FROM(SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM(SELECT sido, sigungu, count(*) c1
     FROM fastfood
     WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
     GROUP BY sido, sigungu) a , (SELECT sido, sigungu, count(*) c2
                                  FROM fastfood
                                  WHERE gb IN ('�Ե�����')
                                  GROUP BY sido, sigungu) b)
    WHERE a.sido = b.sido AND a.sigungu = b.sigungu
    ORDER BY hambuger_score DESC) hambugerTable ,  (SELECT ROWNUM nm2
                                                     FROM(SELECT sido, sigungu, ROUND(sal/people) pri_sal
                                                          FROM tax
                                                          ORDER BY pri_sal DESC)) taxTable)) hap
    WHERE hambugerTable.nm1 = taxTable.nm2;
    

