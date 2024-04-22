-- ����� ���̺� : ����ڰ� ���� ���� ���̺�
-- ������ ���� : �����ͺ��̽��� ������ �� �Բ� ������ �޸�, ����, �����, ����, ��ü ��
--              �����ͺ��̽� ��� �ʿ��� ������ �����ϴ� ���̺�
-- ������ ���� �� : ������ ������ ����Ǿ� �ִ� �����͸� ������ �� �ֵ��� ������ ��
-- USER_**** : ���� ������ ������ ������ ��ü ����
-- ALL_**** : ���� ������ ������ ������ ���� ��� ��ü ����
-- DBA-**** : ������ ������ ���� ������ ����� �� �ִ� ��ü ����
-- V$_**** : �����ͺ��̽� ���� ���� ����

-- � ������ ���� �䰡 �ִ��� Ȯ���ϴ� ��ɾ�
-- 13-1 
SELECT * FROM dict;
SELECT * FROM dictionary;

-- ���� ������ ������ ������ ���̺��� Ȯ���ϴ� ������ ���� ��
SELECT * FROM user_tables; -- 17�� �ڽ��� ������ ���̺� Ȯ��
-- NUM_ROWS : ���� ����, COUNT(*)�Լ��� ���� ������ Ȯ���ϸ� ���� ������ ������ �ð��� ���� �ɸ�
SELECT * FROM all_tables; -- 131�� ������ �ִ� ���̺� Ȯ��
SELECT * FROM dba_tables; -- ������ ������ ���� ������ Ȯ���� �� ����, system �������� ���� ����. scott���������� �Ⱥ���


-- PK(Primary Key)�� �˻��� �� ���� ����Ѵ�(�ε��� ���).


-- 13-8 : SCOTT������ ������ �ε��� ���� �˾ƺ���(SCOTT ������ ��)
SELECT * FROM user_indexes;
-- 13-9 : SCOTT������ ������ �ε��� �÷� ���� �˾ƺ���(SCOTT ������ ��)
SELECT * FROM user_ind_columns;

-- 13-10 : EMP ���̺��� SAL ���� �ε����� �����ϱ�
CREATE INDEX IDX_EMP_SAL ON emp(sal);  --IDX_���̺��̸�_�÷��̸�ON ���̺��̸�(�÷��̸�);
-- sal�� �ε����� �ϴ°� ������. �ֳ��ϸ� �ߺ��Ǵ� �����Ͱ� �־ �ε����� ������ �� ����. comm�� �����Ͱ� ���Ƽ� �ε����� ������. empno������ �ε����� ����. �׷��� pk�� �����ϸ� �ڵ����� �ε����� �ȴٰ���.
SELECT*FROM user_indexes;
SELECT*FROM user_ind_columns;
DROP INDEX idx_emp_sal;

-- 13-14 : �並 �����ϱ� ���� ���� ���� �����ϱ�.systemp�������� �ؾ���
GRANT CREATE VIEW TO SCOTT;

-- 13-15 : �� �����ϱ�(���)
CREATE VIEW vw_emp20
AS (SELECT empno, ename, job, deptno FROM emp WHERE deptno = 20);

SELECT * FROM vw_emp20;

SELECT * FROM user_views;

-- 13-19 : �� ����
DROP VIEW vw_emp20;

-- �ζ��� ��
SELECT * FROM emp --�̰Ŵ� ���� ����
WHERE sal > (SELECT AVG(sal) FROM emp); -- �̰� ��ȣ ���� �ζ��� �� �����.

WITH E10 AS (SELECT * FROM emp WHERE deptno = 10)
SELECT * FROM E10; -- �̰͵� �ζ��� �� ����ߴٰ���

-- 13-20 :  ROWNUM�� �߰��� ��ȸ�ϱ�, ROWNUM�� ���ȣ�� ����ϴ� �ǻ翭. �ʿ��� ������ŭ ������ ����� �����ϴµ� ���
SELECT ROWNUM, E.*FROM emp E;
SELECT ROWNUM, E.*FROM emp E WHERE rownum <= 10 ORDER BY sal DESC; --�̷����ϸ�, ROWNUM�� ���׹��׵�
SELECT table_name,num_rows FROM user_tables WHERE table_name='EMP';
SELECT ROWNUM, E.* FROM (SELECT * FROM emp E ORDER BY sal DESC) E WHERE ROWNUM <= 10;

-- MAX() �Լ��� ���� ��ȣ �����ϱ�
-- �����Ͱ� ������ ���� ��ȣ�� ��� �ð��� ���� �ɸ���
-- ���� �ð��� SELECT���� �����ϸ� ���� ���� �����ش�
SELECT MAX(empno)+1 FROM emp;

-- 13-26 : DEPT ���̺��� ����Ͽ� DEPT_SEQUENCE ���̺� �����ϱ�
CREATE TABLE dept_sequence
AS SELECT * FROM dept WHERE 1!=1; --1!=1 �κ��� �׻� ������ �Ǵ� ����, dept_sequence�� ����������, ������ dept ���̺��� ��� �����͵� �� ���̺� �������� ������ �� �� ���
SELECT * FROM dept_sequence;

-- 13-27 : ������ �����ϱ�
CREATE SEQUENCE seq_dept_sequence
    INCREMENT BY 10 --������, �⺻��:1
    START WITH 10 --���۰�, �⺻��:1
    MAXVALUE 90 --�ִ밪, �⺻��:10^27���� �ö� �� ����
    MINVALUE 0 --�ּҰ�, �⺻��:���� ����
    NOCYCLE  --�ݺ����� �ʴ´ٴ� �ǹ�, �⺻��:CYCLE
    CACHE 2; --�޸𸮿� �����ص� ���� ����. 2��� �������ϱ�, ���⼭�� 10,20 / 20,30 / �̷���.
             --CACHE�� �ƹ��͵� �������ϸ� �⺻��20.
