--제약조건
--NOT NULL : NULL를 설정할 수 없도록 하는 제약조건
--테이블 생성
CREATE TABLE table_notnull(
    login_id VARCHAR2(20) CONSTRAINT tb_lgnid_nn NOT NULL,
    login_pwd VARCHAR2(20) NOT NULL,
    tel VARCHAR2(20)
);
DESC table_notnull;
--데이터 사전으로 제약조건 확인
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
--UNIQUE : 데이터의 중복을 허용하지 않고 NULL값은 입력이 가능한 제약조건
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
--PRIMARY KEY(기본키, 주키, PK)의 특징
-- UNIQUE, NOT NULL의 특성을 가진다. 중복되지 않고 NULL을 저장할 수 없는 열 
-- 테이블당 하나의 열만 설정할 수 있다.
-- 기본키로 설정하면 자동으로 인덱스가 생성된다.
CREATE TABLE table_pk(
    login_id VARCHAR2(20) CONSTRAINT tblpk_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) CONSTRAINT tblpk_lgnpw_nn NOT NULL,
    tel VARCHAR2(20)
);
SELECT * FROM user_constraints WHERE table_name = 'TABLE_PK';
SELECT * FROM user_ind_columns WHERE table_name = 'TABLE_PK';
-- PK에 중복값 입력
INSERT INTO table_pk VALUES ('TEST_ID_01','1234','010-1234-5678');
SELECT * FROM table_pk;
-- PK에 NULL값 입력하기
INSERT INTO table_pk VALUES (NULL,'1234','010-1234-5678');
SELECT * FROM table_pk;
-- 테이블 레벨 제약 조건 지정 방식 : NOT NULL의 경우 아래쪽에서 설정할 수 없음
CREATE TABLE table_name(
    col1 VARCHAR2(20),
    col2 VARCHAR2(20) NOT NULL,
    col3 VARCHAR2(20),
    PRIMARY KEY(col1),
    CONSTRAINT constraint_name UNIQUE(col2) 
);
--14-37
-- FOREIGN KEY(외래키, FK) : 다른 테이블의 기본키를 참조하는 열
-- 참조하고있는 열에 없는 데이터는 추가할 수 없다.
SELECT owner, constraint_name, constraint_type, table_name, r_owner, r_constraint_name
FROM user_constraints
WHERE table_name IN ('EMP','DEPT');
INSERT INTO emp 
VALUES (9999,'홍길동','CLERK',7788, TO_DATE('2017/04/30','YYYY/MM/DD'),1200, NULL, 40);
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
-- 다른 테이블에서 외래키로 열을 참조하고 있고 이미 자식 레코드가 추가되어 있다면 삭제할 수 없음
-- 1. 현재 삭제하려는 열 값을 참조하는 데이터를 먼저 삭제한다. 자식 레코드를 삭제하고 부모키를 삭제
    --dept_fk의 데이터를 삭제할때 참조하는 데이터도 함께 삭제하는 옵션
    deptno CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE CASCADE
-- 2. 현재 삭제하려는 열 값을 참조하는 데이터를 수정한다. 자식레코드 NULL이나 부모키와는 다른 데이터로 수정
    -- dept_fk의 데이터를 삭제할때 참조하는 데이터를 모두 NULL값으로 변경하는 옵션
    deptno CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno) ON DELETE SET NULL
-- 3. FOREIGN KEY 제약조건을 삭제한다.

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

--CHECK : 열에 저장할 수 있는 값의 범위 또는 패턴을 정의하는 제약조건
CREATE TABLE table_check(
    login_id VARCHAR2(20) CONSTRAINT tblck_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) CONSTRAINT tblck_lgnpwd_ck CHECK(LENGTH(login_pwd) > 3),
    tel VARCHAR2(20)
);
INSERT INTO table_check VALUES ('TEST_ID_01','1234','010-1234-5678');
SELECT * FROM table_check;

--DEFAULT : 저장할 값이 지정되지 않았을때 설정되는 값, 제약조건 아님
CREATE TABLE table_default(
    login_id VARCHAR2(20) CONSTRAINT tbkck2_lgnid_pk PRIMARY KEY,
    login_pwd VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20),
    CREATE_DATE DATE DEFAULT SYSDATE
);
-- NULL을 명시적으로 적으면 DEFAULT가 실행되지 않음
INSERT INTO table_default (login_id, login_pwd, tel) VALUES ('TEST_ID',NULL, '010-1234-5678');
INSERT INTO table_default (login_id, tel) VALUES ('TEST_ID2', '010-1234-5678');
SELECT * FROM table_default;

--복합키 : 두개의 열을 하나의 기본키로 설정하는 제약조건
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

--14장 연습문제
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








