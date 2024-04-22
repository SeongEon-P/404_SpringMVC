--CREATE TABLE SCOTT.DEPT_TEST
-- 12-1 : 모든 열의 각 자료형을 정의해서 테이블 생성하기
CREATE TABLE emp_ddl(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2)
);

DESC emp_ddl;

-- 12-4 : 다른 테이블의 일부를 복사하여 테이블 생성하기
CREATE TABLE emp_ddl_30 AS SELECT *FROM emp
WHERE deptno = 30;

SELECT*FROM emp_ddl_30;

-- 12-5 : 다른 테이블을 복사하여 테이블 생성하기
CREATE TABLE empdept_ddl AS SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate,
                E.sal, E.comm, D.deptno, D.dname, D.loc FROM emp E
                INNER JOIN dept D ON E.deptno = D.deptno
                WHERE 1<>1;

SELECT * FROM empdept_ddl;


CREATE TABLE emp_alter AS SELECT*FROM emp;

-- 12-7 : ALTER 명령어로 HP 열 추가하기
ALTER TABLE emp_alter
ADD hp VARCHAR2(20); -- 20은 20바이트 라는 뜻

SELECT * FROM emp_alter;

-- 12-8 : ALTER 명령어로 HP 열 이름을 TEL로 변경하기
ALTER TABLE emp_alter RENAME COLUMN hp TO tel;
SELECT * FROM emp_alter;

-- 12-9 : ALTER 명령어로 EMPNO 열 길이 변경하기
ALTER TABLE emp_alter MODIFY empno NUMBER(5);  --원래 NUMBER(4)였을 때 4자리 숫자가 있었는데, 3으로 내리지는 못함. 이미 4자리 데이터가 있었으니까. 데이터 없었으면 됨.
SELECT * FROM emp_alter;

-- 12-10 : ALTER 명령어로 TEL 열 삭제하기
ALTER TABLE emp_alter DROP COLUMN tel;  --ddl(정의어)는 transaction이랑 상관 없어서, 실행하는 순간 바로바로 적용된다. commit의 필요유무 말하시는 듯.
SELECT * FROM emp_alter;

-- 12-11 : 테이블 이름 변경하기
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_alter;
SELECT * FROM emp_rename;


-- 12-14 : EMP_RENAME 테이블의 전체 데이터 삭제하기(TRUNCATE는 DDL이라서 바로 적용됨. transaction이랑 상관 없음.)
SELECT * FROM emp_rename;
TRUNCATE TABLE emp_rename; -- delete문에 where절을 적지 않은 것과 같이 모든 데이터를 삭제하지만,다른 점은, transaction의 영향을 받지 않는 sql문이다)
ROLLBACK; --TRUNCATE는 transaction에 영향을 안받기 때문에, rollback해도 삭제된 데이터가 안돌아온다. delete는 rollback하면 돌아옴.


-- 12-15 : emp_rename 테이블 삭제하기
DROP TABLE emp_rename; -- transaction이 아니라서 drop하는 순간 그냥 싹 지워짐. (transaction은 inser, update, delete만 해당됨)
SELECT * FROM emp_rename;

-- 324~325p, 12장 연습문제, Q1~6
-- Q1. 다음 열 구조를 가지는 emp_hw 테이블을 만들어 보세요.
CREATE TABLE emp_hw(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2)
);
SELECT * FROM emp_hw;
DESC emp_hw; --데이터 열의 정보를 보여줌


-- Q2. emp_hw 테이블에 bigo 열을 추가해 보세요. bigo 열의 자료형은 가변형 문자열이고, 길이는 20입니다.
ALTER TABLE emp_hw ADD bigo VARCHAR2(20); -- 20은 20바이트 라는 뜻
SELECT * FROM emp_hw;

-- Q3. emp_hw 테이블의 bigo 열 크기를 30으로 변경해보세요. 
ALTER TABLE emp_hw MODIFY bigo VARCHAR2(30);
SELECT * FROM emp_hw;

-- Q4. emp_hw 테이블의 bigo 열 이름을 remark로 변경해보세요.
ALTER TABLE emp_hw RENAME COLUMN bigo TO remark;
SELECT * FROM emp_hw;

-- Q5. emp_hw 테이블에 emp 테이블의 데이터를 모두 저장해 보세요. 단, remark 열은 null로 삽입합니다.

--내가 한 버전(기본적으로 서버에서 사용할 때는 다 적어주는게 좋다고함)
INSERT INTO emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
            SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, null
            FROM emp;
            
--선생님이 한 버전
--1)
INSERT INTO emp_hw
            SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, null
            FROM emp;          
--2)            
INSERT INTO emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            SELECT * FROM emp;          
            
SELECT * FROM emp_hw;

-- Q6. 지금까지 사용한 emp_hw 테이블을 삭제해 보세요.
DROP TABLE emp_hw;
SELECT * FROM emp_hw;











