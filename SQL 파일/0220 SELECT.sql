--DESC 테이블이름 : 테이블의 구성을 파악하는 SQL문
DESC salgrade;
--SELECT : 데이터베이스에 보관되어 있는 데이터를 조회할 때 사용하는 SQL문
SELECT * FROM emp;
SELECT empno, ename, deptno FROM emp;
--DISTINCT : 열의 중복을 제거하고 출력하는 SQL문
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT job, deptno FROM emp;
SELECT DISTINCT empno FROM emp;
SELECT ALL job, deptno FROM emp;
SELECT job, deptno FROM emp;
--열 이름에 연산자 및 별칭 정하기
SELECT ename, sal, sal*12+comm AS YEAR, comm FROM emp;
-- ORDER BY : SELECT문으로 데이터 조회시 오름차순이나 내림차순 정렬을 하는 SQL문
SELECT * FROM emp ORDER BY deptno;
SELECT * FROM emp ORDER BY deptno ASC;
SELECT * FROM emp ORDER BY deptno DESC;
SELECT * FROM emp ORDER BY deptno, sal DESC, empno DESC;

--4장 연습문제
--2
SELECT DISTINCT job FROM emp;
--3
SELECT 
    empno AS EMPLOYEE_NO,
    ename AS EMPLOYEE_NAME,
    job,
    mgr AS MANAGER,
    hiredate,
    sal AS SALARY,
    comm AS COMMISSION,
    deptno AS DEPARTMENT_NO
FROM emp
ORDER BY 
    deptno DESC
    , ename;


