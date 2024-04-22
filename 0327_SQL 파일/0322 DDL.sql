--12-1
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
--12-4 
CREATE TABLE emp_ddl_30
AS SELECT * FROM emp WHERE deptno = 30;

--12-5
CREATE TABLE empdept_ddl
AS SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm, D.deptno,D.dname,D.loc
FROM emp E INNER JOIN dept D ON E.deptno = D.deptno
WHERE 1<>1;
SELECT * FROM empdept_ddl;
--12-6
CREATE TABLE emp_alter
AS SELECT * FROM emp;
--12-7
ALTER TABLE emp_alter
ADD hp VARCHAR2(20);
SELECT * FROM emp_alter;
--12-8
ALTER TABLE emp_alter
RENAME COLUMN hp TO tel;
--12-9 이미 존재하는 데이터가 변경하려는 타입의 길이보다 크다면 변경 불가능
ALTER TABLE emp_alter
MODIFY empno NUMBER(5);
DESC emp_alter;
--12-10
ALTER TABLE emp_alter
DROP COLUMN tel;
--12-11
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_alter;
SELECT * FROM emp_rename;
--12-14 DELETE문에 WHERE적지 않은것과 같이 모든 데이터를 삭제하지만 트랜잭션을 영향을 받지 않는 SQL문
TRUNCATE TABLE emp_rename;
SELECT * FROM emp_rename;
ROLLBACK;
--12-15
DROP TABLE emp_rename;

--12장 연습문제
--1
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
DESC emp_hw;
--2
ALTER TABLE emp_hw
ADD bigo VARCHAR2(20);
--3
ALTER TABLE emp_hw
MODIFY bigo VARCHAR2(30);
--4
ALTER TABLE emp_hw
RENAME COLUMN bigo TO REMARK;
--5
INSERT INTO emp_hw
SELECT empno, ename, job, mgr,hiredate, sal, comm, deptno, NULL FROM emp;
DELETE FROM emp_hw;
INSERT INTO emp_hw (empno, ename, job, mgr,hiredate, sal, comm, deptno)
SELECT * FROM emp;
INSERT INTO emp_hw (empno, ename, job, mgr,hiredate, sal, comm, deptno, remark)
SELECT empno, ename, job, mgr,hiredate, sal, comm, deptno,NULL FROM emp;
--6
DROP TABLE emp_hw;
SELECT * FROM emp_hw;




