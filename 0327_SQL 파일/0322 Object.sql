--사용자 테이블 : 사용자가 직접 만든 테이블
--데이터 사전 : 데이터베이스가 생성될때 함께 생성된 메모리,성능,사용자,권한,객체 
--             등 데이터베이스 운영에 필요한 정보를 보관하는 테이블
--데이터 사전 뷰 : 데이터 사전에 저장되어 있는 데이터를 열람할 수 있도록 만들어둔 뷰
-- USER_**** : 현재 접속한 계정이 소유한 객체 정보
-- ALL_**** : 현재 접속한 계정이 권한을 가진 모든 객체 정보
-- DBA_**** : 관리자권한을 가진 계정만 사용할 수 있는 객체 정보
-- V$_**** : 데이터베이스 성능 관련 정보

-- 어떤 데이터 사전 뷰가 있는지 확인하는 명령어
SELECT * FROM dict;
SELECT * FROM dictionary;
-- 현재 접속한 계정이 소유한 테이블을 확인하는 데이터 사전 뷰
SELECT * FROM user_tables; --17 자신이 소유한 테이블만 확인
--NUM_ROWS : 행의 갯수, COUNT(*)함수로 행이 갯수를 확인하면 행의 갯수가 많으면 시간이 오래 걸림
SELECT * FROM all_tables; --131 권한이 있는 테이블만 확인
SELECT * FROM dba_tables; --2369 관리자 권한있어야 확인 가능
--13-8
SELECT * FROM user_indexes;
SELECT * FROM user_ind_columns;
--13-10
CREATE INDEX IDX_EMP_SAL
ON emp(sal);
DROP INDEX idx_emp_sal;

EXPLAIN PLAN FOR SELECT * FROM emp WHERE sal > 100;

--13-14
-- VIEW 생성 권한 설정
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
--ROWNUM : 행번호를 출력하는 의사열, 필요한 갯수만큼 데이터 출력을 제한하는데 사용
SELECT ROWNUM, E.* FROM emp E;
SELECT ROWNUM, E.* FROM emp E WHERE rownum <= 10 ORDER BY sal DESC;
SELECT ROWNUM, E.* FROM (SELECT * FROM emp ORDER BY sal DESC) E WHERE ROWNUM <= 10 ;
SELECT table_name,num_rows FROM user_tables WHERE table_name='EMP';
-- MAX() 함수로 다음번호 생성하기
-- 데이터가 많으면 다음번호를 얻는 시간이 오래 걸린다.
-- 같은 시간에 SELECT문을 실행하면 같은 값을 돌려준다.
SELECT MAX(empno)+1 FROM emp;
--13-26
CREATE TABLE dept_sequence
AS SELECT * FROM dept WHERE 1!=1;
--13-27
CREATE SEQUENCE seq_dept_sequence
    INCREMENT BY 10 --증가값, 기본값 1
    START WITH 10 -- 시작값, 기본값 1
    MAXVALUE 90 --최대값
    MINVALUE 0 --최소값
    NOCYCLE -- 반복여부, 기본값 CYCLE
    CACHE 2; -- 메모리에 저장해둘 다음 값, 기본값 20
SELECT * FROM user_sequences;
--시퀀스 사용 방법
--시퀀스이름.NEXTVAL : 다음 번호를 출력하는 명령어
-- 반드시 INSERT문에서 실행해야함
INSERT INTO dept_sequence
VALUES (seq_dept_sequence.NEXTVAL,'DATABASE','SEOUL');
--시퀀스 이름.CURRVAL : 마지막으로 출력한 번호를 반환하는 명령어
-- SELECT에서 마지막번호를 확인할 때 사용 
SELECT seq_dept_sequence.CURRVAL FROM dual;
--13-32
ALTER SEQUENCE seq_dept_sequence
    INCREMENT BY 3
    MAXVALUE 99
    CYCLE;
--13-36
DROP SEQUENCE seq_dept_sequence;
--13-37 system 계정으로 실행
GRANT CREATE SYNONYM, CREATE PUBLIC SYNONYM TO SCOTT;
--동의어 생성
CREATE SYNONYM E
FOR emp;
SELECT * FROM e;
--동의어 삭제
DROP SYNONYM e;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

--13장 연습문제
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