SELECT * FROM user_sequences;

-- ������ ��� ���
-- �������̸�.NEXTVAL : ���� ��ȣ�� ����ϴ� ��ɾ�
-- NEXTVAL�� �ݵ�� INSERT������ �����ؾ���. SELECT������ �����ϸ�, �ϳ��� ������� ������� ����.
INSERT INTO dept_sequence
VALUES (seq_dept_sequence.NEXTVAL,'DATABASE','SEOUL');
-- ������ �̸�.CURRVAL : ���������� ����� ��ȣ�� �˷���.
-- SELECT���� ��������ȣ�� Ȯ���� �� ����ϴ� ��ɾ�
SELECT seq_dept_sequence.CURRVAL FROM dual;

-- 13-32 : ������ �ɼ� �����ϱ�
ALTER SEQUENCE seq_dept_sequence
    INCREMENT BY 3
    MAXVALUE 99
    CYCLE;
--PK(Primary Key)���� ���صθ�, �ߺ��� ���� ���ͼ� ���� �� �� ����.
    
SELECT * FROM user_sequences;

-- 13-36 : ������ ���� �� Ȯ���ϱ�
DROP SEQUENCE seq_dept_sequence;


-- 13-37 : ���� �ο��ϱ�. system�������� �����ؾ���
GRANT CREATE SYNONYM, CREATE PUBLIC SYNONYM TO SCOTT; -- CREATE PUBLIC SYNONYM�� SCOTT���� �Ӹ� �ƴ϶� �ٸ� ������ �� ���ְ� �ϴ°�
--13-38 : ���Ǿ� ����
CREATE SYNONYM E  --���� �̷��� �ѱ��ڷ� ������ ����
FOR emp;

SELECT * FROM e; 

-- ���Ǿ� ����
DROP SYNONYM e;


-- 357~358p, 13�� ��������, Q1~4
-- Q1. ���� �� ������ ������ emp_hw ���̺��� ����� ������.
--1)EMP ���̺�� ���� ������ �����͸� �����ϴ� EMPIDX���̺��� ��������.
CREATE TABLE EMPIDX
AS SELECT * FROM emp WHERE 1!=1;
--2)������ EMPIDX ���̺��� EMPNO���� IDX_EMPIDX_EMPNO �ε����� ����� ������.
CREATE INDEX IDX_EMPIDX_EMPNO ON EMPIDX(EMPNO);
--3)���������� �ε����� �� �����Ǿ����� ������ ������ ���� �並 ���� Ȯ���غ�����.
SELECT*FROM user_indexes;
SELECT*FROM user_ind_columns;

-- Q2. ���� 1������ ������ EMPIDX ���̺��� ������ �� �޿�(SAL)�� 1500 �ʰ��� ����鸸 ����ϴ�
--     EMPIDX_OVER15K �並 ������ ������. �� �̸��� ���� �䰡 �̹� ������ ��쿡 ���ο� ��������
--     ��ü �����ؾ� �մϴ�. EMPIDX_OVER15K ��� ��� ��ȣ, ��� �̸�, ��å, �μ� ��ȣ, �޿�,
--     �߰� ���� ���� ������ �ֽ��ϴ�. �߰� ���� ���� ��쿡 �߰� ������ �����ϸ� O, �������� ������ X�� ����մϴ�.
CREATE OR REPLACE VIEW EMPIDX_OVER15K --'OR REPLACE' �̰�, �̸� �Ȱ����� ������ ����� �ϰڴٴ� ����
AS (SELECT empno, ename, job, deptno, sal, NVL2(comm, 'O', 'X') As comm
    FROM empidx WHERE sal > 1500);
SELECT * FROM EMPIDX_OVER15K;

-- Q3.���� ������ sql���� �ۼ��غ�����.
-- 1)DEPT ���̺�� ���� ���� �� ������ ������ DEPTSEQ ���̺��� �ۼ��غ�����.
CREATE TABLE DEPTSEQ
AS SELECT * FROM dept;
--2)������ DEPTSEQ���̺��� DEPTNO ���� ����� �������� ������ Ư���� �°� ������ ������.
CREATE SEQUENCE seq_DEPTSEQ
    INCREMENT BY 1 --������, �⺻��:1
    START WITH 1 --���۰�, �⺻��:1
    MAXVALUE 99 --�ִ밪, �⺻��:10^27���� �ö� �� ����
    MINVALUE 1 --�ּҰ�, �⺻��:���� ����
    NOCYCLE  --�ݺ����� �ʴ´ٴ� �ǹ�, �⺻��:CYCLE
    NOCACHE ; --�޸𸮿� �����ص� ���� ����. 2��� �������ϱ�, ���⼭�� 10,20 / 20,30 / �̷���.
             --CACHE�� �ƹ��͵� �������ϸ� �⺻��20.

SELECT * FROM user_sequences;

--3)���������� ������ DEPTSEQ�� ����Ͽ� �����ʰ� ���� �� �� �μ��� ���ʴ�� �߰��� ������.

-- ������ ��� ���
-- �������̸�.NEXTVAL : ���� ��ȣ�� ����ϴ� ��ɾ�
-- NEXTVAL�� �ݵ�� INSERT������ �����ؾ���. SELECT������ �����ϸ�, �ϳ��� ������� ������� ����.
INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'DATABASE','SEOUL');

INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'WEB','BUSAN');

INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'MOBILE','ILSAN');

SELECT*FROM DEPTSEQ;

















































