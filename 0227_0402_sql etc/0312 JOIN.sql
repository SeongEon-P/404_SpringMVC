--���� ������ UNION
SELECT * FROM emp WHERE deptno = 10
UNION
SELECT * FROM emp WHERE deptno = 20;

-- 8-1 JOIN (SQL-99���� ���) : ���� ���� ���� ���� 
SELECT * FROM emp,dept
WHERE emp.deptno = dept.deptno;
--ORDER BY empno, dept.deptno;
--SQL-99 ���
SELECT * FROM emp  -- JOIN ���� ���� ���� �Ұ���, JOIN�� FROM ������ �;��Ѵ�
INNER JOIN dept ON emp.deptno = dept.deptno  --JOIN ������ ON�� �;��ϰ�, WHERE���� ������ ON �ڿ� �´�. ON ������ �ȉ�
ORDER BY emp.empno, dept.deptno;

-- 8-3
SELECT * FROM emp E --AS ���̸� ������. AS���� �׳� �� ĭ ����
INNER JOIN dept D ON E.deptno = D.deptno  --��Ī(���̺� �̸�) ���̴°� ON �ڳ�, ORDER BY�ڿ��� ����
ORDER BY E.empno;

--������� : Ư������ ��Ȯ�� ��ġ�ϴ� �����͸� ����Ͽ� JOIN�� �ϴ� ���
--��κ� �ܷ�Ű�� ����Ͽ� JOIN�� �����ϰ� ��
SELECT * FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno;

--�� ���� : ������� ������ ��� ���� ���(���� �����͸� ����Ͽ� �����ϴ� ���), ��Ȯ�ϰ� ��ġ�ϴ� �� �ƴ�
SELECT * FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal;

--��ü ���� : ���� ���̺��� �� �� ����Ͽ� ������ �ϴ� ���
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
INNER JOIN emp E2 ON E.mgr = E2.empno;

SELECT * FROM emp E
INNER JOIN dept D ON E.empno = D.deptno;

-- 8-9 : ���� �ܺ� ���� : ���� ���̺��� �������� ��ġ�� �Ͱ�, ��ġ���� �ʴ� ��� �����͸� �Բ� ����ϴ� JOIN.
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
LEFT OUTER JOIN emp E2 ON E.mgr = E2.empno  --INNER JOIN�� ��ġ�ϴ� �����͸� ���, INNER JOIN�� ���� ���� �Ŀ�, ��ġ���� �ʴ� �����͵� �������
ORDER BY E.empno;

-- 8-10
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
RIGHT OUTER JOIN emp E2 ON E.mgr = E2.empno
ORDER BY E.empno;  --���������� �������� �ʴ� �����͸� �����ʿ� �������, ������ ���� �� �߿��Ѱ� ������ ���� �����İ� �߿�. ���� ���°� �������� ��.

-- FULL OUTER JOIN : ���� ������ ������ ��ġ���� �ʴ� �����͸� ����ϴ� ����
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
FULL OUTER JOIN emp E2 ON E.mgr = E2.empno
ORDER BY E.empno; 

-- NATURAL JOIN (�׳� �̷��� �ֱ��� ���� �ѱ�� ��) : Ư�� ���� ���� ������ ���������� �������� �ʰ� �ڵ����� �����ϴ� ���� ���
-- �̸��� �ڷ����� ���� ���� ã�Ƽ� �ڵ����� �����ϰԵ�
-- ����θ� ���� ����
-- ������� ���� (deptno)�� ��Ī�� �� �� ����
-- 8-11
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm
                deptno, D.dname, D.loc
    FROM emp E NATURAL JOIN dept D
    ORDER BY deptno, E.empno;  --���� : ����� �ȵǰ�, ���� �̸��̿�����
    
-- JOIN ~ USING
-- ���ο� ����� ���ؿ��� �����ϴ� ���
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm
                deptno, D.dname, D.loc
    FROM emp E JOIN dept D USING(deptno)
    ORDER BY deptno, E.empno;  
    
