-- 9-1, 사원 이름이 JONES인 사원의 급여 출력하기
SELECT sal FROM emp WHERE ename = 'JONES';

-- 9-2, 급여가 2975보다 높은 사원 정보 출력하기
SELECT * FROM emp WHERE sal > 2975;

-- 9-3, 서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기
SELECT * FROM emp --메인 쿼리라고 함
    WHERE sal >
    (SELECT sal FROM emp WHERE ename = 'JONES'); --괄호쳐서 적어주는걸 서브쿼리라고 함, 비교하는 내용이 서로 같아야함, 숫자면 숫자, 문자면 문자
    
-- 9-4, 서브쿼리의 결과 값이 날짜형인 경우
SELECT * FROM emp
    WHERE hiredate < (SELECT hiredate FROM emp WHERE ename='SCOTT');
    
-- 9-5, 서브쿼리 안에서 함수를 사용한 경우
SELECT E.empno, E.ename, E.job, E.sal, D.deptno, D.dname, D.loc
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE E.deptno = 20
AND E.sal > (SELECT AVG(sal)FROM emp);

-- 30번 부서의 평균 급여 보다 많이 받는 20번 부서의 사람들을 출력하는 SQL문을 작성하세요.
SELECT * FROM emp E
WHERE E.deptno = 20
AND sal > (SELECT AVG(sal)FROM emp WHERE deptno = 30);

-- 9-7, 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력하기
SELECT * FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 9-9 IN이랑 some이랑 같음, ANY 연산자 사용하기
SELECT * FROM emp
WHERE sal = ANY(SELECT MAX(sal) FROM emp GROUP BY deptno);

SELECT * FROM emp
WHERE sal = SOME(SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 9-11, 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기
SELECT * FROM emp
WHERE sal < ANY(SELECT sal FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal < (SELECT MAX(sal) FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30)
ORDER BY sal, empno;


-- 9-14, 부서 번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력하기
SELECT * FROM emp
WHERE sal < ALL (SELECT sal FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

-- 9-16, EXISTS 연산자, 서브쿼리 결과 값이 존재하는 경우
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 10)
AND deptno = 30;


-- 9-17, 서브쿼리 결과 값이 존재하지 않는 경우
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 50);


-- 9-18, 다중열 서브쿼리 사용하기
SELECT * FROM emp
WHERE (deptno, sal) IN (SELECT deptno, MAX(sal) FROM emp GROUP BY deptno);

-- 9-19, 인라인 뷰 사용하기
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM (SELECT * FROM emp WHERE deptno = 10) E10
INNER JOIN (SELECT * FROM dept WHERE deptno = 10)  D ON E10.deptno = D.deptno;

-- 9-20, WITH절 사용하기
WITH
    E10 AS (SELECT * FROM emp WHERE deptno = 10),
    D AS (SELECT * FROM dept WHERE deptno = 10)
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM  E10, D
WHERE E10.deptno = D.deptno;

-- 9-21, SELECT절에 서브쿼리 이용하기
-- SELECT 서브쿼리는 결과물이 반드시 하나만 나오도록 작성해야함
SELECT empno, ename, job, sal,
    (SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS salgrade, -- select절에서 사용하는 서브쿼리는 하나만 사용해야함
    (SELECT losal FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS losal,
    (SELECT hisal FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS hisal,
    deptno,
    (SELECT dname FROM dept WHERE E.deptno = dept.deptno) AS dname,
    (SELECT loc FROM dept WHERE E.deptno = dept.deptno) AS loc
    FROM emp E;

SELECT E.empno, E.ename, E.job, E.sal, S.grade, S.losal, S.hisal, D.deptno, D.dname, D.loc
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN losal AND hisal
INNER JOIN dept D ON E.deptno = D.deptno;


-- 262~263p, 9장 연습문제, Q1~4
-- Q1, 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문
SELECT E.job, E.empno, E.ename, E.sal, D.deptno, D.dname
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

-- Q2, 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력하는 SQL문
SELECT E.empno, E.ename, D.dname, E.hiredate, D.loc, E.sal,
(SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS salgrade
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE E.sal > (SELECT AVG(E.sal) FROM emp E)
ORDER BY E.sal DESC, E.empno;

-- Q3, 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문
SELECT E.empno, E.ename, E.job, E.deptno, D.dname, D.loc
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE E.deptno = 10
AND E.job NOT IN (SELECT job FROM emp WHERE deptno = 30);


-- Q4, 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 다음과 같이 출력하는 SQL문
-- 다중행 함수는 max, min, avg 같은 걸 말함
-- 선생님, 다중행 함수 사용
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN');

-- 내가쓴 다중행 함수 사용
SELECT E.empno, E.ename, E.sal,
(SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS GRADE
FROM emp E
WHERE E.sal > (SELECT MAX(sal) FROM emp E WHERE E.job = 'SALESMAN');

-- 선생님, 다중행 함수 사용 안함
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > ALL(SELECT sal FROM emp WHERE job = 'SALESMAN');



-- 서브쿼리 연습문제
--1. SCOTT의 급여(SAL)와 동일하거나 더 많이 받는 사원의 이름(ENAME)과 급여(SAL)를 출력하세요.
SELECT * FROM emp WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

--2. 직급이 'CLERK'인 사람의 부서번호(DEPTNO)와 부서명(DNAME)을 출력하세요.
SELECT D.deptno, D.dname
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE E.job = 'CLERK';

--3. 이름에 T를 포함하고 있는 사원들과 같은 부서에서 근무하는 사원의 사번(EMPNO)과 이름(ENAME)을 출력하세요.
SELECT E.empno, E.ename
FROM emp E WHERE E.job = (SELECT E.job FROM emp WHERE ename LIKE '%T');

--4. 부서 위치가 DALLAS인 모든 사원의 이름(ENAME), 부서번호(DEPTNO)를 출력하세요.
SELECT E.ename, E.deptno
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE D.LOC = 'DALLAS';

--5. SALES 부서의 모든 사원의 이름(ENAME)과 급여(SAL)를 출력하세요.
SELECT E.ename, E.sal
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE D.dname = 'SALES';

--6.  KING에게 보고하는(=매니저가 KING인 사원) 모든 사원의 이름(ENAME)과 급여(SAL)를 출력하세요.
SELECT E.ename, E.sal, E.mgr
FROM emp E
WHERE E.mgr = (SELECT empno FROM emp WHERE ename = 'KING');


-- 7. 자신의 급여가 평균급여보다 많고 이름에 S가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 이름(ENAME), 급여(SAL)를 출력하세요.
SELECT E.ename, E.sal
FROM emp E
WHERE E.sal > (SELECT AVG(sal)FROM emp)
AND E.ename LIKE '%S';

