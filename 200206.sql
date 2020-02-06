--ROWNUM 사용시 주의 
--1. SELECT == > ORDER BY 
--정렬된 결과에 ROWNUM을 적용하기 위해서는 INLINE_VIEW 
--2. 1번부터 순차적으로 조회가 되는 조건에 대해서만 WHERE절에서 기술이 가능 
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
     WHERE gb IN ('KFC', '버거킹', '맥도날드')
     GROUP BY sido, sigungu) a) A,       
(SELECT ROWNUM rn2, b.*     
FROM(SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC) b) B
WHERE a.rn1 = b.rn2

--선생님 답 

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
--       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '버거킹', 1)), 0) BURGERKING,
--       NVL(SUM(DECODE(gb, '맥도날드', 1)), 0) mac, NVL(SUM(DECODE(gb, '롯데리아', 1)), 1) lot       
--FROM fastfood
--WHERE gb IN ('KFC', '버거킹', '맥도날드', '롯데리아')
--GROUP BY sido, sigungu)
--ORDER BY burger_score DESC) b ) b
--WHERE a.rn = b.rn;

--empno컬럼은 NOT NULL제약 조건이 있다 - INSERT시 반드시 값이 존재해야 정상적으로 입력된다 
--empno컬럼을 제외한 나머지 칼럼은 NULLABLE이다 (NULL값이 저장될 수 있다)
INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', NULL);

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN');

--문자열 : '문자열' 
--숫자 :  10 
--날짜 : TO_DATE('20200206', 'YYYYMMDD')

--emp테이블의 hiredate 컬럼은 date타입 
--emp테이블의 8개의 컬럼의 값을 입력 
--emp() <- 에 자동으로 입력할 때 컬럼 순서대로 기술 
INSERT INTO emp VALUES(9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99);

--트랜잭션 확정 
ROLLBACK;

--여러건의 데이터를 한번에 INSERT : 
--INSERT INTO 테이블명 (컬럼명1, 컬럼명2...)
--SELECT 
--FROM 

INSERT INTO emp 
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99
FROM dual

UNION ALL 

SELECT 9999, 'brown' , 'CLEERK' , NULL, TO_DATE('20200205','YYYYMMDD'), 1100, NULL, 99 
FROM dual;

--UPDATE 쿼리 
--UPDATE 테이블명 컬럼명 = 갱신할 컬럼 값1, 컬럼명2 = 갱신할 컬럼 값2,.....
--WHERE 행 제한 조건 
--업데이트 쿼리 작성시 WHERE절이 존재하지 않으면 해당 테이블의 모든 행을 대상으로 업데이트가 일어난다.
--UPDATE, DELECT절에 WHERE절이 없으면 의도한 것이 맞는지 다시 한번 확인한다. 

--WHERE절이 있다고 하더라도 해당 조건으로 해당 테이블을 SELECT하는 쿼리를 작성하여 실행하면 
--UPDATE 대상 행을 조회할 수 있으므로 확인하고 실행하는 것도 사고 발생 방지에 도움이 된다 

--99부서번호를 갖는 부서 정보가 DEPT 테이블에 있는 상황 
--UINSERT IN dept VALES (99, 'ddit', 'daejeon');
--COMMIT;

--99번 부서번호를 갖는 부서의 dname 컬럼의 값을 '대덕 IT', LOC값을 '영민빌딩'으로 업데이트


UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM DEPT
WHERE deptno = 99;

--커밋을 아직 안했기때문에 잘못된 것을 인지하면 롤백을 할 것 

--실수로 WHERE절을 기술하지 않았을경우 
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩';
ROLLBACK

--여사님 - 시스템 번호를 잊어먹음 -> 한달에 한번씩 모든 여사님을 대상으로 
--                                 본인 주민번호 뒷자리로 비밀번호를 업데이트 
--                                  시스템 사용자: 여사님, 영업점, 직원 

--시스템 사용자: 여사님 , 영업점, 직원 
--UPDATE 사용자 SET 비밀번호 = 주민번호 뒷자리 
--WHERE절을 기술안하면 모두 업데이트 

--UPDATE 사용자 SET 비밀번호 = 주민번호뒷자리 
--WHERE 사용자구분 = '여사님';
--COMMIT

-- 10 --> SUBQUERY ; 
--SMITH, WORD 이 속한 부서에 소속된 직원 정보 
-- SELECT * 
-- FRPM emp 
-- WHERE deptno IN(20,30)

SELECT * 
FROM emp 
WHERE deptno IN((SELECT deptno
                           FROM emp
                           WHERE ename IN ('SMITH', 'WORD'));
--업데이트 시에도 서브쿼리 사용 가능 

INSERT INTO emp(empno, ename) VALUES (9999, 'brown');
--9999번 사원 deptno, job정보를 SMITH사원이 속한 부서번호, 담당업무로 업데이트 
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job =  (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT * 
FROM emp;

ROLLBACK;

--DELETE SQL : 특정 행을 삭제 
--DELETE  [FROM] 테이블명 
--WHERE 행 제한 조건 

SELECT *
FROM dept;

99번 부서번호에 해당하는 부서 정보 삭제 

DELETE dept
WHERE deptno = 99;

COMMIT

--subquery를 통해서 특정 행을 제한하는 조건을 갖는 DELETE
--매니저가 7698 사번인 직원을 삭제하는 쿼리를 작성 
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
--커밋한 정보

--프로그래밍의 오해와 진실 
--박재성 