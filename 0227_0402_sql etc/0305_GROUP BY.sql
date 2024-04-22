--다중행 함수에서는 일반 열을 출력할 수 없다
SELECT ename, SUM(sal) FROM emp;

-- 7-3 : 추가 수당 합계 구하기
SELECT SUM(comm) FROM emp;

-- 7-4 : 급여 합계 구하기
SELECT SUM(DISTINCT sal),
       SUM(ALL sal),
       SUM(sal)
FROM emp;

--DISTINCT는 중복을 제거하고 계산

--COUNT(*) : 조회 결과의 행 개수를 출력하는 함수
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) FROM emp WHERE deptno = 30;

-- 7-7 : COUNT 함수를 사용하기. 급여 개수 구하기(DISTINCT, ALL사용)
SELECT COUNT(DISTINCT sal),
       COUNT(ALL sal),
       COUNT(sal) FROM emp;
--NULL값이 들어가 있으면 COUNT가 올라가지 않고 계수한다.

-- 7-8 : NULL값은 개수에 포함되지 않는다
SELECT COUNT(comm) FROM emp;
SELECT COUNT(comm) FROM emp WHERE comm IS NOT NULL;

SELECT * FROM emp; --이 코드는 'emp' 테이블에서 모든 열과 행을 선택하여 반환합니다. 즉, 'emp' 테이블의 모든 데이터를 조회
SELECT * FROM emp WHERE comm IS NOT NULL; -- 'comm' 열에 NULL이 아닌 값을 가진 행만 조회

-- MAX(), MIN() : 최대값 최소값을 출력하는 함수
SELECT MAX(sal), MIN(sal), MAX(hiredate), MIN(hiredate) FROM emp;
SELECT MAX(sal), MIN(sal), MAX(hiredate), MIN(hiredate) FROM emp WHERE deptno = 30;

-- AVG() : 평균을 출력하는 함수
SELECT AVG(sal) FROM emp;
SELECT AVG(sal) FROM emp WHERE deptno = 30;

-- 사원들의 급여의 총합, 평균, 최대, 최소, 총원 구하는 SQL문을 작성하세요
SELECT SUM(sal) AS 총합,
       TRUNC(AVG(sal)) AS 평균,
       MAX(sal) AS 최대,
       MIN(sal) AS 최소, 
       COUNT(*) AS 총원
FROM emp;

-- 7-16 : 
SELECT '10' AS deptno, SUM(sal), TRUNC(AVG(sal)), MAX(sal), MIN(sal), COUNT(*) FROM emp WHERE deptno = 10
UNION ALL --SELECT문을 연결할 때 사용, 결과값을 세로로 연결시켜줌
SELECT '20' AS deptno, SUM(sal), TRUNC(AVG(sal)), MAX(sal), MIN(sal), COUNT(*) FROM emp WHERE deptno = 20
UNION ALL 
SELECT '30' AS deptno, SUM(sal),TRUNC(AVG(sal)) ,MAX(sal), MIN(sal),COUNT(*) FROM emp WHERE deptno = 30;

-- 7-17 
SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno;
SELECT mgr, AVG(sal),COUNT(*) FROM emp
GROUP BY mgr;
SELECT empno, AVG(sal) FROM emp
GROUP BY empno;

-- 7-18 : 부서 번호 및 직책별 평균 급여로 정렬하기
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
ORDER BY deptno, job ;  -- ORDER에서 deptno 가 먼저 나와서 오름차순으로 우선 정렬.

-- 7-20 : GROUP BY 절과 HAVING 절을 사용하여 출력하기
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
    HAVING AVG(sal) >= 2000
ORDER BY deptno, job ; 


-- 7-23 : WHERE절과 HAVING절을 모두 사용한 경우
SELECT deptno, job, AVG(sal)
    FROM emp -- 1) --SELECT 다음에는 반드시 FROM이 제일 먼저 와야한다. 다른 WHERE/GROUP 이런게 FROM보다 먼저 올 수 없다.
    --INNER JOIN  --2)
    WHERE sal <= 3000 --3)
    GROUP BY deptno, job --4) --GROUP BY를 썼을때만, HAVING AVG가 올 수 있다.
      HAVING AVG(sal) >= 2000 --5)
ORDER BY deptno, job ; --7) -- ORDER BY 는 무조건 마지막에만 올 수 있다. 위에서 as사용해서 별칭을 사용했다고 해서, 그걸 사용할 수 는 없다.

--1. 급여가 2000이 넘는 사원들 중에, 부서별 평균 급여를 출력하는 SQL문
SELECT deptno, AVG(sal) FROM emp 
    WHERE sal >= 2000 
    GROUP BY deptno
      HAVING AVG(sal) >= 2000 
