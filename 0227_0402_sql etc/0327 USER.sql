-- 15-1 : SCOTT 계정으로 사용자 생성하기
-- C##orclstudy : 오라클 12c 이후 버전부터, 계정 생성시 id 앞에 C##을 붙여야 계정 생성이 가능함.
-- ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; : 예전 스크립트를 실행 가능하도록 하는 설정, 세션 시작시 실행해야함
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
--계정 생성의 경우 관리자 계정으로 실행해야함
CREATE USER orclstudy
IDENTIFIED BY ORACLE;

-- 세션 접속 권한 부여하기(관리자 권한으로 실행해야함)
GRANT CREATE SESSION TO orclstudy;

-- 계정 비밀번호 변경
ALTER USER orclstudy
IDENTIFIED BY ORCL;

-- 계정 삭제하기
DROP USER orclstudy; -- 계정만 삭제하고, 계정이 생성했던 객체(스키마)는 남겨둠.
DROP USER orclstudy CASCADE; -- 계정을 삭제하고, 계정이 만들었던 모든 객체를 삭제함.

-- 시스템 권한 설정하기(관리자 계정으로 실행)
-- 15-7 : SYSTEM 계정으로 접속하여 사용자(orclstudy) 생성하기
CREATE USER orclstudy
IDENTIFIED BY ORACLE;

GRANT
    RESOURCE, CREATE SESSION, CREATE TABLE
    TO orclstudy;

-- 데이터 입력을 위한테이블 스페이스 용량 설정하기
ALTER USER orclstudy
QUOTA 2M ON USERS; -- QUOTA 2M은 2메가바이트 용량을 주겠다를 말함.

-- 테이블 스페이스 무제한 용량으로 설정
ALTER USER orclstudy
QUOTA UNLIMITED ON USERS;

-- 모든 테이블 스페이스에 무제한 용량 설정
GRANT UNLIMITED TABLESPACE TO orclstudy;
    
-- 권한 취소
REVOKE
  CREATE TABLE
    FROM orclstudy;
    
REVOKE
 RESOURCE
    FROM orclstudy;
    
-- 객체 권한(SELECT, INSERT, UPDATE, DELETE 등) 부여하기
-- 객체 권한 부여 및 취소는 실행 즉시 cmd창의 sqlplus에 실행됨
CREATE TABLE temp(
    col1 VARCHAR2(20),
    col2 VARCHAR2(20)
);

-- 객체 권한의 경우, SCOTT 계정으로 실행해야함. 왜냐하면 SCOTT 계정이 temp 테이블을 만들었기 때문
GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON temp
TO orclstudy;

-- 객체 권한 취소,
REVOKE 
    SELECT, INSERT, UPDATE, DELETE
ON temp
FROM orclstudy;


-- CONNECT 롤 : CREATE SESSION 권한만 가지고 있는 롤
GRANT CONNECT TO orclstudy;

-- RESOURCE 롤 : CREATE VIEW, CREATE SYNONYM을 제외한 대부분의 권한을 가짐.
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO orclstudy;

-- 롤 생성 및 설정, 취소 (관리자 계정으로 실행 해야함)
-- 1. CREATE ROLE 롤 생성
CREATE ROLE rolestudy;

-- 2. 생성한 롤에 권한 설정하기
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO rolestudy;

-- 3. 권한을 설정한 롤을 유저에게 설정하기
GRANT rolestudy TO orclstudy;

-- 4. 롤 취소하기
REVOKE rolestudy FROM orclstudy;

-- 5. 롤 삭제하기 : 롤을 삭제하면 롤을 부여받았던 모든 계정의 롤이 취소되게됨
DROP ROLE rolestudy;


-- 416p, 15장 연습문제, Q1~3
-- Q1. 다음 조건에 만족하는 SQL문을 작성해 보세요.
-- 1) SYSTEM 계정으로 접속하여 PREV_HW 계정을 생성해 보세요.
-- 2) 비밀번호는 ORCL로 지정합니다. 접속 권한을 부여하고 PREV_HW 계정으로 접속이 잘되는지 확인해 보세요.
CREATE USER PREV_HW
IDENTIFIED BY ORCL;

GRANT CREATE SESSION TO PREV_HW; 
--GRANT CONNECT TO PREV_HW; 이걸로 해도됨.


-- Q2. SCOTT 계정으로 접속하여 위에서 생성한 PREV_HW 계정에 SCOTT 소유의 EMP, DEPT, SALGRADE 테이블에 SELECT 권한을 부여하는 SQL문을 작성해보세요.
--     권한을 부여했으면 PREV_HW 계정으로 SCOTT의 EMP, DEPT, SALGRADE 테이블이 잘 조회되는지 확인해보세요.
GRANT SELECT ON emp TO PREV_HW;
GRANT SELECT ON dept TO PREV_HW;
GRANT SELECT ON salgrade TO PREV_HW;

-- cmd에서 PREV_HW로 확인.
SELECT * FROM SCOTT.EMP;
SELECT * FROM SCOTT.DEPT;
SELECT * FROM SCOTT.SALGRADE;

-- Q3. SCOTT 계정으로 접속하여 PREV_HW 계정에 SALGRADE 테이블의 SELECT 권한을 취소하는 SQL문을 작성해 보세요. 권한의 변경이 완료되면 다음과 같이
--     PREV_HW 계정으로 SALGRADE 테이블의 조회 여부를 확인해봅시다.
REVOKE 
    SELECT ON salgrade
FROM PREV_HW;

-- cmd에서 확인
SELECT * FROM SCOTT.SALGRADE;
    
-- 가변길이 문자열(VARCHAR2()) : 10byte만큼 저장하면 10btye만큼만 용량을 차지하는 자료형
-- varchar : varchar2와 같은 자료형이지만 앞으로 로직이 변경될 예정인 자료형
-- CHAR(100) : 고정길이 문자열. 10byte만큼 저장해도, 언제나 최대용량으로 저장됨

    
    
    
    
    