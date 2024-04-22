--WHERE절 : SELECT문에서 특정 행을 출력하는 SQL문
SELECT * FROM emp;

SELECT * FROM emp
WHERE deptno = 20;
--AND : 그리고 : 양쪽 항의 결과가 모두 true(참)일때 true를 반환하고 나머지는 모두 false(거짓)
SELECT * FROM emp WHERE deptno=30 AND job='SALESMAN';
--OR : 또는 : 양쪽 항 중에 하나라도 결과 true라면 true 반환, 양쪽 항이 모두 false이면 false를 반환
SELECT * FROM emp WHERE deptno = 30 OR job = 'CLERK';
-- 20번 부서에 직책이 CLERK인 사람을 출력하는 SQL문을 작성해보세요.
SELECT * FROM emp WHERE deptno=20 AND job='CLERK';
-- 10번 부서이거나 직책이 MANAGER인 사람을 출력하는 SQL문을 작성해보세요.
SELECT * FROM emp WHERE deptno=10 OR job='MANAGER';

--대소 비교 연산자 : <, <=, >, >=
SELECT * FROM emp WHERE sal > 1000;
SELECT * FROM emp WHERE sal >= 2000;
SELECT * FROM emp WHERE sal < 1600;
SELECT * FROM emp WHERE sal <= 1600;
SELECT * FROM emp WHERE ename <= 'FORC';
--등가 비교 연산자 : =, !=, <>, ^=
SELECT * FROM emp WHERE sal = 3000;
SELECT * FROM emp WHERE sal != 3000;
SELECT * FROM emp WHERE sal <> 3000;
SELECT * FROM emp WHERE sal ^= 3000;
-- 사원 정보 테이블에서 급여를 2000이상 받으면서 직책이 MANAGER가 아닌 사람을 출력하는 SQL문을 작성해보세요.
SELECT * FROM emp 
 WHERE sal >= 2000 
   AND job <> 'MANAGER'; 
-- NOT 연산자 : 다르다 : !=, <>, ^= 
SELECT * FROM emp WHERE NOT(sal = 3000 OR sal = 1600);
SELECT * FROM emp WHERE sal != 3000 AND sal != 1600;
--IN 연산자 : 조건이 여러개 일때 사용하는 연산자
SELECT * FROM emp WHERE job IN ('MANAGER', 'PRESIDENT','CLERK');
SELECT * FROM emp WHERE job = 'MANAGER' OR job = 'PRESIDENT' OR job = 'CLERK';
SELECT * FROM emp WHERE job NOT IN ('MANAGER', 'PRESIDENT','CLERK');
SELECT * FROM emp WHERE job != 'MANAGER' AND job <> 'PRESIDENT' AND job ^= 'CLERK';
--IN연산자를 사용하여 부서번호가 10,20번인 사원 정보를 출력해보세요.
SELECT * FROM emp WHERE deptno IN (10,20);
--BETWEEN A AND B : A보다 크거나 같고 B보다 작거나 같을때 출력하는 연산자
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;
-- 대소 비교 연산자를 이용하여 급여가 2000보다 크거나 같고 3000보다 작거나 같은 사원을 출력하는 SQL문을 작성하세요.
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
SELECT * FROM emp WHERE sal < 2000 OR sal > 3000;
--LIKE 연산자 : 비슷한 문자열 찾는 연산자
--와일드 카드 문자 : _ , %
-- _ : 어떤 문자던 상관없이 한 글자
-- % : 어떤 문자던 상관없이 여러 문자
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename LIKE '_L%';
-- 사원의 이름에 세번째 글자가 L인 사원을 출력하는 SQL을 작성해보세요.
SELECT * FROM emp WHERE ename LIKE '__L%';
--이름의 세번째 문자가 L이 아닌 사원을 출력하는 SQL문을 작성하세요.
SELECT * FROM emp WHERE ename NOT LIKE '__L%';
-- IS NULL : NULL인지 아닌지 확인하는 연산자
SELECT * FROM emp WHERE mgr IS NULL;
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE mgr IS NOT NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;
--UNION : 중복 제거하는 합집합
SELECT * FROM emp WHERE deptno = 20
UNION
SELECT * FROM emp WHERE deptno = 30;
SELECT * FROM emp WHERE deptno IN (20,30) ORDER BY deptno;
--UNION의 제약사항
-- 1. 출력 열의 개수가 같아야 한다. 
SELECT empno, ename, sal, deptno FROM emp WHERE deptno = 20
UNION
SELECT empno, ename, sal FROM emp WHERE deptno = 30;
-- 2. 출력 열의 자료형이 같아야 한다.
SELECT empno, ename, sal FROM emp WHERE deptno = 20
UNION
SELECT ename, empno, sal FROM emp WHERE deptno = 30;
SELECT empno, ename, sal FROM emp WHERE deptno = 20
UNION
SELECT sal, job, empno FROM emp WHERE deptno = 30;

SELECT empno, ename, job FROM emp WHERE deptno = 10
UNION
SELECT deptno, dname, loc FROM dept;     
--UNION ALL : 중복이 제거되지 않는 합집합
SELECT * FROM emp WHERE deptno = 10
UNION ALL
SELECT * FROM emp WHERE deptno = 10;
--MINUS : 차집합
SELECT * FROM emp
MINUS
SELECT * FROM emp WHERE deptno = 10;
SELECT * FROM emp WHERE deptno !=10;
--INTERSECT : 교집합
SELECT * FROM emp
INTERSECT
SELECT * FROM emp WHERE deptno = 10;
--연산자의 우선순위
--0. ()
--1. *, /
--2. + , -
--3. 비교 연산자, >, >=, <, <=, =, !=, <>, ^=
--4. IS NULL, LIKE, IN
--5. BETWEEN A AND B
--6. NOT
--7. AND
--8. OR

