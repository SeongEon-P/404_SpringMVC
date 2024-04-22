--������ �Լ������� �Ϲ� ���� ����� �� ����
SELECT ename, SUM(sal) FROM emp;

-- 7-3 : �߰� ���� �հ� ���ϱ�
SELECT SUM(comm) FROM emp;

-- 7-4 : �޿� �հ� ���ϱ�
SELECT SUM(DISTINCT sal),
       SUM(ALL sal),
       SUM(sal)
FROM emp;

--DISTINCT�� �ߺ��� �����ϰ� ���

--COUNT(*) : ��ȸ ����� �� ������ ����ϴ� �Լ�
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) FROM emp WHERE deptno = 30;

-- 7-7 : COUNT �Լ��� ����ϱ�. �޿� ���� ���ϱ�(DISTINCT, ALL���)
SELECT COUNT(DISTINCT sal),
       COUNT(ALL sal),
       COUNT(sal) FROM emp;
--NULL���� �� ������ COUNT�� �ö��� �ʰ� ����Ѵ�.

-- 7-8 : NULL���� ������ ���Ե��� �ʴ´�
SELECT COUNT(comm) FROM emp;
SELECT COUNT(comm) FROM emp WHERE comm IS NOT NULL;

SELECT * FROM emp; --�� �ڵ�� 'emp' ���̺��� ��� ���� ���� �����Ͽ� ��ȯ�մϴ�. ��, 'emp' ���̺��� ��� �����͸� ��ȸ
SELECT * FROM emp WHERE comm IS NOT NULL; -- 'comm' ���� NULL�� �ƴ� ���� ���� �ุ ��ȸ

-- MAX(), MIN() : �ִ밪 �ּҰ��� ����ϴ� �Լ�
SELECT MAX(sal), MIN(sal), MAX(hiredate), MIN(hiredate) FROM emp;
SELECT MAX(sal), MIN(sal), MAX(hiredate), MIN(hiredate) FROM emp WHERE deptno = 30;

-- AVG() : ����� ����ϴ� �Լ�
SELECT AVG(sal) FROM emp;
SELECT AVG(sal) FROM emp WHERE deptno = 30;

-- ������� �޿��� ����, ���, �ִ�, �ּ�, �ѿ� ���ϴ� SQL���� �ۼ��ϼ���
SELECT SUM(sal) AS ����,
       TRUNC(AVG(sal)) AS ���,
       MAX(sal) AS �ִ�,
       MIN(sal) AS �ּ�, 
       COUNT(*) AS �ѿ�
FROM emp;

-- 7-16 : 
SELECT '10' AS deptno, SUM(sal), TRUNC(AVG(sal)), MAX(sal), MIN(sal), COUNT(*) FROM emp WHERE deptno = 10
UNION ALL --SELECT���� ������ �� ���, ������� ���η� ���������
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

-- 7-18 : �μ� ��ȣ �� ��å�� ��� �޿��� �����ϱ�
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
ORDER BY deptno, job ;  -- ORDER���� deptno �� ���� ���ͼ� ������������ �켱 ����.

-- 7-20 : GROUP BY ���� HAVING ���� ����Ͽ� ����ϱ�
SELECT deptno, job, AVG(sal) FROM emp
GROUP BY deptno, job
    HAVING AVG(sal) >= 2000
ORDER BY deptno, job ; 


-- 7-23 : WHERE���� HAVING���� ��� ����� ���
SELECT deptno, job, AVG(sal)
    FROM emp -- 1) --SELECT �������� �ݵ�� FROM�� ���� ���� �;��Ѵ�. �ٸ� WHERE/GROUP �̷��� FROM���� ���� �� �� ����.
    --INNER JOIN  --2)
    WHERE sal <= 3000 --3)
    GROUP BY deptno, job --4) --GROUP BY�� ��������, HAVING AVG�� �� �� �ִ�.
      HAVING AVG(sal) >= 2000 --5)
