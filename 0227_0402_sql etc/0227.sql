
1.
SELECT * FROM emp WHERE ename LIKE '%S';


2.
SELECT empno, ename, job, sal, deptno FROM emp
WHERE deptno = 30
AND job = 'SALESMAN';


3.
집합 연산자를 사용하지 않은 방식
SELECT empno, ename, sal, deptno FROM emp
WHERE deptno IN (20,30) AND sal > 2000;

집합 연산자를 사용한 방식
SELECT empno, ename, sal, deptno FROM emp WHERE deptno = 20 AND sal > 2000
UNION
SELECT empno, ename, sal, deptno FROM emp WHERE deptno = 30 AND sal > 2000


4.
SELECT * FROM emp WHERE NOT (sal >= AND sal <= 3000);
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
SELECT * FROM emp WHERE sal < 2000 and sal > 3000;


5.
SELECT ename, empno, sal, deptno FROM emp
WHERE ename LIKE '%E%'
AND deptno = 30
AND sal NOT BETWEEN 1000 AND 2000;

6.
SELECT * FROM emp
WHERE comm IS NULL 
AND mgr IS NOT NULL
AND job IN ('MANAGER','CLERK')
AND ename NOT LIKE '_L%';



--대소문자 변환함수
SELECT ename, UPPER(ename), LOWER(ename), INITCAP(ename) FROM emp;

SELECT * FROM emp WHERE UPPER(ename) = UPPER('Scott');
SELECT * FROM emp WHERE UPPER(ename) LIKE UPPER('%ScOtT%');


--LENGT(열 이름) 문자열의 길이를 구하는 함수
SELECT ename, LENGTH(ename) FROM emp;
SELECT ename, LENGTH(ename) FROM emp WHERE LENGTH(ename) >= 5;

--byte수를 검색할때 LENGTHB쓰면 됌, dual은 오라클에서 만들어놓은 더미 데이터. 구할때 그냥 쓰라고 둠.
SELECT LENGTH('한글'), LENGTHB('한글') FROM dual;
SELECT LENGTH('한글'), LENGTHB('한글') FROM emp;
SELECT * FROM dual;


--SUBSTR : 문자열의 일부를 추출하는 함수
--CLERK를 -로 표시하면 C부터 -5,-4,-3,-2,-1
SELECT job, SUBSTR(job,1,2), SUBSTR (job,3,2), SUBSTR(job,5) FROM emp;
SELECT job,
SUBSTR(job,-LENGTH(job)),
SUBSTR(job,-LENGTH(job),2),
SUBSTR(job, -3)
FROM emp;


--사원 이름의 첫 두글자와 마지막 두글자를 추력하는 SQL문을 작성하세요
SELECT ename,
SUBSTR(ename,1,2),
SUBSTR(ename,-2,2)
FROM emp;


--주민등록번호의 앞 6글자와 전화번호의 앞 8글자만 출력하는 SQL문을 작성하세요
SELECT '900101-1234567', SUBSTR('900101-1234567',1,6),
'010-1234-5678', SUBSTR('010-1234-5678',1,8) FROM dual;


--INSTR() : 문자열 데이터 안에서 특정 문자 위치를 찾는 함수
SELECT INSTR('HELLO, ORACLE!', 'ORACLE') AS INSTR_1,
INSTR('HELLO, ORACLE!', 'L',5) AS INSTR_2,
INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_3
FROM dual;

SELECT ename,INSTR(ename,'S') FROM emp WHERE INSTR(ename, 'S') > 0;
SELECT * FROM emp WHERE ename LIKE '%S%';

--INSTR과 LIKE를 사용하여 두번째와 세번째 글자가 LA인 사원 이름을 찾는 SQL문을 작성하세요
SELECT * FROM emp WHERE ename LIKE '_LA%';
SELECT * FROM emp WHERE INSTR(ename,'LA') = 2; 

--REPLACE : 특정 문자를 다른 문자로 바꿔주는 함수
SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE(UPPER('HELLO, ORaClE!'),UPPER('OrACLe'),'PYTHON') AS REPLACE,
    REPLACE('010-1234-5678','-') AS REPLACE
    FROM dual;

