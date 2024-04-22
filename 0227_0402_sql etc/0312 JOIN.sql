--집합 연산자 UNION
SELECT * FROM emp WHERE deptno = 10
UNION
SELECT * FROM emp WHERE deptno = 20;

-- 8-1 JOIN (SQL-99이전 방식) : 조인 조건 없이 실행 
SELECT * FROM emp,dept
WHERE emp.deptno = dept.deptno;
--ORDER BY empno, dept.deptno;
--SQL-99 방식
SELECT * FROM emp  -- JOIN 조건 없이 실행 불가능, JOIN은 FROM 다음에 와야한다
INNER JOIN dept ON emp.deptno = dept.deptno  --JOIN 다음에 ON이 와야하고, WHERE절의 내용이 ON 뒤에 온다. ON 없으면 안됌
ORDER BY emp.empno, dept.deptno;

-- 8-3
SELECT * FROM emp E --AS 붙이면 에러남. AS없이 그냥 한 칸 띄우고
INNER JOIN dept D ON E.deptno = D.deptno  --별칭(테이블 이름) 붙이는건 ON 뒤나, ORDER BY뒤에도 가능
ORDER BY E.empno;

--등기조인 : 특정열이 정확히 일치하는 데이터를 사용하여 JOIN을 하는 방식
--대부분 외래키를 사용하여 JOIN을 실행하게 됨
SELECT * FROM emp E
INNER JOIN dept D ON E.deptno = D.deptno;

--비등가 조인 : 등가조인을 제외한 모든 조인 방식(범위 데이터를 사용하여 조인하는 방식), 정확하게 일치하는 건 아님
SELECT * FROM emp E
INNER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal;

--자체 조인 : 같은 테이블을 두 번 사용하여 조인을 하는 방식
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
INNER JOIN emp E2 ON E.mgr = E2.empno;

SELECT * FROM emp E
INNER JOIN dept D ON E.empno = D.deptno;

-- 8-9 : 왼쪽 외부 조인 : 왼쪽 테이블을 기준으로 일치한 것과, 일치하지 않는 모든 데이터를 함께 출력하는 JOIN.
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
LEFT OUTER JOIN emp E2 ON E.mgr = E2.empno  --INNER JOIN은 일치하는 데이터만 출력, INNER JOIN을 먼저 실행 후에, 일치하지 않는 데이터도 출력해줌
ORDER BY E.empno;

-- 8-10
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
RIGHT OUTER JOIN emp E2 ON E.mgr = E2.empno
ORDER BY E.empno;  --부하직원지 존재하지 않는 데이터를 오른쪽에 출력해줌, 기준을 잡을 때 중요한건 무엇을 먼저 적느냐가 중요. 먼저 적는게 왼쪽으로 옴.

-- FULL OUTER JOIN : 왼쪽 오른쪽 양쪽의 일치하지 않는 데이터를 출력하는 구분
SELECT E.empno, E.ename, E.mgr
    ,E2.empno AS MGR_EMPNO
    ,E2.ename AS MGR_ENAME
     FROM emp E 
FULL OUTER JOIN emp E2 ON E.mgr = E2.empno
ORDER BY E.empno; 

-- NATURAL JOIN (그냥 이런게 있구나 보고 넘기면 됨) : 특정 열의 조인 조건을 직접적으로 설정하지 않고 자동으로 설정하는 조인 방식
-- 이름과 자료형이 같은 열을 찾아서 자동으로 조인하게됨
-- 등가조인만 설정 가능
-- 등가조인의 조건 (deptno)은 별칭을 쓸 수 없음
-- 8-11
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm
                deptno, D.dname, D.loc
    FROM emp E NATURAL JOIN dept D
    ORDER BY deptno, E.empno;  --단점 : 등가조인 안되고, 같은 이름이여야함
    
-- JOIN ~ USING
-- 조인에 사용할 기준열을 설정하는 방식
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm
                deptno, D.dname, D.loc
    FROM emp E JOIN dept D USING(deptno)
    ORDER BY deptno, E.empno;  
    
