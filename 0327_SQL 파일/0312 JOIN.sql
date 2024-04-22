-- 집합 연산자 UNION
SELECT * FROM emp WHERE deptno = 10
UNION
SELECT * FROM emp WHERE deptno = 20;
--8-1 JOIN(SQL-99 이전 방식) : 조인 조건 없이 실행 가능
SELECT * FROM emp,dept 
-- WHERE emp.deptno = dept.deptno
ORDER BY empno, dept.deptno;
-- SQL-99 방식 : 조인 조건 없이 실행 불가능
SELECT * FROM emp
INNER JOIN dept ON emp.deptno = dept.deptno
ORDER BY emp.empno, dept.deptno;
--8-3
SELECT E.empno, E.ename, D.deptno FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
ORDER BY E.empno;
-- 등가조인 : 특정열이 정확히 일치하는 데이터를 사용하여 JOIN을 하는 방식
-- 대부분 외래키를 사용하여 JOIN을 실행하게 됨
SELECT * FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno;
-- 비등가 조인 : 등가조인을  제외한 모든 조인 방식 (범위 데이터를 사용하여 조인하는 방식등)
SELECT * FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal;
-- 자체 조인 : 같은 테이블을 두번 사용하여 조인을 하는 방식
SELECT E.empno, E.ename, E.mgr 
        ,E2.empno AS MGR_EMPNO
        ,E2.ename AS MGR_ENAME
FROM emp E
INNER JOIN emp E2 ON E.mgr = E2.empno;

SELECT * FROM emp E
INNER JOIN dept D ON E.empno = D.deptno;
--8-9 : 왼쪽 외부 조인 : 왼쪽 테이블을 기준으로 일치하지 않는 모든 데이터를 함께 출력하는 JOIN
SELECT E.empno, E.ename, E.mgr 
        ,E2.empno AS MGR_EMPNO
        ,E2.ename AS MGR_ENAME
FROM emp E
LEFT OUTER JOIN emp E2 ON E.mgr = E2.empno
ORDER BY E.empno;
--8-10
SELECT E.empno, E.ename, E.mgr 
        ,E2.empno AS MGR_EMPNO
        ,E2.ename AS MGR_ENAME
FROM emp E2
RIGHT OUTER JOIN emp E ON E2.empno = E.mgr
ORDER BY E.empno;
-- FULL OUTER JOIN : 왼쪽 오른쪽 양쪽의 일치하지 않는 데이터를 출력하는 JOIN문
SELECT E.empno, 
        E.ename, 
        E.mgr 
        ,E2.empno AS MGR_EMPNO
        ,E2.ename AS MGR_ENAME
FROM emp E
FULL OUTER JOIN emp E2 
    ON E2.empno = E.mgr
ORDER BY E.empno;
-- NATURAL JOIN : 특정열의 조인 조건을 직접적으로 설정하지 않고 자동으로 설정하는 조인 방식
-- 이름과 자료형이 같은 열을 찾아서 자동으로 조인
-- 등가조인만 설정 가능
-- 등가조인의 조건 (deptno)은 별칭을 쓸 수 없음
--8-11
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm,
        deptno, D.dname, D.loc
FROM emp E NATURAL JOIN dept D
ORDER BY deptno, E.empno;
-- JOIN ~ USING
-- 조인에 사용할 기준열을 설정하여 사용하는 조인
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm,
        deptno, D.dname, D.loc
FROM emp E JOIN dept D USING(deptno)
ORDER BY deptno, E.empno;
-- JOIN ~ ON
-- 기준열의 이름이 달라도 조인 가능, 자료형은 같아야 함
-- 등가조인, 비등가조인, 외부조인, 자체조인 모든 조인을 사용 가능
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm,
        D.deptno, D.dname, D.loc
FROM emp E JOIN dept D ON E.deptno=D.deptno
WHERE sal <= 3000
ORDER BY D.deptno, E.empno;
-- 등가조인 <> 비등가조인 : 조인 조건이 =이냐 아니냐에따라 나뉨
-- 내부조인 <> 외부조인 : 일치하지 않는 데이터를 출력하느냐 아니냐따라 나뉨
-- 자체조인 : 같은 테이블 사용하느냐 아니냐
-- 여러 테이블을 조인하는 방식
SELECT * 
FROM emp E
    INNER JOIN dept D ON E.deptno = D.deptno
    INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
    INNER JOIN emp M ON E.mgr = M.empno
WHERE E.sal >= 2000
ORDER BY E.deptno;

SELECT * 
FROM emp E
    RIGHT OUTER JOIN dept D ON E.deptno = D.deptno
    LEFT OUTER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
    LEFT OUTER JOIN emp M ON E.mgr = M.empno
WHERE E.sal >= 2000
ORDER BY E.deptno;

--8장 연습문제
--sql-99
SELECT D.deptno, D.dname, E.empno, E.ename, E.sal
FROM dept D
INNER JOIN emp E ON D.deptno = E.deptno
WHERE E.sal > 2000;
--sql-99 이전방식
SELECT D.deptno, D.dname, E.empno, E.ename, E.sal
FROM dept D,emp E 
WHERE D.deptno = E.deptno
AND E.sal > 2000;
--2
SELECT D.deptno, D.dname,
    TRUNC(AVG(E.sal)) AS AVG_SAL,
    MAX(E.sal) AS MAX_SAL,
    MIN(E.sal) AS MIN_SAL,
    COUNT(*) AS CNT
FROM dept D
INNER JOIN emp E ON D.deptno = E.deptno
GROUP BY D.deptno, D.dname;
--3
SELECT D.deptno, D.dname, E.empno, E.ename, E.job, E.sal
FROM dept D
LEFT OUTER JOIN emp E ON E.deptno = D.deptno
ORDER BY D.deptno, E.ename;
--4
SELECT D.deptno, D.dname, E.empno,E.ename,E.mgr,E.sal,E.deptno,S.losal,S.hisal,S.grade,
    M.empno AS MGR_EMPNO, M.ename AS MGR_ENAME
FROM dept D 
LEFT OUTER JOIN emp E ON D.deptno = E.deptno
LEFT OUTER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
LEFT OUTER JOIN emp M ON E.mgr = M.empno
ORDER BY D.deptno, E.empno;











