-- 사용자 테이블 : 사용자가 직접 만든 테이블
-- 데이터 사전 : 데이터베이스가 생성될 때 함께 생성된 메모리, 성능, 사용자, 권한, 객체 등
--              데이터베이스 운영에 필요한 정보를 보관하는 테이블
-- 데이터 사전 뷰 : 데이터 사전에 저장되어 있는 데이터를 열람할 수 있도록 만들어둔 뷰
-- USER_**** : 현재 접속한 계정이 소유한 객체 정보
-- ALL_**** : 현재 접속한 계정이 권한을 가진 모든 객체 정보
-- DBA-**** : 관리자 권한을 가진 계정만 사용할 수 있는 객체 정보
-- V$_**** : 데이터베이스 성능 관련 정보

-- 어떤 데이터 사전 뷰가 있는지 확인하는 명령어
-- 13-1 
SELECT * FROM dict;
SELECT * FROM dictionary;

-- 현재 접속한 계정이 소유한 테이블을 확인하는 데이터 사전 뷰
SELECT * FROM user_tables; -- 17개 자신이 소유한 테이블만 확인
-- NUM_ROWS : 행의 갯수, COUNT(*)함수로 행의 갯수를 확인하면 행의 갯수가 많으면 시간이 오래 걸림
SELECT * FROM all_tables; -- 131개 권한이 있는 테이블만 확인
SELECT * FROM dba_tables; -- 관리자 권한이 없기 때문에 확인할 수 없음, system 계정으로 들어가면 보임. scott계정에서는 안보임


-- PK(Primary Key)를 검색할 때 많이 사용한다(인덱스 기능).


-- 13-8 : SCOTT계정이 소유한 인덱스 정보 알아보기(SCOTT 계정일 때)
SELECT * FROM user_indexes;
-- 13-9 : SCOTT계정이 소유한 인덱스 컬럼 정보 알아보기(SCOTT 계정일 때)
SELECT * FROM user_ind_columns;

-- 13-10 : EMP 테이블의 SAL 열에 인덱스를 생성하기
CREATE INDEX IDX_EMP_SAL ON emp(sal);  --IDX_테이블이름_컬럼이름ON 테이블이름(컬럼이름);
-- sal을 인덱스로 하는건 안좋음. 왜냐하면 중복되는 데이터가 있어서 인덱스로 역할을 잘 못함. comm은 빈데이터가 많아서 인덱스로 안좋음. empno같은게 인덱스로 좋음. 그래서 pk로 설정하면 자동으로 인덱스가 된다고함.
SELECT*FROM user_indexes;
SELECT*FROM user_ind_columns;
DROP INDEX idx_emp_sal;

-- 13-14 : 뷰를 생성하기 위해 계정 변경 접속하기.systemp계정으로 해야함
GRANT CREATE VIEW TO SCOTT;

-- 13-15 : 뷰 생성하기(토드)
CREATE VIEW vw_emp20
AS (SELECT empno, ename, job, deptno FROM emp WHERE deptno = 20);

SELECT * FROM vw_emp20;

SELECT * FROM user_views;

-- 13-19 : 뷰 삭제
DROP VIEW vw_emp20;

-- 인라인 뷰
SELECT * FROM emp --이거는 메인 쿼리
WHERE sal > (SELECT AVG(sal) FROM emp); -- 이거 괄호 안을 인라인 뷰 라고함.

WITH E10 AS (SELECT * FROM emp WHERE deptno = 10)
SELECT * FROM E10; -- 이것도 인라인 뷰 사용했다고함

-- 13-20 :  ROWNUM을 추가로 조회하기, ROWNUM은 행번호를 출력하는 의사열. 필요한 갯수만큼 데이터 출력을 제한하는데 사용
SELECT ROWNUM, E.*FROM emp E;
SELECT ROWNUM, E.*FROM emp E WHERE rownum <= 10 ORDER BY sal DESC; --이렇게하면, ROWNUM이 뒤죽박죽됨
SELECT table_name,num_rows FROM user_tables WHERE table_name='EMP';
SELECT ROWNUM, E.* FROM (SELECT * FROM emp E ORDER BY sal DESC) E WHERE ROWNUM <= 10;

-- MAX() 함수로 다음 번호 생성하기
-- 데이터가 많으면 다음 번호를 얻는 시간이 오래 걸린다
-- 같은 시간에 SELECT문을 실행하면 같은 값을 돌려준다
SELECT MAX(empno)+1 FROM emp;

-- 13-26 : DEPT 테이블을 사용하여 DEPT_SEQUENCE 테이블 생성하기
CREATE TABLE dept_sequence
AS SELECT * FROM dept WHERE 1!=1; --1!=1 부분은 항상 거짓이 되는 조건, dept_sequence를 생성하지만, 실제로 dept 테이블의 어떠한 데이터도 새 테이블에 복사하지 않으려 할 때 사용
SELECT * FROM dept_sequence;

-- 13-27 : 시퀀스 생성하기
CREATE SEQUENCE seq_dept_sequence
    INCREMENT BY 10 --증가값, 기본값:1
    START WITH 10 --시작값, 기본값:1
    MAXVALUE 90 --최대값, 기본값:10^27까지 올라갈 수 있음
    MINVALUE 0 --최소값, 기본값:따로 없음
    NOCYCLE  --반복하지 않는다는 의미, 기본값:CYCLE
    CACHE 2; --메모리에 저장해둘 다음 값들. 2라고 되있으니까, 여기서는 10,20 / 20,30 / 이렇게.
             --CACHE에 아무것도 설정안하면 기본값20.