--LPAD(), RPAD() : 데이터의 빈 공간을 특정 문자로 채우는 함수
SELECT 'Oracle',
    LPAD('Oracle', 10, '#') AS LPAD_1,
    RPAD('Oracle', 10, '*') AS RPAD_1,
    LPAD('Oracle', 10) AS LPAD_2,
    RPAD('Oracle', 10) AS RPAD_2
    FROM dual;

SELECT
    RPAD('971225-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-', 13, '*') AS RPAD_PHONE
    FROM dual;

--주민등록 번호의 7자리를 출력하고, 나머지는 *로 출력하는 SQL문
--전화번호의 9자리를 출력하고, 나머지는 *로 출력하는 SQL문
SELECT
  '900101-1234567', RPAD(SUBSTR('900101-1234567',1,7),LENGTH('900101-1234567'), '*'),
  '010-1234-5678', RPAD(SUBSTR('010-1234-5678',1,9),LENGTH('010-1234-5678'), '*')
FROM dual;


--CONCAT 함수
SELECT
CONCAT (empno, ename),
CONCAT(empno, CONCAT(' : ', ename))
FROM emp;


--'|'으로 똑같은 기능할 수 있음
SELECT
empno || ename,
empno || ' : ' || ename || ' : ' || job
FROM emp;


--TRIM : 양쪽 공백이나 특정 문자를 삭제하는 함수
SELECT '[' || TRIM(' - -Oracle- - ') || ']' AS TRIM,
       '[' || TRIM('-' FROM '---Oracle---') || ']' AS TRIM
       FROM dual;
       
--LTRIM, RTRIM
SELECT '[' || TRIM(' -Oracle- ') || ']' AS TRIM,
'[' || LTRIM(' -Oracle- ') || ']' AS LTRIM,
'[' || LTRIM('<-Oracle->', '-<') || ']' AS LTRIM,
'[' || RTRIM(' -Oracle- ') || ']' AS RTRIM,
'[' || RTRIM('<-Oracle->', '>-') || ']' AS RTRIM
FROM dual;

--ROUND : 반올림을 실행하는 함수
SELECT
    ROUND(1234.5678) AS ROUND,
    ROUND(1234.5678, 0) AS ROUND_0,
    ROUND(1234.5678, 1) AS ROUND_1,
    ROUND(1234.5678, 2) AS ROUND_2,
    ROUND(1234.5678, -1) AS ROUND_M1,
    ROUND(1234.5678, -2) AS ROUND_M2
FROM dual;

--TRUNC : 버림
SELECT 
    TRUNC(1234.5678) AS TRUNC,
    TRUNC(1234.5678, 0) AS TRUNC_0,
    TRUNC(1234.5678, 1) AS TRUNC_1,
    TRUNC(1234.5678, 2) AS TRUNC_2,
    TRUNC(1234.5678, -1) AS TRUNC_M1,
    TRUNC(1234.5678, -2) AS TRUNC_M2
FROM dual;
--ex)평균, 주급, 월급 등에서 계산할 때 사용
SELECT TRUNC(sal/1.2) FROM emp;


--CEIL, FLOOR : 가장 가까운 큰 정수, 작은 정수를 찾아줌
SELECT CEIL(3.14),
FLOOR(3.14),
CEIL(-3.14),
FLOOR(-3.14)
FROM dual;

--MOD : 숫자를 나눈 나머지 값을 구하는 함수(다른 언어에서는 그냥 %쓰면 되는 경우가 많음)
SELECT MOD(15, 6),
MOD(10, 2),
MOD(11, 6)
FROM dual;

--SYSDATE : 현재 날짜를 출력하는 함수
SELECT SYSDATE AS NOW,
SYSDATE-1 AS YESTERDAY,
SYSDATE+1 AS TOMORROW
FROM dual;


--ADD MONTHS : 개월수를 더하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE,4) FROM dual;

SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 12*10) AS WORK10YEAR
FROM emp;

SELECT empno, ename, hiredate, SYSDATE FROM emp
WHERE ADD_MONTHS(hiredate,12*37) > SYSDATE;


