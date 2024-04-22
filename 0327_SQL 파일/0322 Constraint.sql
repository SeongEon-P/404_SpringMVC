--��������
--NOT NULL : NULL�� ������ �� ������ �ϴ� ��������
--���̺� ����
CREATE TABLE table_notnull(
    login_id VARCHAR2(20) CONSTRAINT tb_lgnid_nn NOT NULL,
    login_pwd VARCHAR2(20) NOT NULL,
    tel VARCHAR2(20)
);
DESC table_notnull;
--������ �������� �������� Ȯ��
SELECT * FROM user_constraints;
--14-2
INSERT INTO table_notnull (login_id,login_pwd, tel)
VALUES ('TEST_ID_01',NULL, '010-1234-5678');
--14-3
INSERT INTO table_notnull (login_id, tel)
VALUES ('TEST_ID_01', '010-1234-5678');
INSERT INTO table_notnull (login_id, login_pwd)
VALUES ('TEST_ID_01', '1234');
--14-4
UPDATE table_notnull
SET login_pwd = NULL
WHERE login_id = 'TEST_ID_01';
--14-6
CREATE TABLE table_notnull2(
    login_id VARCHAR2(20) CONSTRAINT tblnn2_lgnid_nn NOT NULL,
    login_pwd VARCHAR2(20) CONSTRAINT tblnn2_lgnpw_nn NOT NULL,
    tel VARCHAR2(20)
);
--14-7
ALTER TABLE table_notnull
MODIFY (tel NOT NULL);
--14-8
UPDATE table_notnull
SET tel = '010-1234-5678'
WHERE login_id = 'TEST_ID_01';
--14-10
ALTER TABLE table_notnull2
MODIFY (tel CONSTRAINT tblnn_tel_nn NOT NULL);
--14-12
ALTER TABLE table_notnull2
RENAME CONSTRAINT tblnn_tel_nn TO tblnn2_tel_nn;
--14-13
ALTER TABLE table_notnull2
DROP CONSTRAINT tblnn2_tel_nn;
SELECT * FROM user_constraints;
--UNIQUE : �������� �ߺ��� ������� �ʰ� NULL���� �Է��� ������ ��������
CREATE TABLE table_unique(
    login_id VARCHAR2(20) CONSTRAINT tblunq_lgnid_unq UNIQUE,
    login_pwd VARCHAR2(20) CONSTRAINT tblunq_lgnpw_nn NOT NULL,
    tel VARCHAR2(20)
);
--14-19
INSERT INTO table_unique
VALUES (NULL, 'PWD01','010-1234-5678');
SELECT * FROM table_unique;
--14-20
UPDATE table_unique
SET login_id = 'TEST_ID_03'
WHERE login_id IS NULL;
--PRIMARY KEY(�⺻Ű, ��Ű, PK)�� Ư¡
-- UNIQUE, NOT NULL�� Ư���� ������. �ߺ����� �ʰ� NULL�� ������ �� ���� �� 
-- ���̺�� �ϳ��� ���� ������ �� �ִ�.
-- �⺻Ű�� �����ϸ� �ڵ����� �ε����� �����ȴ�.
CREATE TABLE table_pk(
    login_id VARCHAR2(20) CONSTRAINT tblpk_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) CONSTRAINT tblpk_lgnpw_nn NOT NULL,
    tel VARCHAR2(20)
);
SELECT * FROM user_constraints WHERE table_name = 'TABLE_PK';
SELECT * FROM user_ind_columns WHERE table_name = 'TABLE_PK';
-- PK�� �ߺ��� �Է�
INSERT INTO table_pk VALUES ('TEST_ID_01','1234','010-1234-5678');
SELECT * FROM table_pk;
-- PK�� NULL�� �Է��ϱ�
INSERT INTO table_pk VALUES (NULL,'1234','010-1234-5678');
SELECT * FROM table_pk;
-- ���̺� ���� ���� ���� ���� ��� : NOT NULL�� ��� �Ʒ��ʿ��� ������ �� ����
CREATE TABLE table_name(
    col1 VARCHAR2(20),
    col2 VARCHAR2(20) NOT NULL,
    col3 VARCHAR2(20),
    PRIMARY KEY(col1),
    CONSTRAINT constraint_name UNIQUE(col2) 
);
--14-37
-- FOREIGN KEY(�ܷ�Ű, FK) : �ٸ� ���̺��� �⺻Ű�� �����ϴ� ��
-- �����ϰ��ִ� ���� ���� �����ʹ� �߰��� �� ����.
SELECT owner, constraint_name, constraint_type, table_name, r_owner, r_constraint_name
FROM user_constraints
WHERE table_name IN ('EMP','DEPT');
INSERT INTO emp 
VALUES (9999,'ȫ�浿','CLERK',7788, TO_DATE('2017/04/30','YYYY/MM/DD'),1200, NULL, 40);
SELECT * FROM emp WHERE deptno = 40;
-- 14-39
CREATE TABLE dept_fk(
    deptno NUMBER(2) CONSTRAINT deptfk_deptno_pk PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
CREATE TABLE emp_fk(
    empno NUMBER(4) CONSTRAINT empfk_empno_pk PRIMARY KEY,
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2) CONSTRAINT empfk_deptno_nn NOT NULL
    ,CONSTRAINT empfk_deptno_fk FOREIGN KEY(deptno) REFERENCES dept_fk(deptno)
);
SELECT * FROM dept_fk;
SELECT * FROM emp_fk;
INSERT INTO emp_fk
VALUES (9999,'TEST_NAME', 'TEST_JOB',NULL, TO_DATE('2001/01/01','YYYY/MM/DD'),3000,NULL,10);
INSERT INTO emp_fk
VALUES (9991,'TEST_NAME2', 'TEST_JOB2',NULL, TO_DATE('2001/01/02','YYYY/MM/DD'),4000,NULL,NULL);
INSERT INTO dept_fk
VALUES (10,'TEST_DNAME','TEST_LOC');
--14-44
-- �ٸ� ���̺��� �ܷ�Ű�� ���� �����ϰ� �ְ� �̹� �ڽ� ���ڵ尡 �߰��Ǿ� �ִٸ� ������ �� ����
-- 1. ���� �����Ϸ��� �� ���� �����ϴ� �����͸� ���� �����Ѵ�. �ڽ� ���ڵ带 �����ϰ� �θ�Ű�� ����
    --dept_fk�� �����͸� �����Ҷ� �����ϴ� �����͵� �Բ� �����ϴ� �ɼ�
    deptno CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE CASCADE