SELECT * FROM user_sequences;

-- 시퀀스 사용 방법
-- 시퀀스이름.NEXTVAL : 다음 번호를 출력하는 명령어
-- NEXTVAL은 반드시 INSERT문에서 실행해야함. SELECT문에서 실행하면, 하나씩 사라져서 빈공간이 생김.
INSERT INTO dept_sequence
VALUES (seq_dept_sequence.NEXTVAL,'DATABASE','SEOUL');
-- 시퀀스 이름.CURRVAL : 마지막으로 출력한 번호를 알려줌.
-- SELECT에서 마지막번호를 확인할 때 사용하는 명령어
SELECT seq_dept_sequence.CURRVAL FROM dual;

-- 13-32 : 시퀀스 옵션 수정하기
ALTER SEQUENCE seq_dept_sequence
    INCREMENT BY 3
    MAXVALUE 99
    CYCLE;
--PK(Primary Key)설정 안해두면, 중복된 값이 나와서 에러 뜰 수 있음.
    
SELECT * FROM user_sequences;

-- 13-36 : 시퀀스 삭제 후 확인하기
DROP SEQUENCE seq_dept_sequence;


-- 13-37 : 권한 부여하기. system계정으로 실행해야함
GRANT CREATE SYNONYM, CREATE PUBLIC SYNONYM TO SCOTT; -- CREATE PUBLIC SYNONYM은 SCOTT계정 뿐만 아니라 다른 계정도 쓸 수있게 하는거
--13-38 : 동의어 생성
CREATE SYNONYM E  --보통 이렇게 한글자로 줄이진 않음
FOR emp;

SELECT * FROM e; 

-- 동의어 삭제
DROP SYNONYM e;


-- 357~358p, 13장 연습문제, Q1~4
-- Q1. 다음 열 구조를 가지는 emp_hw 테이블을 만들어 보세요.
--1)EMP 테이블과 같은 구조의 데이터를 저장하는 EMPIDX테이블을 만들어보세요.
CREATE TABLE EMPIDX
AS SELECT * FROM emp WHERE 1!=1;
--2)생성한 EMPIDX 테이블의 EMPNO열에 IDX_EMPIDX_EMPNO 인덱스를 만들어 보세요.
CREATE INDEX IDX_EMPIDX_EMPNO ON EMPIDX(EMPNO);
--3)마지막으로 인덱스가 잘 생성되었는지 적절한 데이터 사전 뷰를 통해 확인해보세요.
SELECT*FROM user_indexes;
SELECT*FROM user_ind_columns;

-- Q2. 문제 1번에서 생성한 EMPIDX 테이블의 데이터 중 급여(SAL)가 1500 초과인 사원들만 출력하는
--     EMPIDX_OVER15K 뷰를 생성해 보세요. 이 이름을 가진 뷰가 이미 존재할 경우에 새로운 내용으로
--     대체 가능해야 합니다. EMPIDX_OVER15K 뷰는 사원 번호, 사원 이름, 직책, 부서 번호, 급여,
--     추가 수당 열을 가지고 있습니다. 추가 수당 열의 경우에 추가 수당이 존재하면 O, 존재하지 않으면 X로 출력합니다.
CREATE OR REPLACE VIEW EMPIDX_OVER15K --'OR REPLACE' 이게, 이름 똑같은거 있으면 덮어쓰기 하겠다는 말임
AS (SELECT empno, ename, job, deptno, sal, NVL2(comm, 'O', 'X') As comm
    FROM empidx WHERE sal > 1500);
SELECT * FROM EMPIDX_OVER15K;

-- Q3.다음 세가지 sql문을 작성해보세요.
-- 1)DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ 테이블을 작성해보세요.
CREATE TABLE DEPTSEQ
AS SELECT * FROM dept;
--2)생성한 DEPTSEQ테이블의 DEPTNO 열에 사용할 시퀀스를 오른쪽 특성에 맞게 생성해 보세요.
CREATE SEQUENCE seq_DEPTSEQ
    INCREMENT BY 1 --증가값, 기본값:1
    START WITH 1 --시작값, 기본값:1
    MAXVALUE 99 --최대값, 기본값:10^27까지 올라갈 수 있음
    MINVALUE 1 --최소값, 기본값:따로 없음
    NOCYCLE  --반복하지 않는다는 의미, 기본값:CYCLE
    NOCACHE ; --메모리에 저장해둘 다음 값들. 2라고 되있으니까, 여기서는 10,20 / 20,30 / 이렇게.
             --CACHE에 아무것도 설정안하면 기본값20.

SELECT * FROM user_sequences;

--3)마지막으로 생성한 DEPTSEQ를 사용하여 오른쪽과 같이 세 개 부서를 차례대로 추가해 보세요.

-- 시퀀스 사용 방법
-- 시퀀스이름.NEXTVAL : 다음 번호를 출력하는 명령어
-- NEXTVAL은 반드시 INSERT문에서 실행해야함. SELECT문에서 실행하면, 하나씩 사라져서 빈공간이 생김.
INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'DATABASE','SEOUL');

INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'WEB','BUSAN');

INSERT INTO DEPTSEQ
VALUES (seq_DEPTSEQ.NEXTVAL,'MOBILE','ILSAN');

SELECT*FROM DEPTSEQ;

















