-- JOIN ~ ON 
-- 기준열의 이름이 달라도 조인 가능, 자료형은 같아야 함
-- 등가조인, 비등가조인, 외부조인, 자체조인 등등 모든 조인을 사용 가능
SELECT E.empno, E.ename, E.job, E.mgr, E.hiredate, E.sal, E.comm,
                D.deptno, D.dname, D.loc
    FROM emp E JOIN dept D ON E.deptno=D.deptno  --JOIN은 반드시 FROM 다음에, WHERE은 JOIN끝나면 나오ㅣ
    
    WHERE sal <= 3000
    ORDER BY deptno, E.empno;  
-- 등가조인 = 내부조인
-- 등가조인 <> 비등가조인 : 조인 조건이 = 이냐 아니냐에 따라 나뉨
-- 내부조인 <> 외부조인 : 일치하지 않는 데이터를 출력하느냐 아니냐따라 나뉨
-- 자체조인 : 같은 테이블 사용하느냐 아니냐

SELECT*
FROM emp E
    RIGHT OUTER JOIN dept D ON E.deptno = D.deptno  --여기서 한 번 JOIN됬으면, 이 뒤부터는 JOIN된 결과물에서 JOIN을 함.
    LEFT OUTER JOIN salgrade S ON E.sal  BETWEEN S.losal AND S.hisal 
    LEFT OUTER JOIN emp M ON E.mgr = M.empno
WHERE E.sal >= 2000
ORDER BY E.deptno;

--한번 OUTER JOIN 썻으면, 그 뒤에서 OUTER JOIN 계속 써줘야 일치하지 않는 데이터들이 안날아간다.

-- 239~240p, 8장 연습문제, Q1~4
-- Q1 : 급여(sal)가 2000 초과인 사원들의 부서 정보, 사원 정보를 오른쪽과 같이 출력해 보세요
SELECT D.deptno, D.dname, E.empno, E.ename, E.sal
     FROM dept D INNER JOIN emp E ON D.deptno=E.deptno
WHERE E.sal > 2000
ORDER BY D.deptno; 

-- Q2 : 오른쪽과 같이 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력해 보세요
SELECT D.deptno, D.dname,
    TRUNC(AVG(E.sal)) AS AVG_SAL,
    MAX(E.sal) AS MAX_SAL,
    MIN(E.sal) AS MIN_SAL,
    COUNT(*) AS CNT
    FROM dept D INNER JOIN emp E ON D.deptno=E.deptno
    GROUP BY D.deptno, D.dname; --AVG, MAX같은거는 다중행 함수라서 안쓴거 기준으로 GROUP BY 해야함

--Q3 : 모든 부서 정보와 사원 정보를 오른쪽과 같이 부서 번호, 사원 이름 순으로 정렬하여 출력해 보세요
SELECT D.deptno, D.dname 
         ,E.empno, E.ename,E.job, E.sal
     FROM dept D 
LEFT OUTER JOIN emp E ON E.deptno = D.deptno  --dept D를 기준으로, 일치하지 않는 데이터도 출력하기 위해서 inner join 이 아닌 outer join 쓴거임
ORDER BY D.deptno, E.ename; 

--Q4 : 다음과 같이 모든 부서 정보, 사원 정보, 급여 등급 정보, 각 사원의 직속 상관의 정보를 부서 번호, 사원 번호 순서로 정렬하여 출력해 보세요
SELECT D.deptno, D.dname, E.empno, E.ename, E.mgr, E.sal, E.deptno, S.losal, S.hisal, S.grade, M.empno AS MGR_EMPNO, M.ename AS MGR_ENAME         
     FROM dept D
     LEFT OUTER JOIN emp E ON D.deptno=E.deptno
     LEFT OUTER JOIN salgrade S ON E.sal BETWEEN S.losal AND S.hisal
     LEFT OUTER JOIN emp M ON E.mgr = M.empno
     ORDER BY D.deptno, E.empno;



