
--1. PRIMARY KEY �������� ������ ����Ŭ dbms�� �ش��÷����� UNIQUE INDEX�� �ڵ����� �����Ѵ� 
-- *** ��Ȯ���� UNIQUE���࿡ ���� UNIQUE�ε����� �ڵ����� �����ȴ� 
-- PRIMARY KEY = UNIQUE + NOT NULL***
--INDEX : �ش� �÷����� �̸� ������ �س��� ��ü 
--������ �Ǿ��ֱ⶧���� ã���� �ϴ� ���� �����ϴ��� ������ �� ���� �ִ�. 
--���࿡ �ε����� ���ٸ� ���ο� �����͸� �Է��� �� �ߺ��Ǵ� ���� ã�� ���ؼ� 
--�־��� ��� ���̺��� ��� �����͸� ã�ƾ��Ѵ� 
--������ �ε����� ������ �̹� ������ �Ǿ��ֱ⶧���� �ش� ���� ���� ������ ������ �� �� �ִ�

--2. FOREIGN KEY �������ǵ� 
--�����ϴ� ���̺� ���� �ִ����� Ȯ�� �ؾ��Ѵ�. 
--�׷��� �����ϴ� �÷��� �ε����� �־������ FOGEIG KEY�� ������ ���� �ִ� 

--FOREIGN KEY ������ �ɼ� 
--FOREIGN KEY(���� ���Ἲ) : �����ϴ� ���̺��� �÷��� �����ϴ� ���� �Էµ� �� �ֵ��� ���� 
--(EX) emp���̺� ���ο� �����͸� �Է½� deptno�÷����� dept���̺� �����ϴ� �μ���ȣ�� �Էµ� �� �ִ�. 

--FORIGN KEY�� �����ʿ� ���� �����͸� ������ �� ������ 
-- � ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵ� 
--ex) emp.deptno => dept.deptno �÷��� �����ϰ� ���� ��
--   �μ� ���̺��� �����͸� ������ �� ���� 

CREATE TABLE dept_test(
deptno NUMBER(2),
dname VARCHAR2(10),
loc VARCHAR2(10),

CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);

CREATE TABLE emp_test(
deptno NUMBER(2),
ename VARCHAR2(10),
empno NUMBER(4),

CONSTRAINT PK_emp_test PRIMARY KEY(empno),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno)
);

DROP TABLE dept_test;
DROP TABLE emp_test;

SELECT * 
FROM emp_test;

SELECT * 
FROM dept_test;

SELECT * 
FROM dept;

INSERT INTO dept_test VALUES (99, 'ddit', '����');
INSERT INTO dept_test VALUES (98, 'ddit', '����');
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);
INSERT INTO emp_test (empno, ename, deptno) VALUES (9998, 'sally', 90);
--emp : 9999 99 
--dept : 98 99 
--> 98�� �μ��� �����ϴ� emp���̺��� �����ʹ� ���� 
--> 99�� �μ��� �����ϴ� emp���̺��� �����ʹ� 9999�� brown ����� ���� 

--���࿡ ���� ������ �����ϰ� �Ǹ� 
DELETE dept_test
WHERE deptno = 99; --����

--emp���̺��� �����ϴ� �����Ͱ� ���� 98�� �μ��� �����ϸ�? -- ���� 
DELETE dept_test
WHERE deptno = 98; -- ���� 

--FOREIGN KEY�ɼ� 
--1. ON DELETE CASCADE : �����ϴ� �����Ͱ� ������ ��� (�θ� ������ ��� - dept) �����ϴ� �ڽ� �����͵� ���� �����Ѵ�(emp) 
--2. ON DELETE SET NULL : �θ� ������ ���(dept) �����ϴ� �ڽ� �������� �÷��� NULL�� �����Ѵ� 

--emp_test���̺��� drop�� �ɼ��� ������ ���鼭 ���� �� ���� �׽�Ʈ 
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR2(10),
deptno NUMBER(2),

CONSTRAINT PK_emp_test PRIMARY KEY(empno),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno) ON DELETE CASCADE
);

INSERT INTO emp_test VALUES (9999, 'brown', 99);
commit;
--emp���̺��� deptno�÷��� dept���̺��� deptno �÷��� ����(ON DELETE CACADE)
--�ɼǿ� ���� �θ����̺�(dept_test)���� �� �����ϰ� �ִ� �ڽ� �����͵� ���� ���� �ȴ� 

DELETE dept_test
WHERE deptno = 90;
-- �ɼ��� �ο����� �ʾ��� ���� ���� DERETE ������ ���� �߻� 
-- �ɼǿ� ���� �����ϴ� �ڽ� ���̺��� �����Ͱ� ���������� ���� �Ǿ����� SELECT Ȯ�� 

SELECT * 
FROM emp_test;

