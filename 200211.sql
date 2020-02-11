--제약조건 확인방법 
--1. tool
--2. dictioary view 
--제약조건 : USER_CONSTRAINTS 
--제약조건 컬럼 : USER_CONS_COLUMS 
--제약조건이 몇개의 컬럼에 관련되어 있는지 알 수 없기 때문에 테이블을 별도로 분리하여 설계 
--1정규형

SELECT * 
FROM USER_CONSTRAINTS
WHERE table_name IN('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');
--emp, dept pk , fk 제약이 존재하지 않음 
--2. emp : pk(empno)             
--3.       fk (deptno) - dept.deptno         (fk제약을 생성하기 위해서는 참조하는 테이터 컬럼에 인덱스가 존재해야한다)

--1. dept : pk (deptno)

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY(deptno);
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY(deptno) REFERENCES dept(deptno);

--데이블, 컬럼 주석 : DICTONARY확인 가능 
--테이블 주석 : USER_TAB_COMMENTS 
--컴럼 주석: USER_COL_COMMENTS;
SELECT *
FROM member;

SELECT * 
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

SELECT * 
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

--주석 생성 
--테이블주석:  COMMENT ON TABLE 테이블명 IS '주석'
--컬럼주석: COMMENT ON COLUMN 테이블.컬럼 IS '주석;

--emp, dept 테이블 주석 달기 
--emp : 직원 
--dept : 부서 
  COMMENT ON TABLE emp IS '직원';
  COMMENT ON TABLE dept IS '부서';

--dept 
--deptno : 부서번호 
--dname : 부서명 
--loc : 부서위치 
--emp
--empno : 직원이름 
--job : 담당엄무 
--mgr : 매니저 입사번호 
--hiredate : 입사일자 
--sal : 급여 
--comm : 성과금 
--deptno : 소속부서번호 

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치';
COMMENT ON COLUMN emp.empno IS '직원이름';
COMMENT ON COLUMN emp.job IS '담당엄무';
COMMENT ON COLUMN emp.mgr IS '매니저 입사번호';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '성과금';
COMMENT ON COLUMN emp.deptno IS '소속부서번호';

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
--TABLE 처럼 DBMS에 미리 작성한 객체 
--> 작성하지 않고 QUERY에서 바로 작성한 VIEW : IN_LINEVIEN -> 이름이 없기 때문에 재활용 불가 
--VIEW는 테이블이다. 

--사용목적 
--1. 보안목적 (특정 컬럼을 제외하고 나머지 결과만 개발자에게 제공 
--2. INLINE_VIEW를 VIEW로 생성하여 재활용 
--- 쿼리 길이 단축 

--생성방법 
--CREATE [OR REPLACE] VIEW 뷰명칭 [(column, colnum2...)] AS 
--SUBQUERY;

--emp테이블에서 8개의 컬럼중 SAL, COMM을 제외한 6개의 컬럼을 제공하는 v_emp VIEW 생성 
CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--뷰를 생성하는 권한이 없음 
--시스템 계정에서 DONGMI계정으로 VIEW생성 권한 추가 
GRANT CREATE VIEW TO DongMi;

--기존 인라인 뷰로 작성 시 
SELECT * 
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp);

--view 객체를 활용 
SELECT * 
FROM v_emp;

--서브쿼리를 view로 만들 수도 있다, 
--emp테이블에는 부서명이 없음 ==> dept테이블과 조인을 빈번하게 진행 
--조인된 결과를 view로 생성 해놓으면 코드를 간결하게 작성하는 게 가능 

--dname(부서명), 직원번호(empno), 직원이름(ename), job(담당업무), hiredate(입사일자) 
CREATE OR REPLACE VIEW v_emp_dept AS 
SELECT  dname, empno, job, hiredate, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno; 

SELECT *
FROM emp;

--인라인 뷰로 작성시 
SELECT  *
FROM( SELECT dname, empno, job, hiredate, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno); 

