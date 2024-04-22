-- 11-1 : DEPT테이블을 복사해서 DEPT_TCL 테이블 만들기
CREATE TABLE dept_tcl
AS SELECT * FROM dept;

-- 11-2 : DEPT_TCL 테이블에 데이터를 입력, 수정, 삭제하기
INSERT INTO dept_tcl VALUES (50, 'DATABASE', 'SEOUL');
UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno = 40;
DELETE FROM dept_tcl WHERE dname = 'RESEARCH';
SELECT * FROM dept_tcl;
ROLLBACK;   
COMMIT;

-- 11-6 : 토드와 SQL*PLUS로 세션 알아보기
SELECT * FROM dept_tcl;

-- 11-7 
DELETE FROM dept_tcl WHERE deptno = 50;
COMMIT;

-- 11-9 : 토드와 SQL*PLUS로 LOCK 알아보기
SELECT * FROM dept_tcl;

-- 11-10 : 토드와 SQL*PLUS로 LOCK 알아보기
UPDATE dept_tcl SET loc = 'SEOUL' WHERE deptno = 30;
SELECT * FROM dept_tcl;

-- 11-11 : 토드와 SQL*PLUS로 LOCK 알아보기
-- UPDATE dept_tcl SET dname = 'DATABASE' WHERE deptno = 30; // 이거는 CMD창 SQLPLUS에서 실행했는데,
-- ORACLE에서 위에 UPDATE 사용하면, COMMIT하기 전까지는 LOCK걸려서 SQLPLUS에서는 아무런 반응 안함
COMMIT;
SELECT * FROM dept_tcl;

-- UPDATE 랑 DELETE는, WHERE없이 사용하면 안된다. 없이 사용하면 테이블 단위로 다 LOCK이 걸려서 그렇다.

-- 309p, 11장 연습문제, Q1
DROP TABLE dept_hw; -- 이전에 내가 오류났어서 테이블 지우는 코드
CREATE TABLE dept_hw AS SELECT * FROM dept; -- 테이블 복사(구조, 데이터 들고옴)
-- INSERT INTO dept_hw SELECT * FROM dept; -- 데이터만 삽입하는 코드
SELECT * FROM dept_hw; --그냥 확인 한 번 해봄

UPDATE dept_HW SET dname = 'DATABASE', loc = 'SEOUL' WHERE deptno = 30;
SELECT * FROM dept_hw;

ROLLBACK;

SELECT * FROM dept_hw;




