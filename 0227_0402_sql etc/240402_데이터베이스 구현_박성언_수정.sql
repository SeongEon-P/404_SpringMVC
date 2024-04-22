--[평가] 데이터베이스 구현 평가자 체크리스트
--1. scott 계정의 패스워드를 잊었을 때 패스워드를 재설정하는 방법을 console에 sqlplus에 접속하는 방법부터 작성하라
CONNECT system as sysdba;
ALTER USER scott IDENTIFIED BY new_password;

--2. [SQL] 오라클에서 현재 계정이 가지고 있는 모든 테이블을 보여주는 쿼리를 작성하라
SELECT * FROM user_tables;

--3. guest02 사용자를 추가하는 쿼리를 작성하라.(패스워드: 1234)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER guest02
IDENTIFIED BY 1234;

--4. guest02 사용자가 데이터베이스에 접속, 리소스 사용, 세션 생성, 뷰 생성, 동의어 생성이 가능하도록 권한을 설정하는 쿼리를 작성하라.

GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE VIEW, CREATE SYNONYM TO guest02;

--5. guest02 사용자의 테이블 스페이스 저장 공간을 2M으로 설정하라.
ALTER USER guest02
QUOTA 2M ON USERS;

--6. dept(부서) 테이블을 다음과 같이 생성하기 위한 쿼리를 작성하라
--    deptno 가변길이 문자 6으로 지정한다.
--    dname 가변길이 문자 6으로 지정한다.  
 
CREATE TABLE dept (
  deptno VARCHAR(6),
  dname VARCHAR(6)
);

--7. dept(부서) 테이블에 area 필드를 가변길이문자 10으로 지정하고 칼럼을 추가한다.
ALTER TABLE dept ADD area VARCHAR2(10);

--8. dept(부서) 테이블의 dname의 문자열 길이를 6에서 10으로 변경하라.
ALTER TABLE dept MODIFY dname VARCHAR2(10);

--9. dept(부서) 테이블에 deptno 필드에 기본키(primary key) 제약조건을 추가하라.
ALTER TABLE dept ADD PRIMARY KEY (deptno);

--10. dept 테이블에 dname 필드에 not null과 uniqe 제약조건을 설정하라.
ALTER TABLE dept
    MODIFY dname VARCHAR2(10) NOT NULL,
    ADD CONSTRAINT dname_unique UNIQUE (dname);



--11. emp(사원) 테이블을 다음과 같이 작성하라
-- empno 숫자로 설정하고 기본키로 설정하라.
-- name 가변길이 문자 10자로 설정하고 not null 제약조건을 설정
-- deptno 가변길이 문자 6자로 설정
-- position 가변길이문자 10자로 설정하고 값은 “사원, 대리, 과장, 부장” 값만 가질 수 있도록 설정
-- pay를 숫자로 설정하고 not null 제약 조건을 설정하라.
-- pempno는 숫자로 설정하라.
CREATE TABLE emp (
  empno NUMBER PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  deptno VARCHAR(6),
  position VARCHAR(10) CONSTRAINT emp_position CHECK (position IN ('사원', '대리', '과장', '부장')),
  pay NUMBER NOT NULL,
  pempno NUMBER,
 );


--12. emp 테이블의 deptno 컬럼에 외래키 제약 조건으로 dept 테이블이 deptno 컬럼을 참조하도록 지정하라.
ALTER TABLE emp ADD CONSTRAINT fk_deptno_to_emp_table FOREIGN KEY (deptno) REFERENCES dept(deptno);

--13. 이름이 SEQ_EMP_SEQUENCE이고 시작 값 1001, 증가 값1인 시퀀스를 생성하라.

CREATE SEQUENCE SEQ_EMP_SEQUENCE
    START WITH 1001
    INCREMENT BY 1;

--14. dept 테이블과 emp 테이블에 데이터를 그림과 같이 입력하라. 단 empno는 시퀀스를 이용하여 자동 증가하도록 입력한다.
INSERT INTO dept VALUES (101,'영업부');
INSERT INTO dept VALUES (102,'총무부');
INSERT INTO dept VALUES (103,'기획부');
INSERT INTO dept VALUES (104,'홍보부');

INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '홍길동', 101, '부장', 450, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '김연아', 102, '부장', 400, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '박지성', 101, '과장', 350, 1001);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '김태근', 103, '과장', 410, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '서찬수', 101, '대리', 300, 1003);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '김수현', 103, '대리', 400, 1004);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '정동민', 102, '대리', 320, 1002);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '이성규', 102, '사원', 380, 1007);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '임진영', 103, '사원', 250, 1006);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '서진수', 101, '사원', 200, 1005);

--15. 사원테이블의 name으로 인덱스를 설정하라.(인덱스 이름 : IDX_EMP_NAME)
CREATE INDEX IDX_EMP_NAME ON emp(name);

--16. 부서와 사원 테이블의 사원번호(empno), 이름(name), 부서명(dname), 급여(pay) 컬럼을 선택하여 뷰(VIEW)를 작성하라.(뷰 이름 : VW_EMP_TEST)
CREATE VIEW VW_EMP_TEST AS
SELECT e.empno, e.name, d.dname, e.pay
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

--17. guest03 사용자를 생성하여(비밀번호 4321) guest03에게 guest02의 emp 테이블을 조회, 입력, 수정, 삭제하는 권한을 설정하라.
CREATE USER guest03
IDENTIFIED BY 4321;

GRANT SELECT, INSERT, UPDATE, DELETE ON guest02.emp TO guest03;

--18. guest03 사용자에게 주어진 권한을 제거하라.
REVOKE 
    SELECT, INSERT, UPDATE, DELETE ON guest02.emp
FROM guest03;


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