--viwe 활용시 
SELECT * 
FROM v_emp_dept;

--SMITH 직원 삭제 후 v_emp_dept view 건수 변화를 확인 
DELETE emp 
WHERE ename = 'SMITH';
--뷰는 논리적인 데이터 집합이기 떄문에 view가 참조하는 테이블을 수정하면 
--view에도 영향을 미친다 

--view는 물리적인 데이터를 갖기 않고 논리적인 데이터의 정의 집합 (SQL)이기 떄문에 
--참조하는 테이블을 수정하면 view 조회 결과도 영향을 받는다

ROLLBACK;

--뷰의 종류 
--뷰의 제한 사항 

--SEQUENCE : 시퀀스 - 중복되지 않는 정수값을 리턴헤주는 오라클 객체 
--CREATE SEQUENCE 시퀀스_이름 
--[option....]
--명명규칙 : SEQ_테이블명 

--emp테이블에서 사용한 시퀀스 생성 
CREATE SEQUENCE seq_emp;

--시퀀스 제공 함수 
--NEXTVAL: 시퀀스에서 다음 값을 가져올 때 사용 
--CURRVAL: NEXTVAL를 사용하고 나서 현재 읽어 들인 값을 재확인 
--시퀀스 주의점 : ROLL BACK을 하더라도 NEXTVAL을 통해 얻은 값이 원복되지 않는다 
--NEXTVAL를 통해 그 값을 받아오면 그 값을 다시 사용할 수 없다.

SELECT seq_emp.NEXTVAL
FROM dual;--시퀀스에서 1을 넘겨줌 계속 실행할 수록 증가 

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

--인덱스가 없을 때 empnno 값으로 조회하는 경우 
emp테이블에서 pk_emp제약조건을 삭제하여 empno컬럼으로 인덱스가 존재하지 않는 환경을 조성 

ALTER TABLE emp DROP CONSTRAINT pk_emp;

explain plan for
SELECT * 
FROM emp 
WHERE empno = 7782;

SELECT * 
FROM TABLE(dbms_xplan,display);

emp테이블의 empno컬럼으로 PK제약을 생성하고 동일 SQl을 실행 
-- PK : UNIQUE + NOT NULL (UNIQUE 인덱스를 생성해준다) 
--empno 컬럼으로 unique가 생성된다 

--인덱스로 SQL실행하게 되면 인덱스가 없을 떄, 있을 떄 어떻게 다른지 확인 

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

--SELECT 조회 칼럼이 테이블 접근에 미치는 영향 
SELECT * FROM emp WHERE empno = 7782
==> 
SELECT empno FROM emp WHERE empno = 7782;

EXPLAIN PLAN FOR 
SELECT empno 
FROM emp 
WHERE empno = 7782;

SELECT * 
FROM TABLE(dbms_xplan.display);

--UNIQUE VS NON_UNIQUE 인덱스의 차이 확인 
--1. pk_emp삭제 
--2. empno컬럼으로 non_unique인덱스 생성 
--3. 실행 계획 확인 

ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp (empno);

SELECT * 
FROM emp 
WHERE empno = 7782; 
--
--SELECT * 
--FROM TABLE(dbms_xpl...
--7782가 나왔기때문에 다음꺼 검사 필요x

--emp테이블에 job컬럼을 기준으로 하는 새로운 non-unique 인덱스를 생성 
CREATE INDEX indx_n_emp_02 ON emp(job);

SELECT job, rowid
FROM emp 
ORDER BY JOB;

--선택가능한 사항 
--1. emp 테이블을 전체 일기 
--2. idx_n_emp_01(empno) 인덱스 활용 
--2. idx_n_emp_02(job) 인덱스 활용 -- 내가 원하는 데이터만 찝어낼 수 있기때문에 이거사용

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER';

SELECT * 
FROM TABLE(dbms_xplan.display);