--FK ON DELETE SET NULL �ɼ� �׽�Ʈ 
--�θ� ���̺��� ������ ������ (dept_test) �ڽ����̺��� �����ϴ� �����͸� NULL�� ������Ʈ
ROLLBACK;

DROP TABLE emp_test;

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR2(10),
deptno NUMBER(2),

CONSTRAINT PK_emp_test PRIMARY KEY(empno),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno) ON DELETE SET NULL
);

INSERT INTO emp_test VALUES (9999, 'brown', 99);

--dept���̺��� 99�� �μ��� �����ϸ� (�θ� ���̺��� �����ϸ�) 
--99�� �μ��� �����ϴ� emp_test���̺��� 9999�� (brown)�������� deptno�÷��� 
--fk �ɼǿ� ���� NULL�� �ٲ�� 

delete dept_test
WHERE deptno = 99;
--�θ� ���̺��� ���̺� ���� �� �ڽ� ���̺��� �����Ͱ� NUILL�� ����Ǿ����� Ȯ�� 

SELECT * 
FROM emp_test;

--CHECK �������� : �÷��� ���� ���� ������ ���� �� �� ��� 
--ex) �޿� Į���� ����ȣ ����, �޿��� ������ �� �� ������? 
--�Ϲ����� ��� �޿����� > 0 
--CHECK ������ ����� ��� �޿����� 0���� ū ���� �˻� ���� 
--emp���̺��� job�÷��� ���� ���� ���� 4������ ���� ���� 
--'SALESMAN' , "PRESIDENT' , 'ANALYSY', 'MANAGER'

--���̺� ������ �÷� ����� �Բ� Check���� ���� 
--emp_test ���̺��� sal �÷��� 0���� ũ�ٴ� check�������� ���� 

DROP TABLE emp_test;

CREATE TABLE emp_test(
 empno NUMBER(4),
 ename VARCHAR2(10),
 deptno NUMBER(2),
 sal NUMBER CHECK (sal>0),
 
 CONSTRAINT pk_emp_test PRIMARY KEY(empno),
 CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno)
 );
 
 INSERT INTO emp_test VALUES(9999, 'brown', 99, 1000);
 INSERT INTO emp_test VALUES(9998, 'sally', 99, -1000); --üũ ���ǿ� ���� 0���� ū ���� �Է°���
 
-- ���ο� ���̺� ���� 
-- CREATE TABLE ���̺��(
--  �÷�1....
--  );
-- CREATE TABLE ���̺�� AS
-- SELECT ����� ���ο� ���̺�� ���� 

--emp���̺��� �̿��ؼ� �μ���ȣ�� 10���� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ� 
--emp_test2 ���̺��� ���� 

CREATE TABLE emp_test2 AS
SELECT * 
FROM emp 
WHERE deptno = 10;

SELECT * 
FROM emp_test2;
--NOT NULL �������� �̿��� ���������� ������� �ʴ´� 
--���� �� ������ ���, �׽�Ʈ ���� 

--TABLE ����
--1. �÷��߰� 
--2. �÷� ������ ����, Ÿ�� ���� 
--3. �⺻�� ���� 
--4. �÷����� RENAME
--5. �÷��� ���� 
--6. ���������� �߰�/����

--TABLE ���� : 1. �÷� �߰� 
DROP table emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno),
     CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno)
     );
     
-- ALTER TABLE ���̺�� ADD [�ű��÷��� �ű��÷� Ÿ��);

ALTER TABLE emp_test ADD ( hp VARCHAR2(20));

DESC emp_test;

SELECT * 
FROM emp_test;

--TABLE ���� : 1. �÷� �������, Ÿ�Ժ��� -- �� �Ⱦ�
-- ex) �÷�  VARCHAR2(20) --> VARCHAR2(5)
--    ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� �ſ� ����
--�Ϲ������� �����Ͱ� �������� �ʴ� ���� �� ���̺��� ������ ������ �÷� ������, Ÿ���� �߸� �� ��� 
--�÷� ������, Ÿ���� ������ 
-- �����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ������ (������ �ø��� �͸� ����)

DESC emp_test;
--hp VARCHAR2(20) --> hp VARCHAR2(30)
--
--ALTER TABLE ���̺�� MODIFY (���� �÷��� �ű� �÷� Ÿ��(������));

ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));
DESC emp_test;

--hp VARCHAR2(20) --> hp NUMBER
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

--�÷� �⺻�� ���� 
--ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);

--hp  hp NUMBER --> VARCHAR2(20) DEFAULT '010'
ALTER TABLE emp_test MODIFY (hp VARCHAR2(20) DEFAULT '010');
DESC emp_test;

--hp�÷����� ���� ���� �ʾ����� default ������ ���� 010 ���ڿ��� �⺻������ ����ȴ�. 
INSERT INTO emp_test(empno, ename, deptno) VALUES (9999, 'borwn' , 99);

