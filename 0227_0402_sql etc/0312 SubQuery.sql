-- 9-1, ��� �̸��� JONES�� ����� �޿� ����ϱ�
SELECT sal FROM emp WHERE ename = 'JONES';

-- 9-2, �޿��� 2975���� ���� ��� ���� ����ϱ�
SELECT * FROM emp WHERE sal > 2975;

-- 9-3, ���������� JONES�� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�
SELECT * FROM emp --���� ������� ��
    WHERE sal >
    (SELECT sal FROM emp WHERE ename = 'JONES'); --��ȣ�ļ� �����ִ°� ����������� ��, ���ϴ� ������ ���� ���ƾ���, ���ڸ� ����, ���ڸ� ����
    
-- 9-4, ���������� ��� ���� ��¥���� ���
SELECT * FROM emp
    WHERE hiredate < (SELECT hiredate FROM emp WHERE ename='SCOTT');
    
-- 9-5, �������� �ȿ��� �Լ��� ����� ���
SELECT E.empno, E.ename, E.job, E.sal, D.deptno, D.dname, D.loc
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE E.deptno = 20
AND E.sal > (SELECT AVG(sal)FROM emp);

-- 30�� �μ��� ��� �޿� ���� ���� �޴� 20�� �μ��� ������� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp E
WHERE E.deptno = 20
AND sal > (SELECT AVG(sal)FROM emp WHERE deptno = 30);

-- 9-7, �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ����ϱ�
SELECT * FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 9-9 IN�̶� some�̶� ����, ANY ������ ����ϱ�
SELECT * FROM emp
WHERE sal = ANY(SELECT MAX(sal) FROM emp GROUP BY deptno);

SELECT * FROM emp
WHERE sal = SOME(SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 9-11, 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�
SELECT * FROM emp
WHERE sal < ANY(SELECT sal FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal < (SELECT MAX(sal) FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

SELECT * FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30)
ORDER BY sal, empno;


-- 9-14, �μ� ��ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� �޴� ��� ����ϱ�
SELECT * FROM emp
WHERE sal < ALL (SELECT sal FROM emp WHERE deptno = 30)
ORDER BY sal, empno;

-- 9-16, EXISTS ������, �������� ��� ���� �����ϴ� ���
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 10)
AND deptno = 30;


-- 9-17, �������� ��� ���� �������� �ʴ� ���
SELECT * FROM emp
WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 50);


-- 9-18, ���߿� �������� ����ϱ�
SELECT * FROM emp
WHERE (deptno, sal) IN (SELECT deptno, MAX(sal) FROM emp GROUP BY deptno);

-- 9-19, �ζ��� �� ����ϱ�
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM (SELECT * FROM emp WHERE deptno = 10) E10
INNER JOIN (SELECT * FROM dept WHERE deptno = 10)  D ON E10.deptno = D.deptno;

-- 9-20, WITH�� ����ϱ�
WITH
    E10 AS (SELECT * FROM emp WHERE deptno = 10),
    D AS (SELECT * FROM dept WHERE deptno = 10)
SELECT E10.empno, E10.ename, E10.deptno, D.dname, D.loc
FROM  E10, D
WHERE E10.deptno = D.deptno;

-- 9-21, SELECT���� �������� �̿��ϱ�
-- SELECT ���������� ������� �ݵ�� �ϳ��� �������� �ۼ��ؾ���
SELECT empno, ename, job, sal,
    (SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS salgrade, -- select������ ����ϴ� ���������� �ϳ��� ����ؾ���
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


-- 262~263p, 9�� ��������, Q1~4
-- Q1, ��ü ��� �� ALLEN�� ���� ��å(JOB)�� ������� ��� ����, �μ� ������ ������ ���� ����ϴ� SQL��
SELECT E.job, E.empno, E.ename, E.sal, D.deptno, D.dname
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

-- Q2, ��ü ����� ��� �޿�(SAL)���� ���� �޿��� �޴� ������� ��� ����, �μ� ����, �޿� ��� ������ ����ϴ� SQL��
SELECT E.empno, E.ename, D.dname, E.hiredate, D.loc, E.sal,
(SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS salgrade
FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno
WHERE E.sal > (SELECT AVG(E.sal) FROM emp E)
ORDER BY E.sal DESC, E.empno;

-- Q3, 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ��� ����, �μ� ������ ������ ���� ����ϴ� SQL��
SELECT E.empno, E.ename, E.job, E.deptno, D.dname, D.loc
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE E.deptno = 10
AND E.job NOT IN (SELECT job FROM emp WHERE deptno = 30);


-- Q4, ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ��� ����, �޿� ��� ������ ������ ���� ����ϴ� SQL��
-- ������ �Լ��� max, min, avg ���� �� ����
-- ������, ������ �Լ� ���
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN');

-- ������ ������ �Լ� ���
SELECT E.empno, E.ename, E.sal,
(SELECT grade FROM salgrade WHERE E.sal BETWEEN losal AND hisal) AS GRADE
FROM emp E
WHERE E.sal > (SELECT MAX(sal) FROM emp E WHERE E.job = 'SALESMAN');

-- ������, ������ �Լ� ��� ����
SELECT E.empno, E.ename, E.sal, S.grade
FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
WHERE E.sal > ALL(SELECT sal FROM emp WHERE job = 'SALESMAN');



-- �������� ��������
--1. SCOTT�� �޿�(SAL)�� �����ϰų� �� ���� �޴� ����� �̸�(ENAME)�� �޿�(SAL)�� ����ϼ���.
SELECT * FROM emp WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

--2. ������ 'CLERK'�� ����� �μ���ȣ(DEPTNO)�� �μ���(DNAME)�� ����ϼ���.
SELECT D.deptno, D.dname
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE E.job = 'CLERK';

--3. �̸��� T�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϴ� ����� ���(EMPNO)�� �̸�(ENAME)�� ����ϼ���.
SELECT E.empno, E.ename
FROM emp E WHERE E.job = (SELECT E.job FROM emp WHERE ename LIKE '%T');

--4. �μ� ��ġ�� DALLAS�� ��� ����� �̸�(ENAME), �μ���ȣ(DEPTNO)�� ����ϼ���.
SELECT E.ename, E.deptno
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE D.LOC = 'DALLAS';

--5. SALES �μ��� ��� ����� �̸�(ENAME)�� �޿�(SAL)�� ����ϼ���.
SELECT E.ename, E.sal
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE D.dname = 'SALES';

--6.  KING���� �����ϴ�(=�Ŵ����� KING�� ���) ��� ����� �̸�(ENAME)�� �޿�(SAL)�� ����ϼ���.
SELECT E.ename, E.sal, E.mgr
FROM emp E
WHERE E.mgr = (SELECT empno FROM emp WHERE ename = 'KING');


-- 7. �ڽ��� �޿��� ��ձ޿����� ���� �̸��� S�� ���� ����� ������ �μ����� �ٹ��ϴ� ��� ����� �̸�(ENAME), �޿�(SAL)�� ����ϼ���.
SELECT E.ename, E.sal
FROM emp E
WHERE E.sal > (SELECT AVG(sal)FROM emp)
AND E.ename LIKE '%S';