-- JOIN ~ ON 
-- ���ؿ��� �̸��� �޶� ���� ����, �ڷ����� ���ƾ� ��
-- �����, ������, �ܺ�����, ��ü���� ��� ��� ������ ��� ����
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm,
                D.deptno, D.dname, D.loc
    FROM emp E JOIN dept D ON E.deptno=D.deptno  --JOIN�� �ݵ�� FROM ������, WHERE�� JOIN������ ������
    
    WHERE sal <= 3000
    ORDER BY deptno, E.empno;  
-- ����� = ��������
-- ����� <> ������ : ���� ������ = �̳� �ƴϳĿ� ���� ����
-- �������� <> �ܺ����� : ��ġ���� �ʴ� �����͸� ����ϴ��� �ƴϳĵ��� ����
-- ��ü���� : ���� ���̺� ����ϴ��� �ƴϳ�

SELECT*
FROM emp E
    RIGHT OUTER JOIN dept D ON E.deptno = D.deptno  --���⼭ �� �� JOIN������, �� �ں��ʹ� JOIN�� ��������� JOIN�� ��.
    LEFT OUTER JOIN salgrade S ON E.sal  BETWEEN S.losal AND S.hisal 
    LEFT OUTER JOIN emp M ON E.mgr = M.empno
WHERE E.sal >= 2000
ORDER BY E.deptno;

--�ѹ� OUTER JOIN ������, �� �ڿ��� OUTER JOIN ��� ����� ��ġ���� �ʴ� �����͵��� �ȳ��ư���.

-- 239~240p, 8�� ��������, Q1~4
-- Q1 : �޿�(sal)�� 2000 �ʰ��� ������� �μ� ����, ��� ������ �����ʰ� ���� ����� ������
SELECT D.deptno, D.dname, E.empno, E.ename, E.sal
     FROM dept D INNER JOIN emp E ON D.deptno=E.deptno
WHERE E.sal > 2000
ORDER BY D.deptno; 

-- Q2 : �����ʰ� ���� �� �μ��� ��� �޿�, �ִ� �޿�, �ּ� �޿�, ������� ����� ������
SELECT D.deptno, D.dname,
    TRUNC(AVG(E.sal)) AS AVG_SAL,
    MAX(E.sal) AS MAX_SAL,
    MIN(E.sal) AS MIN_SAL,
    COUNT(*) AS CNT
    FROM dept D INNER JOIN emp E ON D.deptno=E.deptno
    GROUP BY D.deptno, D.dname; --AVG, MAX�����Ŵ� ������ �Լ��� �Ⱦ��� �������� GROUP BY �ؾ���

--Q3 : ��� �μ� ������ ��� ������ �����ʰ� ���� �μ� ��ȣ, ��� �̸� ������ �����Ͽ� ����� ������
SELECT D.deptno, D.dname 
         ,E.empno, E.ename,E.job, E.sal
     FROM dept D 
LEFT OUTER JOIN emp E ON E.deptno = D.deptno  --dept D�� ��������, ��ġ���� �ʴ� �����͵� ����ϱ� ���ؼ� inner join �� �ƴ� outer join ������
ORDER BY D.deptno, E.ename; 

--Q4 : ������ ���� ��� �μ� ����, ��� ����, �޿� ��� ����, �� ����� ���� ����� ������ �μ� ��ȣ, ��� ��ȣ ������ �����Ͽ� ����� ������
SELECT D.deptno, D.dname, E.empno, E.ename, E.mgr, E.sal, E.deptno, S.losal, S.hisal, S.grade, M.empno AS MGR_EMPNO, M.ename AS MGR_ENAME         
     FROM dept D
     LEFT OUTER JOIN emp E ON D.deptno=E.deptno
     LEFT OUTER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
     LEFT OUTER JOIN emp M ON E.mgr = M.empno
     ORDER BY D.deptno, E.empno;



