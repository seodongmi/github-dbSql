
--1. PRIMARY KEY 제약조건 생성시 오라클 dbms는 해당컬럼으로 UNIQUE INDEX를 자동으로 생성한다 
-- *** 정확히는 UNIQUE제약에 의해 UNIQUE인덱스가 자동으로 생성된다 
-- PRIMARY KEY = UNIQUE + NOT NULL***
--INDEX : 해당 컬럼으로 미리 정렬을 해놓은 객체 
--정렬이 되어있기때문에 찾고자 하는 값이 존재하는지 빠르게 알 수가 있다. 
--만약에 인덱스가 없다면 새로운 데이터를 입력할 때 중복되는 값을 찾기 위해서 
--최악의 경우 테이블의 모든 데이터를 찾아야한다 
--하지만 인덱스가 있으면 이미 정렬이 되어있기때문에 해당 값의 존재 유무를 빠르게 알 수 있다

--2. FOREIGN KEY 제약조건도 
--참조하는 테이블에 값이 있는지를 확인 해야한다. 
--그래서 참조하는 컬럼에 인덱스가 있어야지만 FOGEIG KEY를 생성할 수가 있다 

--FOREIGN KEY 생성시 옵션 
--FOREIGN KEY(참조 무결성) : 참조하는 테이블의 컬럼에 존재하는 값만 입력될 수 있도록 제한 
--(EX) emp테이블에 새로운 데이터를 입력시 deptno컬럼에는 dept테이블에 존재하는 부서번호만 입력될 수 있다. 

--FORIGN KEY가 생성됨에 따라 데이터를 삭제할 때 유의점 
-- 어떤 테이블에서 참조하고 있는 데이터를 바로 삭제가 안됨 
--ex) emp.deptno => dept.deptno 컬럼을 참조하고 있을 때
--   부서 테이블의 데이터를 삭제할 수 없음 

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

INSERT INTO dept_test VALUES (99, 'ddit', '대전');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);
INSERT INTO emp_test (empno, ename, deptno) VALUES (9998, 'sally', 90);
--emp : 9999 99 
--dept : 98 99 
--> 98번 부서를 참조하는 emp테이블의 데이터는 없음 
--> 99번 부서를 참조하는 emp테이블의 데이터는 9999번 brown 사번이 있음 

--만약에 다음 쿼리를 실행하게 되면 
DELETE dept_test
WHERE deptno = 99; --오류

--emp테이블에서 참조하는 데이터가 없는 98번 부서를 삭제하면? -- 가능 
DELETE dept_test
WHERE deptno = 98; -- 가능 

--FOREIGN KEY옵션 
--1. ON DELETE CASCADE : 참조하는 데이터가 삭제될 경우 (부모가 삭제될 경우 - dept) 참조하는 자식 데이터도 같이 삭제한다(emp) 
--2. ON DELETE SET NULL : 부모가 삭제될 경우(dept) 참조하는 자식 데이터의 컬럼을 NULL로 설정한다 

--emp_test테이블을 drop후 옵션을 번갈아 가면서 생성 후 삭제 테스트 
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
--emp테이블의 deptno컬럼은 dept테이블의 deptno 컬럼을 참조(ON DELETE CACADE)
--옵션에 따라서 부모테이블(dept_test)삭제 시 참조하고 있는 자식 데이터도 같이 삭제 된다 

DELETE dept_test
WHERE deptno = 90;
-- 옵션을 부여하지 않았을 때는 위의 DERETE 쿼리가 에러 발생 
-- 옵션에 따라서 참조하는 자식 테이블의 데이터가 정상적으로 삭제 되었는지 SELECT 확인 

SELECT * 
FROM emp_test;

--FK ON DELETE SET NULL 옵션 테스트 
--부모 테이블의 데이터 삭제시 (dept_test) 자식테이블에서 참조하는 데이터를 NULL로 업데이트
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

--dept테이블의 99번 부서를 삭제하면 (부모 테이블을 참조하면) 
--99번 부서를 참조하는 emp_test테이블의 9999번 (brown)데이터의 deptno컬럼을 
--fk 옵션에 따라 NULL로 바뀐다 

delete dept_test
WHERE deptno = 99;
--부모 테이블의 테이블 삭제 후 자식 테이블의 데이터가 NUILL로 변경되었는지 확인 

SELECT * 
FROM emp_test;

