--WHERE�� : SELECT������ Ư�� ���� ����ϴ� SQL��
SELECT * FROM emp;

SELECT * FROM emp
WHERE deptno = 20;
--AND : �׸��� : ���� ���� ����� ��� true(��)�϶� true�� ��ȯ�ϰ� �������� ��� false(����)
SELECT * FROM emp WHERE deptno=30 AND job='SALESMAN';
--OR : �Ǵ� : ���� �� �߿� �ϳ��� ��� true��� true ��ȯ, ���� ���� ��� false�̸� false�� ��ȯ
SELECT * FROM emp WHERE deptno = 30 OR job = 'CLERK';
-- 20�� �μ��� ��å�� CLERK�� ����� ����ϴ� SQL���� �ۼ��غ�����.
SELECT * FROM emp WHERE deptno=20 AND job='CLERK';
-- 10�� �μ��̰ų� ��å�� MANAGER�� ����� ����ϴ� SQL���� �ۼ��غ�����.
SELECT * FROM emp WHERE deptno=10 OR job='MANAGER';

--��� �� ������ : <, <=, >, >=
SELECT * FROM emp WHERE sal > 1000;
SELECT * FROM emp WHERE sal >= 2000;
SELECT * FROM emp WHERE sal < 1600;
SELECT * FROM emp WHERE sal <= 1600;
SELECT * FROM emp WHERE ename <= 'FORC';
--� �� ������ : =, !=, <>, ^=
SELECT * FROM emp WHERE sal = 3000;
SELECT * FROM emp WHERE sal != 3000;
SELECT * FROM emp WHERE sal <> 3000;
SELECT * FROM emp WHERE sal ^= 3000;
-- ��� ���� ���̺��� �޿��� 2000�̻� �����鼭 ��å�� MANAGER�� �ƴ� ����� ����ϴ� SQL���� �ۼ��غ�����.
SELECT * FROM emp 
 WHERE sal >= 2000 
   AND job <> 'MANAGER'; 
-- NOT ������ : �ٸ��� : !=, <>, ^= 
SELECT * FROM emp WHERE NOT(sal = 3000 OR sal = 1600);
SELECT * FROM emp WHERE sal != 3000 AND sal != 1600;
--IN ������ : ������ ������ �϶� ����ϴ� ������
SELECT * FROM emp WHERE job IN ('MANAGER', 'PRESIDENT','CLERK');
SELECT * FROM emp WHERE job = 'MANAGER' OR job = 'PRESIDENT' OR job = 'CLERK';
SELECT * FROM emp WHERE job NOT IN ('MANAGER', 'PRESIDENT','CLERK');
SELECT * FROM emp WHERE job != 'MANAGER' AND job <> 'PRESIDENT' AND job ^= 'CLERK';
--IN�����ڸ� ����Ͽ� �μ���ȣ�� 10,20���� ��� ������ ����غ�����.
SELECT * FROM emp WHERE deptno IN (10,20);
--BETWEEN A AND B : A���� ũ�ų� ���� B���� �۰ų� ������ ����ϴ� ������
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;
-- ��� �� �����ڸ� �̿��Ͽ� �޿��� 2000���� ũ�ų� ���� 3000���� �۰ų� ���� ����� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
SELECT * FROM emp WHERE sal < 2000 OR sal > 3000;
--LIKE ������ : ����� ���ڿ� ã�� ������
--���ϵ� ī�� ���� : _ , %
-- _ : � ���ڴ� ������� �� ����
-- % : � ���ڴ� ������� ���� ����
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename LIKE '_L%';
-- ����� �̸��� ����° ���ڰ� L�� ����� ����ϴ� SQL�� �ۼ��غ�����.
SELECT * FROM emp WHERE ename LIKE '__L%';
--�̸��� ����° ���ڰ� L�� �ƴ� ����� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp WHERE ename NOT LIKE '__L%';
-- IS NULL : NULL���� �ƴ��� Ȯ���ϴ� ������
SELECT * FROM emp WHERE mgr IS NULL;
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE mgr IS NOT NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;
--UNION : �ߺ� �����ϴ� ������
SELECT * FROM emp WHERE deptno = 20
UNION
SELECT * FROM emp WHERE deptno = 30;
SELECT * FROM emp WHERE deptno IN (20,30) ORDER BY deptno;
--UNION�� �������
-- 1. ��� ���� ������ ���ƾ� �Ѵ�. 
SELECT empno, ename, sal, deptno FROM emp WHERE deptno = 20
UNION
SELECT empno, ename, sal FROM emp WHERE deptno = 30;
-- 2. ��� ���� �ڷ����� ���ƾ� �Ѵ�.
SELECT empno, ename, sal FROM emp WHERE deptno = 20
UNION
SELECT ename, empno, sal FROM emp WHERE deptno = 30;
SELECT empno, ename, sal FROM emp WHERE deptno = 20
UNION
SELECT sal, job, empno FROM emp WHERE deptno = 30;

SELECT empno, ename, job FROM emp WHERE deptno = 10
UNION
SELECT deptno, dname, loc FROM dept;     
--UNION ALL : �ߺ��� ���ŵ��� �ʴ� ������
SELECT * FROM emp WHERE deptno = 10
UNION ALL
SELECT * FROM emp WHERE deptno = 10;
--MINUS : ������
SELECT * FROM emp
MINUS
SELECT * FROM emp WHERE deptno = 10;
SELECT * FROM emp WHERE deptno !=10;
--INTERSECT : ������
SELECT * FROM emp
INTERSECT
SELECT * FROM emp WHERE deptno = 10;
--�������� �켱����
--0. ()
--1. *, /
--2. + , -
--3. �� ������, >, >=, <, <=, =, !=, <>, ^=
--4. IS NULL, LIKE, IN
--5. BETWEEN A AND B
--6. NOT
--7. AND
--8. OR