SELECT * 
FROM emp_test;

--TABLE ���� : 1. ����� �÷� ���� 
--�����Ϸ��� �ϴ� �÷��� FK����, PK������ �־ ��� ���� 
--ALTER TABLE ���̺�� RENAME ���� �÷��� TO �ű� �÷���;
--
--hp -> hp_n
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

--���̺� ���� : 5. �÷����� 
--ALTER TABLE ���̺�� DROP COLUM �÷��� 
--emp_test ���̺��� hp_h �÷� ����;

--emp_test�� hp_n �÷��� �ִ� ���� Ȯ�� 
SELECT * 
FROM emp_test;


--emp_test ���̺��� hp_h �÷� ����;
ALTER TABLE emp_test DROP COLUMN hp_n;

--1. emp_test���̺��� drop�� ������ empno, ename, deptno, hp 4���� �÷����� ���̺� ���� 
--2. empno, ename, deptno 3���� �÷����� (999, 'brown', 99) �����ͷ� INSERT
--3. emp_test���̺��� hp�÷��� �⺻���� '010'���� ���� 
--5. 2�� ������ �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ�� 
-- ��) ���� �ٲ��� �ʴ´�. ���� �Ŀ��� ������ �� ���� ������ ���� �ʴ´�

--TABLE ���� 6. �������� �߰�/����
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������Ÿ��(PRIMARY KEY, FOREIGN KEY) (�ش� Į��) 
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

--emp_test ���̺� ���� �� 
--�������� ���� ���̺� ���� 
--PRIMARY KEY, FOGEIGN ������ ALTER TABLE������ ���� ���� 
--�ΰ��� �������ǿ� ���� �׽�Ʈ 
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

PRIMARY KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9999, 'brown' ,99);
INSERT INTO emp_test VALUES (9999, 'sally' ,99); --ù��° INSERT������ �ߺ��ǹǷ� ����

SELECT *
FROM dept_test;

FOREIGN KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9998, 'sally' ,97); --dept_test���̺� �������� �ʴ� �μ���ȣ �̹Ƿ� ����

--�������� ���� : PRIMARY KEY, FOREOGN KEY
--ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;

--���������� �����Ƿ� empno�� �ߺ��� ���� �� ���� �ְ� dept_test���̺��� �������� ���� deptno���� �� �� �ִ�

--�ߺ��� empno������ ������ �Է� 
INSERT INTO emp_test VALUES (9999, 'brown', 99);
INSERT INTO emp_test VALUES (9999, 'sally', 99);

--�������� �ʴ� 98�� �μ��� ������ �Է� 
INSERT INTO emp_test VALUES (9999, 'sally', 98);

--�������� Ȱ��ȭ / ��Ȱ��ȭ 
ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

--1. emp_test ���̺� ���� 
--2. emp_test ���̺� ���� 
--3. ATER TABLE PRIMARY KEY(empno), FOREIGN KEY(dept_test.deptno) 
--4. �ΰ��� ���������� ��Ȱ��ȭ 
--5. ��Ȱ��ȭ�� �Ǿ����� INSERT�� ���� Ȯ�� 
--6. ���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ 

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);


ALTER TABLE emp_test DISABLE CONSTRAINT pk_emp_test; -- �ߺ��� �� �� �� �ִ�
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

INSERT INTO emp_test VALUES (9999, 'brown', 99);
INSERT INTO emp_test VALUES (9999, 'brown', 98); 

-- emp_test���̺��� empno�÷��� ���� 9999�� ����� �θ� �����ϱ� ������ 
---FRIMARY LEY ���������� Ȱ��ȭ �� ���� ���� 
--> empnoĮ���� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ ��ų �� �ִ� 
ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test; -- �ߺ��� �� �� �� �ִ�
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


dept_test���̺� �������� �ʴ� �μ���ȣ 98�� emp_test���� ����� 
1. dept_test���̺� 98�� �μ� ����ϰų�
2. sally�� �μ���ȣ�� 99������ �����ϰų� 
3. selly�� ����ų� 

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;
UPDATE emp_test SET deptno = 99;
WHERE ename = 'sally';

FRO<ARY KEY �������� Ȱ��ȭ 
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;
COMMIT;

--HW :  �н����� ����
--DEFAULT ���� ����
--1. emp_test ���̺��� drop�� empno, ename, deptno, hp 4���� �÷����� ���̺� ����
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(20));
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
 
--2. empno, ename, deptno 3���� �÷����� (9999, 'brown', 99) �����ͷ� INSERT
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);

--3. emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');
DESC emp_test;

--4. 2�������� �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ��
SELECT * 
FROM emp_test;

--SQLȰ�� PART2 pt43