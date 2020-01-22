SELECT * 
FROM LPROD;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT * 
FROM CART;

SELECT mem_id, mem_pass, mem_name
FROM MEMBER;

--users ���̺� ��ȸ 
SELECT * 
FROM users;

--���̺� � �÷��� �ִ��� Ȯ���ϴ� ��� 
--1. SELECT *
--2. TOOL�� ��� (�����-TABLE  Ŭ�� �� �÷�Ȯ��)
--3. DESC ���̺�� (DESC-DESCRIBE)
DESC users;

--users ���̺��� userid, usernm, rog_dt �÷��� ��ȸ�ϴ� sql�� �ۼ��ϼ���
--��¥ ���� (reg_dt Į���� date������ ���� �� �ִ� Ÿ��)
--SQL ��¥ �÷� + (���ϱ� ����) 
--�������� ��Ģ������ �ƴ� �͵� 
--String h = "hello";
--String w = "world";
--String hw = h+w; --�ڹٿ����� �� ���ڿ��� ����
--SQL���� ���ǵ� ��¥ ����: ��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥�� �ȴ�.
--ex(2019/01/28 + 5 = 2019/02/02)
--reg_dt: ������� �÷�
--NULL: ���� �𸣴� ����
--NULL�� ���� �������� �׻� NULL * 

--reg_dt -> reg_dt_AFTER_5DAY(��Ī) 
--AS�� �ᵵ �Ƚᵵ ���x
SELECT userid, usernm, reg_dt + 5 reg_dt_AFTER_5DAY
FROM users;

SELECT userid, usernm, reg_dt + 5 AS reg_dt_AFTER_5DAY
FROM users;

SELECT userid, usernm, red_dt, reg_dt + 5 reg_dt_AFTER_5DAY
FROM users;

--SELECT ���������� ������ ����
DESC user;

SELECT PROD_ID AS ID, PROD_NAME AS NAME
FROM PROD;

SELECT LPROD_GU AS GU, LPROD_NM AS NM
FROM LPROD;

SELECT BUYER_ID AS ���̾���̵�, BUYER_NAME AS �̸�
FROM BUYER;

--���ڿ� ����
--�ڹٿ����� ���ڿ� ����: + ("hello" + "world") 
--SQL������: || ('Hello || 'world')
--SQL������: concat('Hello' ,'world')

DESC users;

-- userid�� usernm �÷��� ����: ��Ī�� id_name
SELECT userid || usernm  AS id_name, 
       CONCAT(userid, usernm) AS concat_id_name
FROM users;

--����, ���
--int a = 5; String msg = "Hello, world";

--//������ �̿��� ���
--System.out.println(msg);  

--//����� �̿��� ���
--System.out.println("Hello World"); 

--SQL���� ������ ���� 
--(�÷��� ����� ���� pl/sql���� ���� ������ ����)
--SQL������ ���ڿ� ����� �̱� �����̼����� ǥ�� 
--"Hello, world" --> 'Hello, world'

--���ڿ� ����� �÷����� ����
--user id : brown
--user id : cony
SELECT 'user id: ' || userid AS "use rid"
FROM users;

--����Ŭ���� �����ϴ� �⺻ ���̺�
SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables;

--CONCAT(arg1, arg2)
SELECT CONCAT('SELECT * FROM ', CONCAT(table_name, ';')) AS QUERY
FROM user_tables;

--int a = 5; //�ڹٿ����� �Ҵ�, ����
--if(a == 5) (a�� ���� 5���� ��) 
--sql������ ������ ������ ����(PL/SQL)
--sql = --> equal

--���� ��: =
--!=, <> �ٸ���
-->=ũ�ų� ���� ��

--user�� ���̺��� ��� �࿡ ���ؼ� ��ȸ
--users���� 5���� �����Ͱ� ����
SELECT * 
FROM users;

--WEERE ��: ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ 
--ex: userid�÷��� ���� brown�� �ุ ��ȸ 
--brown, 'brown' ����
--�÷�, ���ڿ� ��� 
SELECT * 
FROM users
WHERE userid = 'brown';

--ex: userid�÷��� ���� brown�� �ƴ� �ุ ��ȸ 
--���� ��: =, �ٸ� ��: !=, <>
SELECT * 
FROM users
WHERE userid != 'brown';

--emp ���̺� �����ϴ� �÷��� Ȯ���غ����� - ����Ŭ �⺻ ���� 
--�����ȣ,�̸�,����,����ȣ,�����,�޿�,�μ�Ƽ��, �μ���ȣ
SELECT * 
FROM emp;

--emp���̺��� ename �÷� ���� JONES�� �ุ ��ȸ 
--*SQL Ű����� ��ҹ��ڸ� ������ ������ 
--�÷��� ���̳� ���ڿ� ����� ��ҹ��ڸ� ������
--'JONES', 'Jones'�� ���� �ٸ� ��� 
SELECT * 
FROM emp
WHERE ename = 'JONES';

--������ ���� ���
DESC emp;

--emp ���̺��� deptno(�μ���ȣ)�� 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT * 
FROM emp
WHERE deptno >= 30;

--���ڿ� : '���ڿ�'
--���� : 50
--��¥: �Լ��� ���ڿ��� �����Ͽ� ǥ��. ���ڿ��� �̿��Ͽ� ǥ������(�������� ����)
--�������� ��¥ ǥ���� �ٸ�
--�ѱ�: �⵵�ڸ� 4 �ڸ� ���ڸ� 2 �ڸ� ���� 2 �ڸ� 
--�̱�: ���ڸ� 2 �ڸ� ���� 2 �ڸ� �⵵ 4 �ڸ�
--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ SELECT * 

-- TO_DATE: ���ڿ��� dateŸ������ �����ϴ� �Լ� 
-- TO_DATE(��¥���� ���ڿ�, ù���� ������ ����)
SELECT * 
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-- ��������
-- sal�÷��� ���� 1000���� 2000������ ��� 
--sal >= 1000
--sal <- 2000

SELECT * 
FROM emp
WHERE sal >= 1000 AND sal <= 2000;

--���ǿ����ڸ� �ε�ȣ ��ſ� BETWEEN AND�����ڷ� ��ü 
SELECT * 
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--3���� ���ǵ� ���� 
SELECT * 
FROM emp
WHERE sal >= 1000 AND sal <= 2000 AND deptno = 30;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/1/1', 'YYYY/MM/DD') AND TO_DATE('1983/1/1', 'YYYY/MM/DD');


