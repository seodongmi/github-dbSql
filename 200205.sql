--비상호, NOT IN 
--dept테이블에는 5건의 데이터가 존재 
--emp테이블에는 14명의 직원이 있고 직원은 하나의 부서에 속해 있다
--부서중 직원이 속해 있지 않은 부서 정보를 조회 

--서브쿼리에서 데이터의 조건이 맞는지 역할을 하는 서브쿼리 작성 
SELECT * 
FROM emp;

SELECT * 
FROM dept;

--비상호, NOT IN 
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

--GROUP BY를 이용한 답 
SELECT deptno
FROM emp
GROUP BY deptno;

--속도 면에서 불리
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
                        FROM emp
                    GROUP BY deptno);

--DISTINT: 나열된 컬럼에 대해서 중복을 제거
SELECT deptno
FROM emp
GROUP BY deptno;--한 것과 동일한 효과 

SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno
                     FROM emp);
                     
--5                     
--메인 - 프로덕트 서브 - 사이클 
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
--스칼라서브는 반복적으로 호출하는 수가 많음 
--권장하는 형태X

--EXISTS연산자 
--매니저가 존재하는 직원을 조회 (킹을 제외한 13명의 데이터가 조회) 
SELECT * 
FROM emp
WHERE mgr IS NOT NULL;

--EXISTS연산자 
--EXSTS 조건에 만족하는 행이 존재하는지 확인하는 연산자 
--다른 연산자와 다르게 WHERE절에 컬럼을 기술하지 않는다 
WHERE empno - 7369
WHERE EXISTS (SELECT 'x' --일종의 약속? 같은 거 
              FROM .......);
              
--매니저가 존재하는 직원을 EXSTS연산자를 통해 조회 매니저도 직원 
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

--집합연산 
--합집합 : UNION - 중복제거(집합개념) / UNION ALL - 중복을 제거하지 않음 (속도 향상)
--교집합 : INTERSECT (집합개념) 
--차집합 : MINUS(집합개념)
--집합연산 공통사항 
--두집합의 컬럼의 개수, 타입이 일치해야한다. 

--동일한 집합을 합집하기 때문에 중복되는 데이터는 한번만 적용된다
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--union all
--ALL연산자는 UNION연산자와 다르게 중복을 허용한다 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--intersect (교집합) : 위 아래 집합에서 값이 같은 행만 조회 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--mimus(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합 
SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename 
FROM emp 
WHERE empno IN (7566, 7698);

--집합의 기술 순서가 영향이 가는 집합연산자 
-- A UNION B =            B UNION A ==> 같음
-- A UNION ALL B =        B UNION ALL A ==> 같음 (집합)
-- A INTERSECT B =        B INTERSECT A ==> 같음 
-- A MINUS B =            B MINUS A ==> 다름 

--집합 연산의 특징 
--열의 이름은 첫번째 쿼리의 컬럼을 따른다 
SELECT 'X', 'B'
FROM dual

UNION 

SELECT 'Y', 'A'
FROM dual;


--정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술 
SELECT deptno, dname, loc 
FROM dept
WHERE deptno IN (10,20) 

UNION

SELECT deptno, dname, loc  
FROM dept
WHERE deptno IN (30,40) 
ORDER BY deptno;

--union all은 인라인으로 정렬 기술 
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

--햄버거 도시 발전지수 
SELECT * 
FROM fastfood;

--시도, 시군구, 버거지수 
--버거지수 값이 높은 도시가 먼저 나오도록 정렬 

--대전시 대덕구 버거지수 :
--대전시 중구 버거지수 :
--대전시 서구 버거지수 :
--대전시 유성구 버거지수 : 
--대전시 동구 버거지수 : 


--FROM(SELECT sido, sigungu, gb, count(gb) count  
--     FROM fastfood f
--     GROUP BY sido, sigungu, gb)
SELECT *
FROM fastfood;

SELECT sido || sigungu, count(*)
FROM fastfood 
WHERE gb in('롯데리아')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, round(a.ac/b.bc) 
FROM(SELECT sido, sigungu, count(*) ac
     FROM fastfood 
     WHERE gb in('버거킹', '맥도날드', '맘스터치', '파파이스', 'KFC')
     GROUP BY sido, sigungu) a , (SELECT sido || sigungu, count(*) bc
                                   FROM fastfood 
                                   WHERE gb in('롯데리아')
                                   GROUP BY sido, sigungu) b
WHERE  a.sido = b.sido AND a.sigungu, b.sigungu;                               

--SELECT a.sido, a.sigungu, b.cnt bmk, a.cnt l, ROUND(b.cnt/a.cnt,2) rank
--FROM
--    (SELECT sido, sigungu, count(*) cnt
--    FROM fastfood
--    WHERE gb='롯데리아'
--    GROUP BY sido, sigungu) a, (SELECT sido, sigungu, count(*) cnt
--                                 FROM fastfood
--                                 WHERE gb in('버거킹','맥도날드','KFC')
--                                 GROUP BY sido, sigungu) b
--WHERE a.sido=b.sido AND a.sigungu = b.sigungu
--ORDER BY rank desc;

--대전시에 있는 5개의 구에 대한 햄버거 지수 
--(KFC + 버거킹 + 맥도날드) / 롯데리아;
SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%대전%'
GROUP BY sido;

--분지(KFC, 버커킹, 맥도날드) 
SELECT sido, sigungu, count(*) 
FROM fastfood
WHERE sido = '대전 광역시'
AND gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu;

SELECT sido, sigungu, count(*) 
FROM fastfood
WHERE sido = '대전 광역시'
AND gb IN ('롯데리아')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM(SELECT sido, sigungu, count(*) c1
FROM fastfood
WHERE /*sido = '대전 광역시'
AND*/ gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu) a , (SELECT sido, sigungu, count(*) c2
                            FROM fastfood
                            WHERE /*sido = '대전 광역시'
                            AND*/ gb IN ('롯데리아')
                            GROUP BY sido, sigungu) b
WHERE a.sido = b.sido AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--fastfood테이블을 한번만 읽는 방식으로 작성하기
SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'KFC', 1)),0) kfc, 
NVL(SUM(DECODE(gb, '버거킹', 1)),0) bugger , 
NVL(SUM(DECODE(gb, '맥도날드',1)),0)mac, 
NVL(SUM(DECODE(gb, '롯데리아',1)),1) lot 
FROM fastfood
WHERE gb IN ('KFC', '버거킹', '맥도날드', '롯데리아')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;