ORDER BY deptno, job ; --7) -- ORDER BY �� ������ ���������� �� �� �ִ�. ������ as����ؼ� ��Ī�� ����ߴٰ� �ؼ�, �װ� ����� �� �� ����.

--1. �޿��� 2000�� �Ѵ� ����� �߿�, �μ��� ��� �޿��� ����ϴ� SQL��
SELECT deptno, AVG(sal) FROM emp 
    WHERE sal >= 2000 
    GROUP BY deptno
      HAVING AVG(sal) >= 2000 
ORDER BY deptno;

--2. ��å�� ������� 2���� �Ѵ� ��å�� ������� ����ϴ� SQL��
SELECT job, COUNT(*) FROM emp --COUNT�� ���Ա⶧���� GROUP BY�� �� �;��Ѵ�
  GROUP BY job
    HAVING COUNT(*)>2
ORDER BY job ; 

-- 7-25 : ROLLUP �Լ��� ������ �׷�ȭ
-- ROLLUP �Լ� : �ұ׷�, ��׷�, �Ѱ�, n+1���� �׷캰 ����� ����ϴ� �Լ�
SELECT deptno, job,mgr, COUNT(*), MAX(sal), SUM(sal), AVG(sal) FROM emp
 GROUP BY ROLLUP(deptno, job, mgr)
 ORDER BY deptno, job;
 
 -- CUBE() : n�� ������ �������� �׷��� ������ִ� �Լ�
 SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal) FROM emp
 GROUP BY CUBE(deptno, job)
 ORDER BY deptno, job;
 
 
 -- 7-29 : GROUPING SET : �����Ǳ׷�ȭ ����� ������ִ� �Լ�
 SELECT deptno, job, COUNT(*)FROM emp
 GROUP BY GROUPING SETS(deptno, job)
 ORDER BY deptno, job;
 


-- 7-32 GROUPING, GROUPING_ID : deptno, job�� �Բ� ����� GROUPING_ID �Լ� ����ϱ�
SELECT deptno, Job, COUNT(*), SUM(sal),
       GROUPING(deptno), --0�� ������ GROUPING�������� ����ٴ� ��. 1�� ���ȉ�ٴ� ��
       GROUPING(job),
       GROUPING_ID(deptno, job) --�������� ����� 00:0, 01:1, 10:2, 11:3
       FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

--LISTAGG : �׷�ȭ�� �ڷḦ ���η� ǥ���� �� �ְ� ����
-- 7-33 : GROUP BY���� �׷�ȭ�Ͽ� �μ� ��ȣ�� ��� �̸� ����ϱ�
SELECT deptno, ename FROM emp
--GROUP BY deptno, ename
ORDER BY deptno;

-- 7-34 : �μ��� ��� �̸��� ������ �����Ͽ� ����ϱ�
SELECT deptno, 
         LISTAGG(ename, ', ')
         WITHIN GROUP(ORDER BY sal DESC) AS ENAMES --DESC�� ���� ū������� ������� ������ �����Ѵٴ� ��
         
        FROM emp
    GROUP BY deptno;


-- 212~213p 7�� ��������
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
SELECT TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR, -- �ƴϸ� SUBSTR(hiredate,1,4) FROM emp;�ص� ��. �׷��� �̷��� �ϸ� ���̳ʽ� �� �� �� �ְ�, ����� ������ �ٲ�� �ٲ������
        deptno,
        COUNT(*) AS CNT FROM emp
        GROUP BY TO_CHAR(hiredate, 'YYYY'), deptno --GROUP BY�ڿ� ���� ������ �״�� �� �� �ִ�.
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

--�����Բ�
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
--�����Բ�
SELECT deptno, TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR,
    COUNT(*) AS CNT,
    MAX(sal) AS MAX_SAL,
    SUM(sum) AS SUM_SAL,
    AVG(sal) AS AVG_SAL
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate, 'YYYY'))
ORDER BY deptno;
        
    