--CHECK 제약조건 : 컬럼에 들어가는 값의 종류를 제한 할 때 사용 
--ex) 급여 칼럼을 숫잘호 관리, 급여가 음수가 들어갈 수 있을까? 
--일반적인 경우 급여값은 > 0 
--CHECK 제약을 사용할 경우 급여값이 0보다 큰 값이 검사 가능 
--emp테이블의 job컬럼에 들어가는 값을 다음 4가지로 제한 가능 
--'SALESMAN' , "PRESIDENT' , 'ANALYSY', 'MANAGER'

--테이블 생성시 컬럼 기술과 함께 Check제약 생성 
--emp_test 테이블의 sal 컬럼이 0보다 크다는 check제약조건 생성 

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
 INSERT INTO emp_test VALUES(9998, 'sally', 99, -1000); --체크 조건에 따라 0보다 큰 값만 입력가능
 
-- 새로운 테이블 생성 
-- CREATE TABLE 테이블명(
--  컬럼1....
--  );
-- CREATE TABLE 테이블명 AS
-- SELECT 결과를 새로운 테이블로 생성 

--emp테이블을 이용해서 부서번호가 10번인 사원들만 조회하여 해당 데이터로 
--emp_test2 테이블을 생성 

CREATE TABLE emp_test2 AS
SELECT * 
FROM emp 
WHERE deptno = 10;

SELECT * 
FROM emp_test2;
--NOT NULL 제약조건 이외의 제약조건은 복사되지 않는다 
--개발 시 데이터 백업, 테스트 개발 

--TABLE 변경
--1. 컬럼추가 
--2. 컬럼 사이즈 변경, 타입 변경 
--3. 기본값 설정 
--4. 컬럼명을 RENAME
--5. 컬럼을 삭제 
--6. 제약조건을 추가/삭제

--TABLE 변경 : 1. 컬럼 추가 
DROP table emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno),
     CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno)
     );
     
-- ALTER TABLE 테이블명 ADD [신규컬럼명 신규컬럼 타입);

ALTER TABLE emp_test ADD ( hp VARCHAR2(20));

DESC emp_test;

SELECT * 
FROM emp_test;

--TABLE 변경 : 1. 컬럼 사이즈변경, 타입변경 -- 잘 안씀
-- ex) 컬럼  VARCHAR2(20) --> VARCHAR2(5)
--    기존의 데이터가 존재할 경우 정상적으로 실행이 안될 확률이 매우 높음
--일반적으로 데이터가 존재하지 않는 상태 즉 테이블을 생성한 직후의 컬럼 사이즈, 타입이 잘못 된 경우 
--컬럼 사이즈, 타입을 변경함 
-- 데이터가 입력된 이후로는 활용도가 매우 떨어짐 (사이즈 늘리는 것만 가능)

DESC emp_test;
--hp VARCHAR2(20) --> hp VARCHAR2(30)
--
--ALTER TABLE 테이블명 MODIFY (기존 컬럼명 신규 컬럼 타입(사이즈));

ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));
DESC emp_test;

--hp VARCHAR2(20) --> hp NUMBER
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

--컬럼 기본값 설정 
--ALTER TABLE 테이블명 MODIFY (컬럼명 DEFAULT 기본값);

--hp  hp NUMBER --> VARCHAR2(20) DEFAULT '010'
ALTER TABLE emp_test MODIFY (hp VARCHAR2(20) DEFAULT '010');
DESC emp_test;

--hp컬럼에는 값을 넣지 않았지만 default 설정에 의해 010 문자열이 기본값으로 저장된다. 
INSERT INTO emp_test(empno, ename, deptno) VALUES (9999, 'borwn' , 99);

SELECT * 
FROM emp_test;

--TABLE 변경 : 1. 변경시 컬럼 변경 
--변경하려고 하는 컬럼이 FK제약, PK제약이 있어도 상관 없음 
--ALTER TABLE 테이블명 RENAME 기존 컬럼명 TO 신규 컬럼명;
--
--hp -> hp_n
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

--테이블 변경 : 5. 컬럼삭제 
--ALTER TABLE 테이블명 DROP COLUM 컬럼명 
--emp_test 테이블에서 hp_h 컬럼 삭제;

--emp_test에 hp_n 컬럼이 있는 것을 확인 
SELECT * 
FROM emp_test;


