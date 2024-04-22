-- 7-2 ������ �Լ������� �Ϲ� ���� ����� �� ����
SELECT ename, SUM(sal) FROM emp;
--7-4 SUM() : �հ� ���ϱ�
SELECT SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal) 
FROM emp;
-- COUNT(*) : ��ȸ ����� �� ������ ����ϴ� �Լ�
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) FROM emp WHERE deptno = 30;
--7-7
SELECT COUNT(DISTINCT sal),
        COUNT(ALL sal),
        COUNT(sal) FROM emp;
-- 7-8 : NULL���� ������ ���Ե��� ����
SELECT COUNT(comm) FROM emp;
SELECT COUNT(comm) FROM emp WHERE comm IS NOT NULL;
--MAX(), MIN() : �ִ밪 �ּҰ��� ����ϴ� �Լ�
SELECT MAX(sal), MIN(sal),MAX(hiredate), MIN(hiredate) FROM emp;
SELECT MAX(sal), MIN(sal),MAX(hiredate), MIN(hiredate) FROM emp WHERE deptno = 30;
-- AVG() : ����� ����ϴ� �Լ�
SELECT AVG(sal) FROM emp;
SELECT AVG(sal) FROM emp WHERE deptno = 30;
-- ������� �޿��� ����, ���, �ִ�, �ּ�, �ѿ� ���ϴ� SQL���� �ۼ��ϼ���.
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

-- 1.�޿��� 2000�� �Ѵ� ����� �߿� �μ��� ��� �޿��� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT deptno, AVG(sal) FROM emp 
WHERE sal > 2000
GROUP BY deptno;
-- 2.��å�� ������� 2���� �Ѵ� ��å�� ������� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT job , COUNT(*) FROM emp
GROUP BY job
    HAVING COUNT(*)>2;
    
-- ROLLUP �Լ� : �ұ׷�, ��׷�, �Ѱ�, n+1���� �׷캰 ����� ����ϴ� �Լ�
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
ORDER BY deptno, job;
-- CUBE() : 2�� n ���� �������� �׷��� ������ִ� �Լ�
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;
--7-29 GROUPING SETS() : ������ �׷�ȭ ����� ����ϴ� �Լ�
SELECT deptno, job, COUNT(*)
FROM emp
GROUP BY GROUPING SETS(deptno, job)
ORDER BY deptno, job;

--7-32 GROUPING, GROUPING_ID : �׷�ȭ�� ������ �Ǿ����� Ȯ���ϴ� �Լ�
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

--7�� ��������
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










