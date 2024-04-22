-- 7-2 다중행 함수에서는 일반 열을 출력할 수 없다
SELECT ename, SUM(sal) FROM emp;
--7-4 SUM() : 합계 구하기
SELECT SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal) 
FROM emp;
-- COUNT(*) : 조회 결과의 행 개수를 출력하는 함수
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) FROM emp WHERE deptno = 30;
--7-7
SELECT COUNT(DISTINCT sal),
        COUNT(ALL sal),
        COUNT(sal) FROM emp;
-- 7-8 : NULL값은 개수에 포함되지 않음
SELECT COUNT(comm) FROM emp;
SELECT COUNT(comm) FROM emp WHERE comm IS NOT NULL;
--MAX(), MIN() : 최대값 최소값을 출력하는 함수
SELECT MAX(sal), MIN(sal),MAX(hiredate), MIN(hiredate) FROM emp;
SELECT MAX(sal), MIN(sal),MAX(hiredate), MIN(hiredate) FROM emp WHERE deptno = 30;
-- AVG() : 평균을 출력하는 함수
SELECT AVG(sal) FROM emp;
SELECT AVG(sal) FROM emp WHERE deptno = 30;
-- 사원들의 급여의 총합, 평균, 최대, 최소, 총원 구하는 SQL문을 작성하세요.
SELECT SUM(sal),TRUNC(AVG(sal)),MAX(sal),MIN(sal),COUNT(*) FROM emp;
--7-16 
SELECT '10' AS deptno ,SUM(sal),TRUNC(AVG(sal)),MAX(sal),MIN(sal),COUNT(*) FROM emp WHERE deptno = 10
UNION ALL
SELECT '20' AS deptno ,SUM(sal),TRUNC(AVG(sal)),MAX(sal),MIN(sal),COUNT(*) FROM emp WHERE deptno = 20
UNION ALL
SELECT '30' AS deptno ,SUM(sal),TRUNC(AVG(sal)),MAX(sal),MIN(sal),COUNT(*) FROM emp WHERE deptno = 30;
-- GROUP BY
--7-17
SELECT deptno,AVG(sal) FROM emp
GROUP BY deptno;
SELECT mgr,AVG(sal),COUNT(*) FROM emp
GROUP BY mgr;
SELECT empno, AVG(sal) FROM emp 
GROUP BY empno;
--7-18
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;
--7-20
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
    HAVING AVG(sal) >= 2000
ORDER BY deptno, job;
--7-23
SELECT deptno, job, AVG(sal) AS AVG_SAL  --6
FROM emp --1
    --INNER JOIN  2
WHERE sal <= 3000 --3
GROUP BY deptno, job --4
    HAVING AVG(sal) >= 1000 --5
ORDER BY deptno, job; --7

-- 1.급여가 2000이 넘는 사원들 중에 부서별 평균 급여를 출력하는 SQL문을 작성하세요.
SELECT deptno, AVG(sal) FROM emp 
WHERE sal > 2000
GROUP BY deptno;
-- 2.직책별 사원수가 2명이 넘는 직책과 사람수를 출력하는 SQL문을 작성하세요.
SELECT job , COUNT(*) FROM emp
GROUP BY job
    HAVING COUNT(*)>2;
    
-- ROLLUP 함수 : 소그룹, 대그룹, 총계, n+1개의 그룹별 결과를 출력하는 함수
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
ORDER BY deptno, job;
-- CUBE() : 2의 n 제곱 조합으로 그룹을 만들어주는 함수
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--7-29 GROUPING SETS() : 각각의 그룹화 결과를 출력하는 함수
SELECT deptno, job, COUNT(*)
FROM emp
GROUP BY GROUPING SETS(deptno, job)
ORDER BY deptno, job;

--7-32 GROUPING, GROUPING_ID : 그룹화의 기준이 되었는지 확인하는 함수
SELECT deptno, job, COUNT(*), SUM(sal)
    ,GROUPING(deptno)
    ,GROUPING(job)
    ,GROUPING_ID(deptno, job)
    FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--7-33 
SELECT deptno , ename FROM emp ORDER BY deptno;
--7-34
SELECT deptno, 
LISTAGG(ename,',') WITHIN GROUP(ORDER BY sal DESC) AS ENAMES
FROM emp
GROUP BY deptno;

--7장 연습문제
--1
SELECT deptno, TRUNC(AVG(sal)) AS AVG_SAL
    , MAX(sal) AS MAX_SAL
    , MIN(sal) AS MIN_SAL
    , COUNT(*) AS CNT
FROM emp 
GROUP BY deptno
ORDER BY deptno DESC;
--2
SELECT job, COUNT(*) FROM emp
GROUP BY job
    HAVING SUM(sal) >= 3000;
--3
SELECT TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR, deptno, COUNT(*) AS CNT FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY'),deptno
ORDER BY deptno;
--4
SELECT 
    NVL2(comm,'O','X') AS EXIST_COMM
    , COUNT(*) AS CNT
FROM emp 
GROUP BY NVL2(comm,'O','X');
SELECT CASE  
            WHEN comm IS NULL THEN 'X'
            ELSE 'O'
        END AS EXIST_COMM
        , COUNT(*) AS CNT
FROM emp 
GROUP BY CASE  
            WHEN comm IS NULL THEN 'X'
            ELSE 'O'
        END;
--5
SELECT deptno, TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR,
    COUNT(*) AS CNT,
    MAX(sal) AS MAX_SAL,
    SUM(sal) AS SUM_SAL,
    AVG(sal) AS AVG_SAL
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate,'YYYY'))
ORDER BY deptno;










