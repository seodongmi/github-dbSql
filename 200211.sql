--�������� Ȯ�ι�� 
--1. tool
--2. dictioary view 
--�������� : USER_CONSTRAINTS 
--�������� �÷� : USER_CONS_COLUMS 
--���������� ��� �÷��� ���õǾ� �ִ��� �� �� ���� ������ ���̺��� ������ �и��Ͽ� ���� 
--1������

SELECT * 
FROM USER_CONSTRAINTS
WHERE table_name IN('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');
--emp, dept pk , fk ������ �������� ���� 
--2. emp : pk(empno)             
--3.       fk (deptno) - dept.deptno         (fk������ �����ϱ� ���ؼ��� �����ϴ� ������ �÷��� �ε����� �����ؾ��Ѵ�)

--1. dept : pk (deptno)

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY(deptno);
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY(deptno) REFERENCES dept(deptno);

--���̺�, �÷� �ּ� : DICTONARYȮ�� ���� 
--���̺� �ּ� : USER_TAB_COMMENTS 
--�ķ� �ּ�: USER_COL_COMMENTS;
SELECT *
FROM member;

SELECT * 
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

SELECT * 
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

--�ּ� ���� 
--���̺��ּ�:  COMMENT ON TABLE ���̺�� IS '�ּ�'
--�÷��ּ�: COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�;

--emp, dept ���̺� �ּ� �ޱ� 
--emp : ���� 
--dept : �μ� 
  COMMENT ON TABLE emp IS '����';
  COMMENT ON TABLE dept IS '�μ�';

--dept 
--deptno : �μ���ȣ 
--dname : �μ��� 
--loc : �μ���ġ 
--emp
--empno : �����̸� 
--job : ������ 
--mgr : �Ŵ��� �Ի��ȣ 
--hiredate : �Ի����� 
--sal : �޿� 
--comm : ������ 
--deptno : �ҼӺμ���ȣ 

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';
COMMENT ON COLUMN emp.empno IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� �Ի��ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

SELECT * 
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

SELECT * 
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

SELECT * 
FROM USER_TAB_COMMENTS;

SELECT * 
FROM USER_COL_COMMENTS;

SELECT * 
FROM USER_TAB_COMMENTS , USER_COL_COMMENTS 
WHERE USER_TAB_COMMENTS.TABLE_NAME = USER_COL_COMMENTS.TABLE_NAME AND 
      USER_TAB_COMMENTS.TABLE_NAME IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');

--VIEW = QUERY
--TABLE ó�� DBMS�� �̸� �ۼ��� ��ü 
--> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN_LINEVIEN -> �̸��� ���� ������ ��Ȱ�� �Ұ� 
--VIEW�� ���̺��̴�. 

--������ 
--1. ���ȸ��� (Ư�� �÷��� �����ϰ� ������ ����� �����ڿ��� ���� 
--2. INLINE_VIEW�� VIEW�� �����Ͽ� ��Ȱ�� 
--- ���� ���� ���� 

--������� 
--CREATE [OR REPLACE] VIEW ���Ī [(column, colnum2...)] AS 
--SUBQUERY;

--emp���̺��� 8���� �÷��� SAL, COMM�� ������ 6���� �÷��� �����ϴ� v_emp VIEW ���� 
CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--�並 �����ϴ� ������ ���� 
--�ý��� �������� DONGMI�������� VIEW���� ���� �߰� 
GRANT CREATE VIEW TO DongMi;

--���� �ζ��� ��� �ۼ� �� 
SELECT * 
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp);

--view ��ü�� Ȱ�� 
SELECT * 
FROM v_emp;

--���������� view�� ���� ���� �ִ�, 
--emp���̺��� �μ����� ���� ==> dept���̺�� ������ ����ϰ� ���� 
--���ε� ����� view�� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ� �� ���� 

--dname(�μ���), ������ȣ(empno), �����̸�(ename), job(������), hiredate(�Ի�����) 
CREATE OR REPLACE VIEW v_emp_dept AS 
SELECT  dname, empno, job, hiredate, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno; 

SELECT *
FROM emp;

--�ζ��� ��� �ۼ��� 
SELECT  *
FROM( SELECT dname, empno, job, hiredate, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno); 

--viwe Ȱ��� 
SELECT * 
FROM v_emp_dept;