SELECT sido, sigungu, ROUND((kfc+bugger + mac ) / lot,2) burger_score
FROM 
(SELECT sido, sigungu,
NVL(SUM(DECODE(gb, 'KFC', 1)),0) kfc, 
NVL(SUM(DECODE(gb, '버거킹', 1)),0) bugger , 
NVL(SUM(DECODE(gb, '맥도날드',1)),0)mac, 
NVL(SUM(DECODE(gb, '롯데리아',1)),1) lot 
FROM fastfood
WHERE gb IN ('KFC', '버거킹', '맥도날드', '롯데리아')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;
--햄버거 지수 시도, 햄버거 지수 시군구,          세금 시도, 세금 시군구, 개인별 근로소득액 
--  서울 특별시 중구 5.67        서울특별시	강남구	70   --1위끼리 맵핑 
--  서울 특별시 도봉구 5          서울특별시	서초구	69  
--  경기도 구리시    5           서울특별시	용산구	57
--  경기도	과천시	54
--  서울특별시	종로구	47
--햄버거 지수, 개인별 근로 소득 금액 순위가 같은 시도별로 (조인)
--지수, 게인별 근로소득 금액으로 정렬 후 ROWNUM을 통해 순위 부여
--같은 순위의 행끼리 조인 

SELECT ROWNUM nm, hap.*
FROM((SELECT ROWNUM nm1
FROM(SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM(SELECT sido, sigungu, count(*) c1
     FROM fastfood
     WHERE gb IN ('KFC', '버거킹', '맥도날드')
     GROUP BY sido, sigungu) a , (SELECT sido, sigungu, count(*) c2
                                  FROM fastfood
                                  WHERE gb IN ('롯데리아')
                                  GROUP BY sido, sigungu) b)
    WHERE a.sido = b.sido AND a.sigungu = b.sigungu
    ORDER BY hambuger_score DESC) hambugerTable ,  (SELECT ROWNUM nm2
                                                     FROM(SELECT sido, sigungu, ROUND(sal/people) pri_sal
                                                          FROM tax
                                                          ORDER BY pri_sal DESC)) taxTable)) hap
    WHERE hambugerTable.nm1 = taxTable.nm2;
    

