--10-1 ���̺� �����ϱ� , ���������� ������� ����
CREATE TABLE dept_temp
AS SELECT * FROM dept;
--INSERT�� : ���̺� �����͸� �߰��ϴ� SQL��
INSERT INTO ���̺� �̸� (���̸�, ���̸�, ���̸�) VALUES (������, ������, ������);
--10-3
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (50,'DATABASE','SEOUL');
SELECT * FROM dept_temp;
-- INSERT�� ������ ������
--1. ���� ������ ���� ���� ��
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (60,'NETWORK');
--2. ������ ������ �����Ͱ� ���� ��
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (60,'NETWORK','BUSAN','WRONG');
--3. ������ Ÿ���� ���� �ٸ� ��
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES ('WRONG','NETWORK','BUSAN');
--4. ������ ���̰� ���� ���� ��
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (100,'NETWORK','BUSAN');
                
-- 10-4 �� ���� ���� ������ �߰��ϱ�
-- SQL Developer ���� �׽�Ʈ ������ �������α׷����� �����ϴ� ���
-- ���� �������� �����Ҷ� ��� ���� ���°��� ���� �˴ϴ�.
INSERT INTO dept_temp
    VALUES(60,'NETWORK','BUSAN');
SELECT * FROM dept_temp;

-- ���̺� NULL������ �Է��ϱ�
-- NULL�� ����� �Է� 10-5,10-6
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (70,'WEB',NULL);
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (80,'MOBILE','');
-- NULL�� �Ͻ��� �Է�
INSERT INTO dept_temp (deptno, loc)
VALUES (90,'INCHEON');
-- ���̺��� �����͸� ������ ���̺� ������ �����ϱ�
CREATE TABLE emp_temp
AS SELECT * FROM emp WHERE 1<>1;
SELECT * FROM emp_temp;
-- ��¥ ������ �߰��ϱ�
--10-9
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999,'ȫ�浿','PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (1111,'������','MANAGER', 9999, '2001-01-05', 4000, NULL, 20);
SELECT * FROM emp_temp;
--10-11
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2111,'�̼���','MANAGER', 9999, '07/01/2001', 4000, NULL, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2111,'�̼���','MANAGER', 9999, TO_DATE('07/01/2001','DD/MM/YYYY'), 4000, NULL, 20);
SELECT * FROM emp_temp;
--10-13
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3111,'��û��','MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM emp_temp;

--10-14
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm, E.deptno
    FROM emp E INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
    WHERE S.grade = 1;
SELECT * FROM emp_temp;
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT * FROM emp;

--UPDATE : ���̺� ������ �����ϱ�
CREATE TABLE dept_temp2
    AS SELECT * FROM dept;
-- UPDATE  ���̺��̸� SET ���̸� = �����ۼ� WHERE ���̸� = ���ǰ�
--10-16
UPDATE dept_temp2
    SET loc = 'SEOUL';
SELECT * FROM dept_temp2;
ROLLBACK;

-- 10-18 ������ �Ϻκи� �����ϱ�
UPDATE dept_temp2
   SET dname = 'DATABASE',
       loc = 'SEOUL'
 WHERE deptno = 40;
SELECT * FROM dept_temp2 WHERE deptno = 40;
--10-19
UPDATE dept_temp2
SET (dname, loc) = (SELECT dname, loc FROM dept WHERE deptno = 40)
WHERE deptno = 40;
SELECT * FROM dept_temp2;
-- 10-21
UPDATE dept_temp2
SET loc = 'SEOUL'
WHERE deptno = (SELECT deptno FROM dept_temp2 WHERE dname='OPERATIONS');
SELECT * FROM dept_temp2;

--DELETE : ���̺� ������ ���� 
CREATE TABLE emp_temp2
    AS SELECT * FROM emp;
SELECT * FROM emp_temp2;
-- DELETE FROM ���̺��̸�; ���̺��� ��� ���� ����
--10-23 
DELETE FROM emp_temp2
    WHERE job = 'MANAGER';
SELECT * FROM emp_temp2 WHERE job = 'MANAGER';
--10-24
DELETE FROM emp_temp2
WHERE empno IN (SELECT E.empno FROM emp_temp2 E
                INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                AND S.grade = 3
                AND E.deptno = 30);

SELECT * FROM emp_temp2 E
                INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                AND S.grade = 3
                AND E.deptno = 30;

--10�� ��������
CREATE TABLE chap10hw_emp AS SELECT * FROM emp;
CREATE TABLE chap10hw_dept AS SELECT * FROM dept;
CREATE TABLE chap10hw_salgrade AS SELECT * FROM salgrade;
--1
INSERT INTO chap10hw_dept VALUES(50,'ORACLE','BUSAN');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(60,'SQL','ILSAN');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(70,'SELECT','INCHEON');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(80,'DML','BUNDANG');
SELECT * FROM chap10hw_dept;
--2
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7201,'TEST_USER1','MANAGER',7788,TO_DATE('2016-01-02','YYYY-MM-DD'),4500,NULL,50);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7202,'TEST_USER2','CLERK',7201,TO_DATE('2016-02-21','YYYY-MM-DD'),1800,NULL,50);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7203,'TEST_USER3','ANALYST',7201,TO_DATE('2016-04-11','YYYY-MM-DD'),3400,NULL,60);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7204,'TEST_USER4','SALESMAN',7201,TO_DATE('2016-05-31','YYYY-MM-DD'),2700,300,60);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7205,'TEST_USER5','CLERK',7201,TO_DATE('2016-07-20','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7206,'TEST_USER6','CLERK',7201,TO_DATE('2016-09-08','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7207,'TEST_USER7','LECTURER',7201,TO_DATE('2016-10-28','YYYY-MM-DD'),2300,NULL,80);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7208,'TEST_USER8','STUDENT',7201,TO_DATE('2018-03-09','YYYY-MM-DD'),1200,NULL,80);
SELECT * FROM chap10hw_emp;
--3
UPDATE chap10hw_emp
SET deptno = 70
WHERE sal > (SELECT AVG(sal) FROM chap10hw_emp WHERE deptno = 50);
SELECT * FROM chap10hw_emp;
SELECT * FROM chap10hw_emp WHERE sal > (SELECT AVG(sal) FROM chap10hw_emp WHERE deptno = 50);
--4
UPDATE chap10hw_emp 
SET sal = sal*1.1,
    deptno = 80
WHERE hiredate > (SELECT MIN(hiredate) FROM chap10hw_emp WHERE deptno = 60);
SELECT * FROM chap10hw_emp WHERE hiredate > (SELECT MIN(hiredate) FROM chap10hw_emp WHERE deptno = 60);
--5
DELETE FROM chap10hw_emp
WHERE empno IN (SELECT empno FROM chap10hw_emp E 
                INNER JOIN chap10hw_salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                WHERE S.grade = 5);
SELECT * FROM chap10hw_emp;
SELECT * FROM chap10hw_emp E 
                INNER JOIN chap10hw_salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                WHERE S.grade = 5;


CREATE TABLE chap10hw_emp2 AS SELECT * FROM emp WHERE 1!=1;
SELECT * FROM chap10hw_emp2;