-- 2. ���� �����Ϸ��� �� ���� �����ϴ� �����͸� �����Ѵ�. �ڽķ��ڵ� NULL�̳� �θ�Ű�ʹ� �ٸ� �����ͷ� ����
    -- dept_fk�� �����͸� �����Ҷ� �����ϴ� �����͸� ��� NULL������ �����ϴ� �ɼ�
    deptno CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE SET NULL
-- 3. FOREIGN KEY ���������� �����Ѵ�.

DELETE FROM dept_fk
WHERE deptno = 10;
INSERT INTO dept_fk
 SELECT * FROM dept WHERE deptno >= 20;
SELECT * FROM dept_fk;
SELECT * FROM emp_fk;
INSERT INTO emp_fk
SELECT * FROM emp;
ALTER TABLE emp_fk
DROP CONSTRAINT empfk_deptno_fk;
ALTER TABLE emp_fk
MODIFY (deptno CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE SET NULL);
DELETE FROM dept_fk
WHERE deptno=20;
SELECT * FROM emp_fk;

--CHECK : ���� ������ �� �ִ� ���� ���� �Ǵ� ������ �����ϴ� ��������
CREATE TABLE table_check(
    login_id VARCHAR2(20) CONSTRAINT tblck_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) CONSTRAINT tblck_lgnpwd_ck CHECK(LENGTH(login_pwd) > 3),
    tel VARCHAR2(20)
);
INSERT INTO table_check VALUES ('TEST_ID_01','1234','010-1234-5678');
SELECT * FROM table_check;

--DEFAULT : ������ ���� �������� �ʾ����� �����Ǵ� ��, �������� �ƴ�
CREATE TABLE table_default(
    login_id VARCHAR2(20) CONSTRAINT tbkck2_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20),
    CREATE_DATE DATE DEFAULT SYSDATE
);
-- NULL�� ��������� ������ DEFAULT�� ������� ����
INSERT INTO table_default (login_id, login_pwd, tel) VALUES ('TEST_ID',NULL, '010-1234-5678');
INSERT INTO table_default (login_id, tel) VALUES ('TEST_ID2', '010-1234-5678');
SELECT * FROM table_default;

--����Ű : �ΰ��� ���� �ϳ��� �⺻Ű�� �����ϴ� ��������
CREATE TABLE table_test(
    col1 VARCHAR2(20),
    col2 VARCHAR2(20),
    CONSTRAINT tblt_pk PRIMARY KEY(col1, col2)
);
INSERT INTO table_test VALUES ('test1','test1');
INSERT INTO table_test VALUES ('test1','test2');
INSERT INTO table_test VALUES ('test2','test1');
INSERT INTO table_test VALUES ('test2','test2');
SELECT * FROM table_test;

--14�� ��������
--1
CREATE TABLE dept_const(
    deptno NUMBER(2) CONSTRAINT deptconst_deptno_pk PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT deptconst_dname_unq UNIQUE,
    loc VARCHAR2(13) CONSTRAINT deptconst_loc_nn NOT NULL
);
--2
CREATE TABLE emp_const(
    empno NUMBER(4) CONSTRAINT empconst_empno_pk PRIMARY KEY,
    ename VARCHAR2(10) CONSTRAINT empconst_ename_nn NOT NULL,
    job VARCHAR2(9),
    tel VARCHAR2(20) CONSTRAINT empconst_tel_unq UNIQUE,
    hiredate DATE,
    sal NUMBER(7,2) CONSTRAINT empconst_sal_chk CHECK(sal BETWEEN 1000 AND 9999),
    comm NUMBER(7,2),
    deptno NUMBER(2) CONSTRAINT empconst_deptno_fk REFERENCES dept_const(deptno)
);
--3
SELECT table_name, constraint_name, constraint_type FROM user_constraints
WHERE table_name IN ('DEPT_CONST','EMP_CONST');