ORDER BY deptno;

--2. 직책별 사원수가 2명이 넘는 직책과 사람수를 출력하는 SQL문
SELECT job, COUNT(*) FROM emp --COUNT가 나왔기때문에 GROUP BY가 꼭 와야한다
  GROUP BY job
    HAVING COUNT(*)>2
ORDER BY job ; 

-- 7-25 : ROLLUP 함수를 적용한 그룹화
-- ROLLUP 함수 : 소그룹, 대그룹, 총계, n+1개의 그룹별 결과를 출력하는 함수
SELECT deptno, job,mgr, COUNT(*), MAX(sal), SUM(sal), AVG(sal) FROM emp
 GROUP BY ROLLUP(deptno, job, mgr)
 ORDER BY deptno, job;
 
 -- CUBE() : n의 제곱의 조합으로 그룹을 만들어주는 함수
 SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal) FROM emp
 GROUP BY CUBE(deptno, job)
 ORDER BY deptno, job;
 
 
 -- 7-29 : GROUPING SET : 각각의그룹화 결과를 출력해주는 함수
 SELECT deptno, job, COUNT(*)FROM emp
 GROUP BY GROUPING SETS(deptno, job)
 ORDER BY deptno, job;
 


-- 7-32 GROUPING, GROUPING_ID : deptno, job을 함께 명시한 GROUPING_ID 함수 사용하기
SELECT deptno, Job, COUNT(*), SUM(sal),
       GROUPING(deptno), --0이 나오면 GROUPING조건으로 사용됬다는 뜻. 1은 사용안됬다는 뜻
       GROUPING(job),
       GROUPING_ID(deptno, job) --이진수를 사용함 00:0, 01:1, 10:2, 11:3
       FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

--LISTAGG : 그룹화된 자료를 가로로 표시할 수 있게 해줌
-- 7-33 : GROUP BY절로 그룹화하여 부서 번호와 사원 이름 출력하기
SELECT deptno, ename FROM emp
--GROUP BY deptno, ename
ORDER BY deptno;

-- 7-34 : 부서별 사원 이름을 나란히 나열하여 출력하기
SELECT deptno, 
         LISTAGG(ename, ', ')
         WITHIN GROUP(ORDER BY sal DESC) AS ENAMES --DESC는 값이 큰사람부터 작은사람 순으로 정렬한다는 뜻
         
        FROM emp
    GROUP BY deptno;


-- 212~213p 7장 연습문제
--Q1
SELECT deptno,
       TRUNC(AVG(sal)) AS AVG_SAL,
       MAX(sal) AS MAX_SAL,
       MIN(sal) AS MIN_SAL,
       COUNT(*) AS CNT FROM emp
GROUP BY deptno
ORDER BY deptno DESC;

--Q2
SELECT job, COUNT(*) FROM emp
    GROUP BY job
        HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC;

--Q3
SELECT TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR, -- 아니면 SUBSTR(hiredate,1,4) FROM emp;해도 됨. 그런데 이렇게 하면 마이너스 들어갈 수 도 있고, 년월일 순서가 바뀌면 바꿔줘야함
        deptno,
        COUNT(*) AS CNT FROM emp
        GROUP BY TO_CHAR(hiredate, 'YYYY'), deptno --GROUP BY뒤에 위에 적은거 그대로 올 수 있다.
ORDER BY TO_CHAR(hiredate, 'YYYY') DESC;

--Q4
SELECT 
CASE 
    WHEN comm IS NULL THEN 'X' 
    ELSE 'O' 
END AS EXIST_COMM, COUNT(*) FROM emp    
GROUP BY 
    CASE
    WHEN comm IS NULL THEN 'X' 
    ELSE 'O' 
END;

--선생님꺼
SELECT NVL2(comm, 'O', 'X') AS EXIST_COMM,
COUNT(*) AS CNT
FROM emp
GROUP BY 
    NVL2(comm, 'O', 'X');
    
--Q5
SELECT deptno,  
       NVL(TO_CHAR(hiredate, 'YYYY'), ' ') AS HIRE_DATE,
       COUNT(*) AS CNT,
       MAX(sal) AS MAX_SAL,
       SUM(sal) AS MIN_SAL,
       ROUND(AVG(sal), 13) AS AVG_SAL 
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate, 'YYYY'))
ORDER BY deptno;
--선생님꺼
SELECT deptno, TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR,
    COUNT(*) AS CNT,
    MAX(sal) AS MAX_SAL,
    SUM(sum) AS SUM_SAL,
    AVG(sal) AS AVG_SAL
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate, 'YYYY'))
ORDER BY deptno;
        
    