--MONTH BETWEEN
SELECT empno, ename, hiredate, SYSDATE,
    MONTHS_BETWEEN(hiredate,SYSDATE) AS MONTHS1,
    MONTHS_BETWEEN(SYSDATE,hiredate) AS MONTHS2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) AS MONTHS3,
    SYSDATE-hiredate AS DAYS
    --DATE + DATE는 불가능하다.
FROM emp;

--NEXT_DAY : 돌아오는 요일을 출력하는 함수(기한이 60일 일때, 마지막 날이 주말이면 다음주 월요일로 기간연장할 때 씀)
--LAST_DAY : 월의 마지막 날을 출력하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일'), LAST_DAY('2023-04-07') FROM dual;


--현재 날짜를 기준으로 3달 후의 가장 가까운 수요일의 날짜와 마지막 날을 출력하는 SQL문을 작성해보세요.
SELECT SYSDATE, NEXT_DAY(ADD_MONTHS(SYSDATE,3), '수요일'), LAST_DAY(ADD_MONTHS(SYSDATE,3)) FROM dual;


--자동 형 변환
SELECT 100 + '200.2' FROM dual;
SELECT '2024/02/27' - hiredate FROM emp;  --오류 생김

--TO_CHAR : 숫자, 날짜 데이터를 문자 데이터로 변환하는 함수
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간,
 TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH12:MI:SS') AS AM,
 TO_CHAR(SYSDATE, 'RR-MM-DD DY HH24:MI:SS') AS DY
FROM dual;

SELECT SYSDATE,
  TO_CHAR(SYSDATE, 'MM') AS MM,
  TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR,
  TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
  TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG,
  TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MONTH_KOR,
  TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
  TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_ENG
FROM dual;


SELECT SYSDATE,
  TO_CHAR(SYSDATE, 'MM') AS MM,
  TO_CHAR(SYSDATE, 'DD') AS DD,
  TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') AS DY_KOR,
  TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JPN,
  TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DY_ENG,
  TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN') AS DAY_KOR,
  TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JPN,
  TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DAY_ENG
FROM dual;



--
SELECT sal,
    TO_CHAR(sal, '$999,999') AS sal_$,
    TO_CHAR(sal, 'L999,999') AS sal_L,
    TO_CHAR(sal, '999,999.00') AS sal_1,
    TO_CHAR(sal, '000,999,999.00') AS sal_2,
    TO_CHAR(sal, '000999999.99') AS sal_3,
    TO_CHAR(sal, '999,999,00') AS sal_4
FROM emp;


--TO_NUMBER : 문자(숫자로된 문자들)를 숫자로 변환하는 함수
SELECT '1,500' - '1,300' FROM dual; --쉼표를 숫자로 변환하지 못해 에러 발생
SELECT TO_NUMBER('1,500','999,999') - TO_NUMBER('1,300','999,999') FROM dual;


--03/05
--TO_DATE : 문자 데이터를 날짜 데이터로 변환하는 함수
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE,
       TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE
       FROM dual;

--실습 6-43
SELECT*FROM emp
WHERE hiredate > TO_DATE('1981/06/01', 'YYYY/MM/DD');
--'TO_DATE'빠져도 실행되긴하는데, 월, 일 년의 순서가 섞일 수 있음.


--실습6-45 NVL 함수 사용하여 출력하기
SELECT empno, ename, sal, comm, sal+comm, 
    NVL(comm,0),
    sal+NVL(comm,0) 
    FROM emp;
--sal+comm하면 'null'나오는게 있는데, sal + null하면 null이 나와버림.
--이럴때 null을 0으로 바꿔주고 계산하게 하는거.
--출력할때 NVL안에 있는 ex) (comm,0)이 두개는 데이터 타입이 같아야함(숫자/문자 등등)

--실습6-46 NVL2 함수를 사용하여 출력하기
SELECT empno, ename, comm,
    NVL2(comm,'0','X'),
    NVL2(comm, sal*12+comm, sal*12) AS ANNSAL
    FROM emp;
--NVL2는, 그냥 NVL보다 매개변수가 하나 추가됨. ex) (comm,'O' <-comm이 null이 아닐때 'o',
--'X' <-comm이 null이면 'X'). 그래서 실습내용 의미는, 커미션 있으면 월급*12개월+커미션, 없으면 그냥 월급*12만)
  
