--10-1 테이블 복사하기 , 제약조건은 복사되지 않음
CREATE TABLE dept_temp
AS SELECT * FROM dept;
--INSERT문 : 테이블에 데이터를 추가하는 SQL문
INSERT INTO 테이블 이름 (열이름, 열이름, 열이름) VALUES (데이터, 데이터, 데이터);
--10-3
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (50,'DATABASE','SEOUL');
SELECT * FROM dept_temp;
-- INSERT문 사용시의 주의점
--1. 열의 개수가 맞지 않을 때
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (60,'NETWORK');
--2. 지정한 열보다 데이터가 많을 때
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (60,'NETWORK','BUSAN','WRONG');
--3. 데이터 타입이 서로 다를 때
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES ('WRONG','NETWORK','BUSAN');
--4. 데이터 길이가 맞지 않을 때
INSERT INTO dept_temp (deptno, dname, loc) 
                VALUES (100,'NETWORK','BUSAN');
                
-- 10-4 열 지정 없이 데이터 추가하기
-- SQL Developer 같은 테스트 가능한 응용프로그램에서 실행하는 방식
-- 실제 서버에서 실행할때 모든 열을 적는것이 권장 됩니다.
INSERT INTO dept_temp
    VALUES(60,'NETWORK','BUSAN');
SELECT * FROM dept_temp;

-- 테이블에 NULL데이터 입력하기
-- NULL의 명시적 입력 10-5,10-6
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (70,'WEB',NULL);
INSERT INTO dept_temp (deptno, dname, loc)
VALUES (80,'MOBILE','');
-- NULL의 암시적 입력
INSERT INTO dept_temp (deptno, loc)
VALUES (90,'INCHEON');
-- 테이블의 데이터를 제외한 테이블 구조만 복사하기
CREATE TABLE emp_temp
AS SELECT * FROM emp WHERE 1<>1;
SELECT * FROM emp_temp;
-- 날짜 데이터 추가하기
--10-9
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999,'홍길동','PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (1111,'성춘향','MANAGER', 9999, '2001-01-05', 4000, NULL, 20);
SELECT * FROM emp_temp;
--10-11
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2111,'이순신','MANAGER', 9999, '07/01/2001', 4000, NULL, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2111,'이순신','MANAGER', 9999, TO_DATE('07/01/2001','DD/MM/YYYY'), 4000, NULL, 20);
SELECT * FROM emp_temp;
--10-13
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3111,'심청이','MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM emp_temp;

--10-14
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm, E.deptno
    FROM emp E INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
    WHERE S.grade = 1;
SELECT * FROM emp_temp;
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    SELECT * FROM emp;

--UPDATE : 테이블 데이터 수정하기
CREATE TABLE dept_temp2
    AS SELECT * FROM dept;
-- UPDATE  테이블이름 SET 열이름 = 내용작성 WHERE 열이름 = 조건값
--10-16
UPDATE dept_temp2
    SET loc = 'SEOUL';
SELECT * FROM dept_temp2;
ROLLBACK;

-- 10-18 데이터 일부분만 수정하기
UPDATE dept_temp2
   SET dname = 'DATABASE',
       loc = 'SEOUL'
 WHERE deptno = 40;
SELECT * FROM dept_temp2 WHERE deptno = 40;
--10-19
UPDATE dept_temp2
SET (dname, loc) = (SELECT dname, loc FROM dept WHERE deptno = 40)
WHERE deptno = 40;
SELECT * FROM dept_temp2;
-- 10-21
UPDATE dept_temp2
SET loc = 'SEOUL'
WHERE deptno = (SELECT deptno FROM dept_temp2 WHERE dname='OPERATIONS');
SELECT * FROM dept_temp2;

--DELETE : 테이블 데이터 삭제 
CREATE TABLE emp_temp2
    AS SELECT * FROM emp;
SELECT * FROM emp_temp2;
-- DELETE FROM 테이블이름; 테이블의 모든 행을 삭제
--10-23 
DELETE FROM emp_temp2
    WHERE job = 'MANAGER';
SELECT * FROM emp_temp2 WHERE job = 'MANAGER';
--10-24
DELETE FROM emp_temp2
WHERE empno IN (SELECT E.empno FROM emp_temp2 E
                INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                AND S.grade = 3
                AND E.deptno = 30);

SELECT * FROM emp_temp2 E
                INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                AND S.grade = 3
                AND E.deptno = 30;

--10장 연습문제
CREATE TABLE chap10hw_emp AS SELECT * FROM emp;
CREATE TABLE chap10hw_dept AS SELECT * FROM dept;
CREATE TABLE chap10hw_salgrade AS SELECT * FROM salgrade;
--1
INSERT INTO chap10hw_dept VALUES(50,'ORACLE','BUSAN');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(60,'SQL','ILSAN');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(70,'SELECT','INCHEON');
INSERT INTO chap10hw_dept(deptno, dname, loc) VALUES(80,'DML','BUNDANG');
SELECT * FROM chap10hw_dept;
--2
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7201,'TEST_USER1','MANAGER',7788,TO_DATE('2016-01-02','YYYY-MM-DD'),4500,NULL,50);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7202,'TEST_USER2','CLERK',7201,TO_DATE('2016-02-21','YYYY-MM-DD'),1800,NULL,50);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7203,'TEST_USER3','ANALYST',7201,TO_DATE('2016-04-11','YYYY-MM-DD'),3400,NULL,60);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7204,'TEST_USER4','SALESMAN',7201,TO_DATE('2016-05-31','YYYY-MM-DD'),2700,300,60);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7205,'TEST_USER5','CLERK',7201,TO_DATE('2016-07-20','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7206,'TEST_USER6','CLERK',7201,TO_DATE('2016-09-08','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7207,'TEST_USER7','LECTURER',7201,TO_DATE('2016-10-28','YYYY-MM-DD'),2300,NULL,80);
INSERT INTO chap10hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7208,'TEST_USER8','STUDENT',7201,TO_DATE('2018-03-09','YYYY-MM-DD'),1200,NULL,80);
SELECT * FROM chap10hw_emp;
--3
UPDATE chap10hw_emp
SET deptno = 70
WHERE sal > (SELECT AVG(sal) FROM chap10hw_emp WHERE deptno = 50);
SELECT * FROM chap10hw_emp;
SELECT * FROM chap10hw_emp WHERE sal > (SELECT AVG(sal) FROM chap10hw_emp WHERE deptno = 50);
--4
UPDATE chap10hw_emp 
SET sal = sal*1.1,
    deptno = 80
WHERE hiredate > (SELECT MIN(hiredate) FROM chap10hw_emp WHERE deptno = 60);
SELECT * FROM chap10hw_emp WHERE hiredate > (SELECT MIN(hiredate) FROM chap10hw_emp WHERE deptno = 60);
--5
DELETE FROM chap10hw_emp
WHERE empno IN (SELECT empno FROM chap10hw_emp E 
                INNER JOIN chap10hw_salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                WHERE S.grade = 5);
SELECT * FROM chap10hw_emp;
SELECT * FROM chap10hw_emp E 
                INNER JOIN chap10hw_salgrade S ON E.sal BETWEEN S.losal AND S.hisal
                WHERE S.grade = 5;


CREATE TABLE chap10hw_emp2 AS SELECT * FROM emp WHERE 1!=1;
SELECT * FROM chap10hw_emp2;



