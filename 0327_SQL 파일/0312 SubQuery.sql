--9-1
SELECT sal FROM emp WHERE ename = 'JONES';
--9-2
SELECT * FROM emp WHERE sal > 2975;
--9-3
SELECT * FROM emp 
    WHERE sal > (SELECT sal FROM emp WHERE ename = 'JONES');
--9-4
SELECT * FROM emp
WHERE hiredate < (SELECT hiredate FROM emp WHERE ename='SCOTT');
--9-5
SELECT E.empno, E.ename, E.job, E.sal, D.deptno, D.dname, D.loc
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE E.deptno = 20
AND E.sal > (SELECT AVG(sal) FROM emp);
-- 30번 부서의 평균 급여보다 많이 받는 20번 부서의 사람들을 출력하는 SQL문을 작성하세요.
SELECT * FROM emp
WHERE deptno = 20
AND sal > (SELECT AVG(sal) FROM emp WHERE deptno = 30);
--9-7
SELECT * FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno);

--9-9 IN과 똑같은 역할
SELECT * FROM emp
WHERE sal = ANY(SELECT MAX(sal) FROM emp GROUP BY deptno);
SELECT * FROM emp
WHERE sal = SOME(SELECT MAX(sal) FROM emp GROUP BY deptno);
--9-11
SELECT * FROM emp
WHERE sal < ANY(SELECT sal FROM emp WHERE deptno=30)
ORDER BY sal, empno;
SELECT * FROM emp
WHERE sal < (SELECT MAX(sal) FROM emp WHERE deptno=30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE deptno=30)
ORDER BY sal, empno;
SELECT * FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno=30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal < ALL (SELECT sal FROM emp WHERE deptno=30)
ORDER BY sal, empno;
SELECT * FROM emp
WHERE sal < (SELECT MIN(sal) FROM emp WHERE deptno=30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE deptno=30)
ORDER BY sal, empno;
SELECT * FROM emp
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno=30)
ORDER BY sal, empno;

--9-16
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 10)
AND deptno = 30;
--9-17
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 50)
AND deptno = 30;
--9-18
SELECT * FROM emp
WHERE (deptno, sal) IN (SELECT deptno,MAX(sal) FROM emp GROUP BY deptno);
--9-19
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM (SELECT * FROM emp WHERE deptno = 10) E10
INNER JOIN (SELECT * FROM dept WHERE deptno = 10) D ON E10.deptno = D.deptno;
--9-20
WITH
    E10 AS (SELECT * FROM emp WHERE deptno = 10),
    D AS (SELECT * FROM dept WHERE deptno = 10)
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM  E10
INNER JOIN D ON E10.deptno = D.deptno;
--9-21
-- SELECT 서브쿼리는 결과가 반드시 하나만 나오도록 작성해야함
SELECT empno, ename, job, sal,
    (SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS salgrade,
    (SELECT losal FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS losal,
    (SELECT hisal FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS hisal,
    deptno,
    (SELECT dname FROM dept WHERE E.deptno = dept.deptno) AS DNAME,
    (SELECT loc FROM dept WHERE E.deptno = dept.deptno) AS loc
FROM emp E;

SELECT E.empno, E.ename, E.job, E.sal, S.grade,S.losal,S.hisal, D.deptno, D.dname,D.loc
FROM emp E 
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
INNER JOIN dept D ON E.deptno = D.deptno;

-- 9장 연습문제
--1
SELECT E.job, E.empno, E.ename, E.sal, D.deptno, D.dname
FROM emp E 
INNER JOIN dept D ON E.deptno = D.deptno
WHERE job = (SELECT job FROM emp WHERE ename='ALLEN');
--2
SELECT E.empno, E.ename, D.dname, E.hiredate, D.loc, E.sal, S.grade
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > (SELECT AVG(sal) FROM emp)
ORDER BY E.sal DESC, empno;
--3
SELECT E.empno, E.ename, E.job, D.deptno, D.dname, D.loc
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE D.deptno = 10
AND job NOT IN (SELECT job FROM emp WHERE deptno = 30);
--4
-- 다중행 함수 사용
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > (SELECT MAX(sal) FROM emp WHERE job='SALESMAN');
-- 다중행 함수 사용하지 않음
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > ALL(SELECT sal FROM emp WHERE job='SALESMAN');



