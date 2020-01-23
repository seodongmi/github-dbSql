--IN 연산자
--특정 집합에 포함되는지 여부를 확인 
--부서 번호가 10번 혹은 20번에 속하는 직원 조회 

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10,20);

--IN연산자를 사용하지 않고 OR연산자 사용 
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10 OR deptno = 20;

--emp테이블에서 사원이름이 smith, jones인 직원만 조회(empno, ename, deptno)
--문자 상수 조심 
--AND / OR
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN('SMITH','JONES');

--전체 데이터를 조회하는 결과와 같음 
SELECT * 
FROM users
WHERE userid = userid;

SELECT * 
FROM users
WHERE 1 = 1;

--users테이블에서 uerid가 brown, cony, sally인 데이터를 조회 
SELECT usernm AS 이름, userid AS 아이디, alias AS 별명
FROM users
WHERE usernm IN('브라운','코니','샐리');

--문자열 매칭 연산자: LIKE, %, _
--위에서 연습한 조건은 문자열 일치에 대해서 다름 
--이름이 BR로 시작하는 사람만 조회 
--이름에 R 문자열이 들어가는 사람만 조회 

--사원이름이 s로 시작하는 사원 조회 
--SMITH, SMILE, SKC
--%: 어떤 문자열(한글자, 글자가 없을 수도 있고, 여러 문자열이 올 수도 있다)
SELECT * 
FROM emp
WHERE ename LIKE 'S%';

--글자수 제한한 매턴 매칭 
--_정확한 한문자
--직원 이름이 S로 시작하고 이름의 전체 길이가 5글자인 직원 
--s____
SELECT * 
FROM emp
WHERE ename LIKE 'S____';

--사원 이름에 s글자가 들어가는 사원 조회
SELECT * 
FROM emp
WHERE ename LIKE '%S%';

--회원의 성이 신씨인 사람의 mem_id, mem_name 조회 
SELECT mem_id, mem_name 
FROM member
WHERE mem_name LIKE '신%';

--회원의 이름의 이가 들어가는 모든 사람의  mem_id, mem_name 조회 
SELECT mem_id, mem_name 
FROM member
WHERE mem_name LIKE '%이%';

--null 비교 연산 (IS)
--comm 컬럼의 값이 null인 데이터를 조회 (WHERE comm = null)

--SELECT * 
--FROM emp 
--WHERE comm =  null;
--null은 equls연산자를 쓰면x 

SELECT * 
FROM emp 
WHERE comm IS null;

--null이 아닌 데이터 조회 
SELECT * 
FROM emp 
WHERE comm IS NOT null;

--상여는 음수가 없기 때문에 0보다 크면 null이 아님을 추측하여 검색 
SELECT * 
FROM emp 
WHERE comm >= 0;

--논리연산(NOT)
--사원의 관리자가 7698, 7839 그리고 null이 아닌 직원만 조회 

--**NOT IN 연산자에는 NULL값을 포함시키면 안된다. 
SELECT * 
FROM emp 
WHERE mgr NOT IN(7698, 7839, NULL);

--제대로 쓰게 되면 
SELECT * 
FROM emp 
WHERE mgr NOT IN(7698, 7839) AND mgr IS NOT NULL;

--실습 where7번 부터 
SELECT * 
FROM emp 
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO != 10 AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO NOT IN(10) AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE DEPTNO IN(20,30) AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD');

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO LIKE '78%';
--묵시적으로 int -> 문자열 

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO >= 7800 AND EMPNO < 7900;

--연산자 우선순위 
--*,/ 연산자가 +,-보다 우선순위가 높다. 
--우선순위 변경 : ()
-- AND > OR OR보다 AND가 우선순위 높음 

--emp테이블에서 사원이름이 SMITH이거나 사원이름이 ALLEN이면서 담당업무가 SALESMAN인 사원 조회 
--괄호를 해주는 게 명확 
SELECT * 
FROM emp 
WHERE ENAME = 'SMITH' OR (ENAME = 'ALLEN' AND JOB = 'SALESMAN');

--사원이름이 SMITH이거나 ALLEN이면 담당업무가 SALESMAN인 사원 조회
SELECT * 
FROM emp 
WHERE (ENAME = 'SMITH' OR ENAME = 'ALLEN') AND JOB = 'SALESMAN';

SELECT * 
FROM emp 
WHERE JOB = 'SALESMAN' OR EMPNO LIKE '78%' AND hiredate >= TO_DATE('1981/6/1', 'YYYY/MM/DD') ;

--정렬
--TABLE객체에는 데이터를 저장/조회시 순서를 보장하지 않음
--SELECT * 
--FROM table
--[WHERE}
--ORDER BY (칼럼|별칭|컬럼인덱스 ([ASC |DESC], ...) 
--ASC가 기본 값(있어도 없어도 됨)

--emp 테이블의 모든 사원을 ename 칼럼 값을 기준으로 오름차순 정렬한 결과 조회
SELECT * 
FROM emp
ORDER BY ename; 

--emp 테이블의 모든 사원을 ename 칼럼 값을 기준으로 내림차순 정렬한 결과 조회
SELECT * 
FROM emp
ORDER BY ename DESC; 

DESC emp; --DESC : DESRIBE (설명하다)
ORDER BY ename DESC; --DESC: DESCENDING (내림)

--emp 테이블에서 사원 정보를 ename컬럼으로 내림차순, 
--ename 값이 같을 경우 mgr컬럼으로 오름차순 정렬하는 쿼리 작성 
SELECT * 
FROM emp
ORDER BY ename DESC, mgr; 

--정렬시 별칭을 사용 
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;
-- sal*12 year_sal도 별칭으로 만들어 정렬가능 
--FROM먼저 실행 SELECT문 실행 후 ORDER BY를 실행 (별칭으로 인해)

--컬럼 인덱스(컬럼 번호)로 정렬 
--java array[0]
--SQL COLUMN INDEX : 1부터 시작 
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

--오름차순 정렬 
SELECT *
FROM dept
ORDER BY DNAME;

--내림차순 정렬
SELECT *
FROM dept
ORDER BY LOC DESC;

--상여 정보가 있는 사람들만 조회, 상여 많이 받는 사람이 먼저 조회 
--상여가 같은 경우, 사번으로 오름차순 정렬 (상여가 0인 사람은 상여가 없는 것으로 간주)
SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm > 0 
ORDER BY comm DESC ,EMPNO;

--관리자가 있는 사람들만 조회 후 직군 순으로 오름차순 정렬, 직업이 같은 경우 사번이 큰 사원이 먼저 조회
SELECT *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY job, EMPNO DESC;


