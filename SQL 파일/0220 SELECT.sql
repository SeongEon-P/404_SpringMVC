--DESC ���̺��̸� : ���̺��� ������ �ľ��ϴ� SQL��
DESC salgrade;
--SELECT : �����ͺ��̽��� �����Ǿ� �ִ� �����͸� ��ȸ�� �� ����ϴ� SQL��
SELECT * FROM emp;
SELECT empno, ename, deptno FROM emp;
--DISTINCT : ���� �ߺ��� �����ϰ� ����ϴ� SQL��
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT job, deptno FROM emp;
SELECT DISTINCT empno FROM emp;
SELECT ALL job, deptno FROM emp;
SELECT job, deptno FROM emp;
--�� �̸��� ������ �� ��Ī ���ϱ�
SELECT ename, sal, sal*12+comm AS YEAR, comm FROM emp;
-- ORDER BY : SELECT������ ������ ��ȸ�� ���������̳� �������� ������ �ϴ� SQL��
SELECT * FROM emp ORDER BY deptno;
SELECT * FROM emp ORDER BY deptno ASC;
SELECT * FROM emp ORDER BY deptno DESC;
SELECT * FROM emp ORDER BY deptno, sal DESC, empno DESC;

--4�� ��������
--2
SELECT DISTINCT job FROM emp;
--3
SELECT 
    empno AS EMPLOYEE_NO,
    ename AS EMPLOYEE_NAME,
    job,
    mgr AS MANAGER,
    hiredate,
    sal AS SALARY,
    comm AS COMMISSION,
    deptno AS DEPARTMENT_NO
FROM emp
ORDER BY 
    deptno DESC
    , ename;