--SMITH ���� ���� �� v_emp_dept view �Ǽ� ��ȭ�� Ȯ�� 
DELETE emp 
WHERE ename = 'SMITH';
--��� ������ ������ �����̱� ������ view�� �����ϴ� ���̺��� �����ϸ� 
--view���� ������ ��ģ�� 

--view�� �������� �����͸� ���� �ʰ� ������ �������� ���� ���� (SQL)�̱� ������ 
--�����ϴ� ���̺��� �����ϸ� view ��ȸ ����� ������ �޴´�

ROLLBACK;

--���� ���� 
--���� ���� ���� 

--SEQUENCE : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü 
--CREATE SEQUENCE ������_�̸� 
--[option....]
--����Ģ : SEQ_���̺�� 

--emp���̺��� ����� ������ ���� 
CREATE SEQUENCE seq_emp;

--������ ���� �Լ� 
--NEXTVAL: ���������� ���� ���� ������ �� ��� 
--CURRVAL: NEXTVAL�� ����ϰ� ���� ���� �о� ���� ���� ��Ȯ�� 
--������ ������ : ROLL BACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´� 
--NEXTVAL�� ���� �� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.

SELECT seq_emp.NEXTVAL
FROM dual;--���������� 1�� �Ѱ��� ��� ������ ���� ���� 

SELECT seq_emp.CURRVAL
FROM dual;

SELECT * 
FROM emp_test;

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'james', 99, '017');

--INDEX;

SELECT ROWid, emp.*
FROM emp;

SELECT * 
FROM emp 
WHERE ROWID = 'AAAE5gAAFAAAACLAAH';

--�ε����� ���� �� empnno ������ ��ȸ�ϴ� ��� 
emp���̺��� pk_emp���������� �����Ͽ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ���� 

ALTER TABLE emp DROP CONSTRAINT pk_emp;

explain plan for
SELECT * 
FROM emp 
WHERE empno = 7782;

SELECT * 
FROM TABLE(dbms_xplan,display);

emp���̺��� empno�÷����� PK������ �����ϰ� ���� SQl�� ���� 
-- PK : UNIQUE + NOT NULL (UNIQUE �ε����� �������ش�) 
--empno �÷����� unique�� �����ȴ� 

--�ε����� SQL�����ϰ� �Ǹ� �ε����� ���� ��, ���� �� ��� �ٸ��� Ȯ�� 

ALTER TABL emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

SELECT ROWID, emp.* 
FROM emp;

SELECT empno, rowid
FROM emp 
ORDER BY empno;

explain plan for
SELECT * 
FROM emp 
WHERE empno = 7782;

SELECT * 
FROM TABLE(dbms_xplan,display);


SELECT * 
FROM emp 
WHERE ename = 'SMITH';

--SELECT ��ȸ Į���� ���̺� ���ٿ� ��ġ�� ���� 
SELECT * FROM emp WHERE empno = 7782
==> 
SELECT empno FROM emp WHERE empno = 7782;

EXPLAIN PLAN FOR 
SELECT empno 
FROM emp 
WHERE empno = 7782;

SELECT * 
FROM TABLE(dbms_xplan.display);

--UNIQUE VS NON_UNIQUE �ε����� ���� Ȯ�� 
--1. pk_emp���� 
--2. empno�÷����� non_unique�ε��� ���� 
--3. ���� ��ȹ Ȯ�� 

ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp (empno);

SELECT * 
FROM emp 
WHERE empno = 7782; 
--
--SELECT * 
--FROM TABLE(dbms_xpl...
--7782�� ���Ա⶧���� ������ �˻� �ʿ�x

--emp���̺� job�÷��� �������� �ϴ� ���ο� non-unique �ε����� ���� 
CREATE INDEX indx_n_emp_02 ON emp(job);

SELECT job, rowid
FROM emp 
ORDER BY JOB;

--���ð����� ���� 
--1. emp ���̺��� ��ü �ϱ� 
--2. idx_n_emp_01(empno) �ε��� Ȱ�� 
--2. idx_n_emp_02(job) �ε��� Ȱ�� -- ���� ���ϴ� �����͸� �� �� �ֱ⶧���� �̰Ż��

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER';

SELECT * 
FROM TABLE(dbms_xplan.display);
