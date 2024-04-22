--1. 아래의 값에 맞게 emp테이블에 데이터를 추가하라.
 -- 사원번호:1011, 이름:이순신, 부서번호:104, 직책:부장, 급여:500, 직속상사:NULL
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (1011, '이순신', 104, '부장', 500, null);

--2. dept 테이블에 area 필드의 값을 영업부는 서울, 나머지는 부산으로 값을 업데이트하라.
UPDATE dept SET area = CASE WHEN deptno = 101 THEN '서울' ELSE '부산' END;

--3. emp 테이블에서 부서 이름이 홍보부인 데이터를 삭제하라. 
DELETE FROM emp
WHERE deptno IN (SELECT deptno FROM dept WHERE dname = '홍보부');

--4. emp 테이블을 사용하여 이름,  급여, 세금을 출력하라. 단 세금은 급여가 0-200이면 급여의 5%, 201-300이면 급여의 10%, 301-400 이면 급여의 15%, 나머지는 급여의 20%로 지정한다.(case문 사용)
-- CASE 조건문
SELECT name, pay,
    CASE
    WHEN pay <= 200 THEN pay * 0.05
    WHEN pay <= 300 THEN pay * 0.1
    WHEN pay <= 400 THEN pay * 0.15
    ELSE pay * 0.20
    END AS tax;
FROM emp;

--5. 영업부 직원과 총무부 직원의 이름, 부서명, 직급을 이름순으로 오름차순으로 출력하라.
SELECT E.name, D.dname, E.postion
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE d.dname IN ('영업부', '총무부')
ORDER BY e.name ASC;

--6. emp 테이블을 이용하여 사원의 이름과 직속상관의 이름을 출력하라. 단 직속상관이 없는 경우 null이 표시되도록 하라.
SELECT e.name AS Employee, m.name AS Manager
FROM emp e
LEFT JOIN emp m ON e.pempno = m.empno;

--7. 부서별 급여의 평균이 350 이상인 부서의 부서명, 급여의 평균을 구하라.
SELECT D.dname, AVG(E.pay) AS avg_pay
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
GROUP BY D.dname
HAVING AVG(E.pay) > 350;

--8. emp 테이블에서 각 부서별 급여가 가장 높은 사람의 이름, 부서명, 급여를 출력하라(sub query).
SELECT E.name, D.dname, E.pay
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
WHERE E.pay = (SELECT MAX(pay) FROM emp WHERE deptno = D.deptno);
    
--9. emp 테이블에서 이성규와 같은 부서의 직원의 이름과 부서명을 출력하라.(sub query)
SELECT E.name, D.dname
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno 
WHERE E.name = '이성규';


--10. 과장의 최소급여보다 높은 급여를 받는 사람의 이름, 직급, 급여를 출력하라.(sub query)
SELECT E.name, E.position, D.dname
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
WHERE E.pay >= (SELECT MIN(pay) FROM emp WHERE position = '과장');




CREATE TABLE 상품 (
  상품코드 VARCHAR(4) PRIMARY KEY,
  상품명 VARCHAR(10),
  메이커명 VARCHAR(10),
  가격 INT,
  상품분류 VARCHAR(12)
 );
 
 
 INSERT INTO 상품 (상품코드, 상품명, 메이커명, 가격, 상품분류) VALUES (0001, '상품1', '메이커1', 100, '식료품');
 INSERT INTO 상품 (상품코드, 상품명, 메이커명, 가격, 상품분류) VALUES (0002, '상품2', '메이커2', 200, '식료품');
 INSERT INTO 상품 (상품코드, 상품명, 메이커명, 가격, 상품분류) VALUES (0003, '상품3', '메이커3', 1980, '생활용품');
 

CREATE TABLE 재고수 (
  상품코드 VARCHAR(4) CONSTRAINT fk_상품_to_재고수 REFERENCES 상품(상품코드),
  입고날짜 DATE,
  재고수 INT
 );
 
 INSERT INTO 재고수 (상품코드, 입고날짜, 재고수) VALUES (0001, '2019-01-03', 200);
 INSERT INTO 재고수 (상품코드, 입고날짜, 재고수) VALUES (0002, '2019-02-10', 500);
 INSERT INTO 재고수 (상품코드, 입고날짜, 재고수) VALUES (0003, '2019-02-14', 10);

SELECT S.상품명, J.재고수
FROM 상품 S
JOIN 재고수 J ON S.상품코드 = J.상품코드
WHERE 상품분류 = '식료품';

SELECT * FROM 상품;
SELECT * FROM 재고수;







