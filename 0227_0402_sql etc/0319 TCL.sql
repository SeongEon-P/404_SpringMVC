-- 11-1 : DEPT���̺��� �����ؼ� DEPT_TCL ���̺� �����
CREATE TABLE dept_tcl
AS SELECT * FROM dept;

-- 11-2 : DEPT_TCL ���̺� �����͸� �Է�, ����, �����ϱ�
INSERT INTO dept_tcl VALUES (50, 'DATABASE', 'SEOUL');
UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno = 40;
DELETE FROM dept_tcl WHERE dname = 'RESEARCH';
SELECT * FROM dept_tcl;
ROLLBACK;   
COMMIT;

-- 11-6 : ���� SQL*PLUS�� ���� �˾ƺ���
SELECT * FROM dept_tcl;

-- 11-7 
DELETE FROM dept_tcl WHERE deptno = 50;
COMMIT;

-- 11-9 : ���� SQL*PLUS�� LOCK �˾ƺ���
SELECT * FROM dept_tcl;

-- 11-10 : ���� SQL*PLUS�� LOCK �˾ƺ���
UPDATE dept_tcl SET loc = 'SEOUL' WHERE deptno = 30;
SELECT * FROM dept_tcl;

-- 11-11 : ���� SQL*PLUS�� LOCK �˾ƺ���
-- UPDATE dept_tcl SET dname = 'DATABASE' WHERE deptno = 30; // �̰Ŵ� CMDâ SQLPLUS���� �����ߴµ�,
-- ORACLE���� ���� UPDATE ����ϸ�, COMMIT�ϱ� �������� LOCK�ɷ��� SQLPLUS������ �ƹ��� ���� ����
COMMIT;
SELECT * FROM dept_tcl;

-- UPDATE �� DELETE��, WHERE���� ����ϸ� �ȵȴ�. ���� ����ϸ� ���̺� ������ �� LOCK�� �ɷ��� �׷���.

-- 309p, 11�� ��������, Q1
DROP TABLE dept_hw; -- ������ ���� ������� ���̺� ����� �ڵ�
CREATE TABLE dept_hw AS SELECT * FROM dept; -- ���̺� ����(����, ������ ����)
-- INSERT INTO dept_hw SELECT * FROM dept; -- �����͸� �����ϴ� �ڵ�
SELECT * FROM dept_hw; --�׳� Ȯ�� �� �� �غ�

UPDATE dept_HW SET dname = 'DATABASE', loc = 'SEOUL' WHERE deptno = 30;
SELECT * FROM dept_hw;

ROLLBACK;

SELECT * FROM dept_hw;




