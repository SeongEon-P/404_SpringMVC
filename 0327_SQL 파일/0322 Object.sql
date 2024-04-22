--����� ���̺� : ����ڰ� ���� ���� ���̺�
--������ ���� : �����ͺ��̽��� �����ɶ� �Բ� ������ �޸�,����,�����,����,��ü 
--             �� �����ͺ��̽� ��� �ʿ��� ������ �����ϴ� ���̺�
--������ ���� �� : ������ ������ ����Ǿ� �ִ� �����͸� ������ �� �ֵ��� ������ ��
-- USER_**** : ���� ������ ������ ������ ��ü ����
-- ALL_**** : ���� ������ ������ ������ ���� ��� ��ü ����
-- DBA_**** : �����ڱ����� ���� ������ ����� �� �ִ� ��ü ����
-- V$_**** : �����ͺ��̽� ���� ���� ����

-- � ������ ���� �䰡 �ִ��� Ȯ���ϴ� ��ɾ�
SELECT * FROM dict;
SELECT * FROM dictionary;
-- ���� ������ ������ ������ ���̺��� Ȯ���ϴ� ������ ���� ��
SELECT * FROM user_tables; --17 �ڽ��� ������ ���̺� Ȯ��
--NUM_ROWS : ���� ����, COUNT(*)�Լ��� ���� ������ Ȯ���ϸ� ���� ������ ������ �ð��� ���� �ɸ�
SELECT * FROM all_tables; --131 ������ �ִ� ���̺� Ȯ��
SELECT * FROM dba_tables; --2369 ������ �����־�� Ȯ�� ����
--13-8
SELECT * FROM user_indexes;
SELECT * FROM user_ind_columns;
--13-10
CREATE INDEX IDX_EMP_SAL
ON emp(sal);
DROP INDEX idx_emp_sal;

EXPLAIN PLAN FOR SELECT * FROM emp WHERE sal > 100;

--13-14
-- VIEW ���� ���� ����
GRANT CREATE VIEW TO SCOTT;

--13-15
CREATE VIEW vw_emp20
AS (SELECT empno, ename, job, deptno FROM emp WHERE deptno = 20);
SELECT * FROM vw_emp20;
SELECT * FROM user_views;
-- 13-19
DROP VIEW vw_emp20;

SELECT * FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);
SELECT * FROM emp
WHERE empno = 7788;
WITH
    E10 AS (SELECT * FROM emp WHERE deptno = 10)
SELECT * FROM E10;
--ROWNUM : ���ȣ�� ����ϴ� �ǻ翭, �ʿ��� ������ŭ ������ ����� �����ϴµ� ���
SELECT ROWNUM, E.* FROM emp E;
SELECT ROWNUM, E.* FROM emp E WHERE rownum <= 10 ORDER BY sal DESC;
SELECT ROWNUM, E.* FROM (SELECT * FROM emp ORDER BY sal DESC) E WHERE ROWNUM <= 10 ;
SELECT table_name,num_rows FROM user_tables WHERE table_name='EMP';
-- MAX() �Լ��� ������ȣ �����ϱ�
-- �����Ͱ� ������ ������ȣ�� ��� �ð��� ���� �ɸ���.
-- ���� �ð��� SELECT���� �����ϸ� ���� ���� �����ش�.
SELECT MAX(empno)+1 FROM emp;
--13-26
CREATE TABLE dept_sequence
AS SELECT * FROM dept WHERE 1!=1;
--13-27
CREATE SEQUENCE seq_dept_sequence
    INCREMENT BY 10 --������, �⺻�� 1
    START WITH 10 -- ���۰�, �⺻�� 1
    MAXVALUE 90 --�ִ밪
    MINVALUE 0 --�ּҰ�
    NOCYCLE -- �ݺ�����, �⺻�� CYCLE
    CACHE 2; -- �޸𸮿� �����ص� ���� ��, �⺻�� 20
SELECT * FROM user_sequences;
--������ ��� ���
--�������̸�.NEXTVAL : ���� ��ȣ�� ����ϴ� ��ɾ�
-- �ݵ�� INSERT������ �����ؾ���
INSERT INTO dept_sequence
VALUES (seq_dept_sequence.NEXTVAL,'DATABASE','SEOUL');
--������ �̸�.CURRVAL : ���������� ����� ��ȣ�� ��ȯ�ϴ� ��ɾ�
-- SELECT���� ��������ȣ�� Ȯ���� �� ��� 
SELECT seq_dept_sequence.CURRVAL FROM dual;
--13-32
ALTER SEQUENCE seq_dept_sequence
    INCREMENT BY 3
    MAXVALUE 99
    CYCLE;
--13-36
DROP SEQUENCE seq_dept_sequence;
--13-37 system �������� ����
GRANT CREATE SYNONYM, CREATE PUBLIC SYNONYM TO SCOTT;
--���Ǿ� ����
CREATE SYNONYM E
FOR emp;
SELECT * FROM e;
--���Ǿ� ����
DROP SYNONYM e;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

--13�� ��������
--1-1
CREATE TABLE empidx
AS SELECT * FROM emp;
--1-2
CREATE INDEX idx_empidx_empno
ON empidx(empno);
--1-3
SELECT * FROM user_indexes;
SELECT * FROM user_ind_columns;
--2
CREATE VIEW empidx_over15k
AS (SELECT empno, ename, job, deptno, sal, NVL2(comm,'O','X') AS comm 
    FROM empidx WHERE sal>1500);
SELECT * FROM empidx_over15k;
--3-1
CREATE TABLE deptseq AS SELECT * FROM dept;
--3-2
CREATE SEQUENCE seq_deptseq_deptno
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99
    MINVALUE 1
    NOCYCLE
    NOCACHE;
--3-3
INSERT INTO deptseq (deptno, dname, loc)
VALUES (seq_deptseq_deptno.NEXTVAL, 'DATABASE','SEOUL');
INSERT INTO deptseq (deptno, dname, loc)
VALUES (seq_deptseq_deptno.NEXTVAL, 'WEB','BUSAN');
INSERT INTO deptseq (deptno, dname, loc)
VALUES (seq_deptseq_deptno.NEXTVAL, 'MOBILE','ILSAN');
SELECT * FROM deptseq;











