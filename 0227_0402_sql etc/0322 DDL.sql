--CREATE TABLE SCOTT.DEPT_TEST
-- 12-1 : ��� ���� �� �ڷ����� �����ؼ� ���̺� �����ϱ�
CREATE TABLE emp_ddl(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2)
);

DESC emp_ddl;

-- 12-4 : �ٸ� ���̺��� �Ϻθ� �����Ͽ� ���̺� �����ϱ�
CREATE TABLE emp_ddl_30 AS SELECT *FROM emp
WHERE deptno = 30;

SELECT*FROM emp_ddl_30;

-- 12-5 : �ٸ� ���̺��� �����Ͽ� ���̺� �����ϱ�
CREATE TABLE empdept_ddl AS SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate,
                E.sal, E.comm, D.deptno, D.dname, D.loc FROM emp E
                INNER JOIN dept D ON E.deptno = D.deptno
                WHERE 1<>1;

SELECT * FROM empdept_ddl;


CREATE TABLE emp_alter AS SELECT*FROM emp;

-- 12-7 : ALTER ��ɾ�� HP �� �߰��ϱ�
ALTER TABLE emp_alter
ADD hp VARCHAR2(20); -- 20�� 20����Ʈ ��� ��

SELECT * FROM emp_alter;

-- 12-8 : ALTER ��ɾ�� HP �� �̸��� TEL�� �����ϱ�
ALTER TABLE emp_alter RENAME COLUMN hp TO tel;
SELECT * FROM emp_alter;

-- 12-9 : ALTER ��ɾ�� EMPNO �� ���� �����ϱ�
ALTER TABLE emp_alter MODIFY empno NUMBER(5);  --���� NUMBER(4)���� �� 4�ڸ� ���ڰ� �־��µ�, 3���� �������� ����. �̹� 4�ڸ� �����Ͱ� �־����ϱ�. ������ �������� ��.
SELECT * FROM emp_alter;

-- 12-10 : ALTER ��ɾ�� TEL �� �����ϱ�
ALTER TABLE emp_alter DROP COLUMN tel;  --ddl(���Ǿ�)�� transaction�̶� ��� ���, �����ϴ� ���� �ٷιٷ� ����ȴ�. commit�� �ʿ����� ���Ͻô� ��.
SELECT * FROM emp_alter;

-- 12-11 : ���̺� �̸� �����ϱ�
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_alter;
SELECT * FROM emp_rename;


-- 12-14 : EMP_RENAME ���̺��� ��ü ������ �����ϱ�(TRUNCATE�� DDL�̶� �ٷ� �����. transaction�̶� ��� ����.)
SELECT * FROM emp_rename;
TRUNCATE TABLE emp_rename; -- delete���� where���� ���� ���� �Ͱ� ���� ��� �����͸� ����������,�ٸ� ����, transaction�� ������ ���� �ʴ� sql���̴�)
ROLLBACK; --TRUNCATE�� transaction�� ������ �ȹޱ� ������, rollback�ص� ������ �����Ͱ� �ȵ��ƿ´�. delete�� rollback�ϸ� ���ƿ�.


-- 12-15 : emp_rename ���̺� �����ϱ�
DROP TABLE emp_rename; -- transaction�� �ƴ϶� drop�ϴ� ���� �׳� �� ������. (transaction�� inser, update, delete�� �ش��)
SELECT * FROM emp_rename;

-- 324~325p, 12�� ��������, Q1~6
-- Q1. ���� �� ������ ������ emp_hw ���̺��� ����� ������.
CREATE TABLE emp_hw(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2)
);
SELECT * FROM emp_hw;
DESC emp_hw; --������ ���� ������ ������


-- Q2. emp_hw ���̺� bigo ���� �߰��� ������. bigo ���� �ڷ����� ������ ���ڿ��̰�, ���̴� 20�Դϴ�.
ALTER TABLE emp_hw ADD bigo VARCHAR2(20); -- 20�� 20����Ʈ ��� ��
SELECT * FROM emp_hw;

-- Q3. emp_hw ���̺��� bigo �� ũ�⸦ 30���� �����غ�����. 
ALTER TABLE emp_hw MODIFY bigo VARCHAR2(30);
SELECT * FROM emp_hw;

-- Q4. emp_hw ���̺��� bigo �� �̸��� remark�� �����غ�����.
ALTER TABLE emp_hw RENAME COLUMN bigo TO remark;
SELECT * FROM emp_hw;

-- Q5. emp_hw ���̺� emp ���̺��� �����͸� ��� ������ ������. ��, remark ���� null�� �����մϴ�.

--���� �� ����(�⺻������ �������� ����� ���� �� �����ִ°� ���ٰ���)
INSERT INTO emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
            SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, null
            FROM emp;
            
--�������� �� ����
--1)
INSERT INTO emp_hw
            SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, null
            FROM emp;          
--2)            
INSERT INTO emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            SELECT * FROM emp;          
            
SELECT * FROM emp_hw;

-- Q6. ���ݱ��� ����� emp_hw ���̺��� ������ ������.
DROP TABLE emp_hw;
SELECT * FROM emp_hw;











