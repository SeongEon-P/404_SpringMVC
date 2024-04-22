--11-1
CREATE TABLE dept_tcl
 AS SELECT * FROM dept;
--11-2
INSERT INTO dept_tcl VALUES (50,'DATABASE','SEOUL');
UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno = 40;
DELETE FROM dept_tcl WHERE dname = 'RESEARCH';
SELECT * FROM dept_tcl;
ROLLBACK;
COMMIT;

--11-6
SELECT * FROM dept_tcl;
--11-7
DELETE FROM dept_tcl WHERE deptno = 50;
COMMIT;
--11-9
SELECT * FROM dept_tcl;
--11-10
UPDATE dept_tcl SET loc = 'SEOUL' WHERE deptno = 30;
COMMIT;

--11장 연습문제
CREATE TABLE dept_hw 
AS SELECT * FROM dept;
SELECT * FROM dept_hw;
--1
UPDATE dept_hw
SET dname='DATABASE', loc = 'SEOUL'
WHERE deptno = 30;
SELECT * FROM dept_hw;
-- 1: DATABASE , 2: SEOUL
-- 3: SALES    , 4:CHICAGO
--2
ROLLBACK;
SELECT * FROM dept_hw;
--4 1:SALES 2:CHICAGO
--  3:DATABASE 4:SEOUL
SELECT * FROM dept_hw;
--5 1:DATABASE 2:SEOUL
--  3:DATABASE 4:SEOUL















 