--실습 6-47 : DECODE 함수를 사용하여 출력하기
SELECT empno, ename, job, sal,
    DECODE(job,
            'MANAGER', sal*1.1,
            'SALESMAN', sal*1.05,
            'ANALYST',sal,
            sal*1.03) AS UPSAL
FROM emp;
--제일 마지막에 'sal*1.03'이거는, 표시한 MANAGER, SALESMAN, ANALYST이외의 다른 모든 job들을 의미함
--DECODE문 보다 CASE문이 더 범용성이 있어서 많이 씀

--실습 6-48 : CASE문을 사용하여 출력
SELECT empno, ename, job, sal,
    CASE job
         WHEN 'MANAGER' THEN sal*1.1
         WHEN 'SALESMAN' THEN sal*1.05
         WHEN 'ANALYST' THEN sal
         ELSE sal*1.03
    END AS UPSAL
FROM emp;
--DECODE보다 CASE문을 훨씬 더 많이 씀

--실습 6-49 : 열 값에 따라서 출력 값이 달라지는 CASE문
SELECT empno, ename, comm,
    CASE
        WHEN comm IS NULL THEN '해당사항 없음'
        WHEN comm = 0 THEN '수당없음'
        WHEN comm > 0 THEN '수당 : ' || comm
    END AS comm_text
FROM emp;
--WHEN 끝에 따라오는 데이터 타입은 다 같아야 한다. 문자면 문자. 숫자면 숫자. 만약에 다른거 다 
--문자 인데 숫자 넣고 싶으면 'TO_CHAR(comm)'이런식으로 하면된다.
        
--174~175p 6장 연습문제
--Q1
SELECT empno,
       SUBSTR(empno, 1, 2) || '**' AS masiking_empno,       
       ename,
       SUBSTR(ename, 1, 1) || '****' AS masiking_ename
FROM emp WHERE LENGTH(ename)>=5 AND LENGTH(ename)<6;

--SELECT empno,
--       RPAD(SUBSTR(empno, 1, 2), 4, '**') AS masiking_empno,       
--       ename,
--       RPAD(SUBSTR(ename, 1, 1), LENGTH(ename), '****') AS masiking_ename
--FROM emp WHERE LENGTH(ename)>=5 AND LENGTH(ename)<6;

--Q2
SELECT empno, ename, sal,
       TRUNC(sal/21.5, 2) AS day_pay,
       ROUND(sal/21.5/8, 1) AS time_pay
FROM emp;

--Q3
SELECT empno, ename, hiredate,
      TO_CHAR(NEXT_DAY(ADD_MONTHS(hiredate,3), '월요일'),'YYYY-MM-DD') AS R_JOB,
      CASE
      WHEN comm IS NULL THEN 'N/A'
      ELSE TO_CHAR(comm)
      END AS comm
FROM emp;

--Q4
SELECT empno, ename,  

CASE 
    WHEN TO_CHAR(mgr) IS NULL THEN ' ' 
    ELSE TO_CHAR(mgr) 
    END AS MGR,
CASE
        WHEN mgr IS NULL THEN '0000'        
        WHEN SUBSTR(mgr,1,2) = '75' THEN '5555'   
        WHEN mgr LIKE '76%' THEN '6666'  
        WHEN INSTR(mgr,'77') = 1  THEN '7777'  
        WHEN SUBSTR(mgr,1,2) = '78' THEN '8888'   
        ELSE TO_CHAR(mgr) 
END AS CHG_MGR
FROM emp;

--1)
--SELECT empno, ename,
--CASE 
--    WHEN TO_CHAR(mgr) IS NULL THEN ' ' 
--    ELSE TO_CHAR(mgr) 
--    END AS MGR
--FROM emp;
--
--이거는 단독으로 실행했을때는 됬는데, 이어 붙였을때는안됬다.
--그 이유는 END AS MGR 뒤에 ,를 붙이면 해결됨
--
--2)
--NVL(TO_CHAR(mgr), ' ') AS mgr
--공백(black)는 문자열로 취급해서 TO_CHAR써야함