--emp_test 테이블에서 hp_h 컬럼 삭제;
ALTER TABLE emp_test DROP COLUMN hp_n;

--1. emp_test테이블을 drop한 다음에 empno, ename, deptno, hp 4개의 컬럼으로 테이블 생성 
--2. empno, ename, deptno 3가지 컬럼에만 (999, 'brown', 99) 데이터로 INSERT
--3. emp_test테이블의 hp컬럼의 기본값을 '010'으로 설정 
--5. 2번 과정에 입력한 데이터의 hp 컬럼 값이 어떻게 바뀌는지 확인 
-- 답) 값은 바뀌지 않는다. 수정 후에는 기존에 들어간 값에 영향을 주지 않는다

--TABLE 변경 6. 제약조건 추가/삭제
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건타입(PRIMARY KEY, FOREIGN KEY) (해당 칼럼) 
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

--emp_test 테이블 삭제 후 
--제약조건 없이 테이블 생성 
--PRIMARY KEY, FOGEIGN 제약을 ALTER TABLE변경을 통해 생성 
--두개의 제약조건에 대해 테스트 
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

PRIMARY KEY 테스트;
INSERT INTO emp_test VALUES (9999, 'brown' ,99);
INSERT INTO emp_test VALUES (9999, 'sally' ,99); --첫번째 INSERT구문에 중복되므로 실패

SELECT *
FROM dept_test;

FOREIGN KEY 테스트;
INSERT INTO emp_test VALUES (9998, 'sally' ,97); --dept_test테이블에 존재하지 않는 부서번호 이므로 실패

--제약조건 삭제 : PRIMARY KEY, FOREOGN KEY
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;

--제약조건이 없으므로 empno가 중복된 값이 들어갈 수가 있고 dept_test테이블에는 존재하지 않은 deptno값도 들어갈 수 있다

--중복된 empno값으로 데이터 입력 
INSERT INTO emp_test VALUES (9999, 'brown', 99);
INSERT INTO emp_test VALUES (9999, 'sally', 99);

--존재하지 않는 98번 부서로 데이터 입력 
INSERT INTO emp_test VALUES (9999, 'sally', 98);

--제약조건 활성화 / 비활성화 
ALTER TABLE 테이블명 ENABLE | DISABLE CONSTRAINT 제약조건명;

--1. emp_test 테이블 삭제 
--2. emp_test 테이블 생성 
--3. ATER TABLE PRIMARY KEY(empno), FOREIGN KEY(dept_test.deptno) 
--4. 두개의 제약조건을 비활성화 
--5. 비활성화가 되었는지 INSERT를 통해 확인 
--6. 제약조건을 위배한 데이터가 들어간 상태에서 제약조건 활성화 

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);


ALTER TABLE emp_test DISABLE CONSTRAINT pk_emp_test; -- 중복된 값 들어갈 수 있다
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

INSERT INTO emp_test VALUES (9999, 'brown', 99);
INSERT INTO emp_test VALUES (9999, 'brown', 98); 

-- emp_test테이블에는 empno컬럼의 값이 9999인 사원이 두명 존재하기 때문에 
---FRIMARY LEY 제약조건을 활성화 할 수가 없다 
--> empno칼럼의 값이 중복되지 않도록 수정하고 제약조건 활성화 시킬 수 있다 
ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test; -- 중복된 값 들어갈 수 있다
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


dept_test테이블에 존재하지 않는 부서번호 98을 emp_test에서 사용중 
1. dept_test테이블에 98번 부서 등록하거나
2. sally의 부서번호를 99변으로 변경하거나 
3. selly를 지우거나 

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;
UPDATE emp_test SET deptno = 99;
WHERE ename = 'sally';

FRO<ARY KEY 제약조건 활성화 
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;
COMMIT;

--HW :  학습내용 정리
--DEFAULT 값의 적용
--1. emp_test 테이블을 drop후 empno, ename, deptno, hp 4개의 컬럼으로 테이블 생성
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(20));
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
 
--2. empno, ename, deptno 3가지 컬럼에만 (9999, 'brown', 99) 데이터로 INSERT
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);

--3. emp_test 테이블의 hp 컬럼의 기본값을 '010'으로 설정
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');
DESC emp_test;

--4. 2번과정에 입력한 데이터의 hp 컬럼 값이 어떻게 바뀌는지 확인
SELECT * 
FROM emp_test;

--SQL활용 PART2 pt43