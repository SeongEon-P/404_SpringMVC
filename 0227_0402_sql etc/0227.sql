
1.
SELECT * FROM emp WHERE ename LIKE '%S';


2.
SELECT empno, ename, job, sal, deptno FROM emp
WHERE deptno = 30
AND job = 'SALESMAN';


3.
���� �����ڸ� ������� ���� ���
SELECT empno, ename, sal, deptno FROM emp
WHERE deptno IN (20,30) AND sal > 2000;

���� �����ڸ� ����� ���
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



--��ҹ��� ��ȯ�Լ�
SELECT ename, UPPER(ename), LOWER(ename), INITCAP(ename) FROM emp;

SELECT * FROM emp WHERE UPPER(ename) = UPPER('Scott');
SELECT * FROM emp WHERE UPPER(ename) LIKE UPPER('%ScOtT%');


--LENGT(�� �̸�) ���ڿ��� ���̸� ���ϴ� �Լ�
SELECT ename, LENGTH(ename) FROM emp;
SELECT ename, LENGTH(ename) FROM emp WHERE LENGTH(ename) >= 5;

--byte���� �˻��Ҷ� LENGTHB���� ��, dual�� ����Ŭ���� �������� ���� ������. ���Ҷ� �׳� ����� ��.
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM dual;
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM emp;
SELECT * FROM dual;


--SUBSTR : ���ڿ��� �Ϻθ� �����ϴ� �Լ�
--CLERK�� -�� ǥ���ϸ� C���� -5,-4,-3,-2,-1
SELECT job, SUBSTR(job,1,2), SUBSTR (job,3,2), SUBSTR(job,5) FROM emp;
SELECT job,
SUBSTR(job,-LENGTH(job)),
SUBSTR(job,-LENGTH(job),2),
SUBSTR(job, -3)
FROM emp;


--��� �̸��� ù �α��ڿ� ������ �α��ڸ� �߷��ϴ� SQL���� �ۼ��ϼ���
SELECT ename,
SUBSTR(ename,1,2),
SUBSTR(ename,-2,2)
FROM emp;


--�ֹε�Ϲ�ȣ�� �� 6���ڿ� ��ȭ��ȣ�� �� 8���ڸ� ����ϴ� SQL���� �ۼ��ϼ���
SELECT '900101-1234567', SUBSTR('900101-1234567',1,6),
'010-1234-5678', SUBSTR('010-1234-5678',1,8) FROM dual;


--INSTR() : ���ڿ� ������ �ȿ��� Ư�� ���� ��ġ�� ã�� �Լ�
SELECT INSTR('HELLO, ORACLE!', 'ORACLE') AS INSTR_1,
INSTR('HELLO, ORACLE!', 'L',5) AS INSTR_2,
INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_3
FROM dual;

SELECT ename,INSTR(ename,'S') FROM emp WHERE INSTR(ename, 'S') > 0;
SELECT * FROM emp WHERE ename LIKE '%S%';

--INSTR�� LIKE�� ����Ͽ� �ι�°�� ����° ���ڰ� LA�� ��� �̸��� ã�� SQL���� �ۼ��ϼ���
SELECT * FROM emp WHERE ename LIKE '_LA%';
SELECT * FROM emp WHERE INSTR(ename,'LA') = 2; 

--REPLACE : Ư�� ���ڸ� �ٸ� ���ڷ� �ٲ��ִ� �Լ�
SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE(UPPER('HELLO, ORaClE!'),UPPER('OrACLe'),'PYTHON') AS REPLACE,
    REPLACE('010-1234-5678','-') AS REPLACE
    FROM dual;

--LPAD(), RPAD() : �������� �� ������ Ư�� ���ڷ� ä��� �Լ�
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

--�ֹε�� ��ȣ�� 7�ڸ��� ����ϰ�, �������� *�� ����ϴ� SQL��
--��ȭ��ȣ�� 9�ڸ��� ����ϰ�, �������� *�� ����ϴ� SQL��
SELECT
  '900101-1234567', RPAD(SUBSTR('900101-1234567',1,7),LENGTH('900101-1234567'), '*'),
  '010-1234-5678', RPAD(SUBSTR('010-1234-5678',1,9),LENGTH('010-1234-5678'), '*')
FROM dual;


--CONCAT �Լ�
SELECT
CONCAT (empno, ename),
CONCAT(empno, CONCAT(' : ', ename))
FROM emp;


--'|'���� �Ȱ��� ����� �� ����
SELECT
empno || ename,
empno || ' : ' || ename || ' : ' || job
FROM emp;


--TRIM : ���� �����̳� Ư�� ���ڸ� �����ϴ� �Լ�
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

--ROUND : �ݿø��� �����ϴ� �Լ�
SELECT
    ROUND(1234.5678) AS ROUND,
    ROUND(1234.5678, 0) AS ROUND_0,
    ROUND(1234.5678, 1) AS ROUND_1,
    ROUND(1234.5678, 2) AS ROUND_2,
    ROUND(1234.5678, -1) AS ROUND_M1,
    ROUND(1234.5678, -2) AS ROUND_M2
FROM dual;

--TRUNC : ����
SELECT 
    TRUNC(1234.5678) AS TRUNC,
    TRUNC(1234.5678, 0) AS TRUNC_0,
    TRUNC(1234.5678, 1) AS TRUNC_1,
    TRUNC(1234.5678, 2) AS TRUNC_2,
    TRUNC(1234.5678, -1) AS TRUNC_M1,
    TRUNC(1234.5678, -2) AS TRUNC_M2
FROM dual;
--ex)���, �ֱ�, ���� ��� ����� �� ���
SELECT TRUNC(sal/1.2) FROM emp;


--CEIL, FLOOR : ���� ����� ū ����, ���� ������ ã����
SELECT CEIL(3.14),
FLOOR(3.14),
CEIL(-3.14),
FLOOR(-3.14)
FROM dual;

--MOD : ���ڸ� ���� ������ ���� ���ϴ� �Լ�(�ٸ� ������ �׳� %���� �Ǵ� ��찡 ����)
SELECT MOD(15, 6),
MOD(10, 2),
MOD(11, 6)
FROM dual;

--SYSDATE : ���� ��¥�� ����ϴ� �Լ�
SELECT SYSDATE AS NOW,
SYSDATE-1 AS YESTERDAY,
SYSDATE+1 AS TOMORROW
FROM dual;


--ADD MONTHS : �������� ���ϴ� �Լ�
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
    --DATE + DATE�� �Ұ����ϴ�.
FROM emp;

--NEXT_DAY : ���ƿ��� ������ ����ϴ� �Լ�(������ 60�� �϶�, ������ ���� �ָ��̸� ������ �����Ϸ� �Ⱓ������ �� ��)
--LAST_DAY : ���� ������ ���� ����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '������'), LAST_DAY('2023-04-07') FROM dual;


--���� ��¥�� �������� 3�� ���� ���� ����� �������� ��¥�� ������ ���� ����ϴ� SQL���� �ۼ��غ�����.
SELECT SYSDATE, NEXT_DAY(ADD_MONTHS(SYSDATE,3), '������'), LAST_DAY(ADD_MONTHS(SYSDATE,3)) FROM dual;


--�ڵ� �� ��ȯ
SELECT 100 + '200.2' FROM dual;
SELECT '2024/02/27' - hiredate FROM emp;  --���� ����

--TO_CHAR : ����, ��¥ �����͸� ���� �����ͷ� ��ȯ�ϴ� �Լ�
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS ���糯¥�ð�,
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


--TO_NUMBER : ����(���ڷε� ���ڵ�)�� ���ڷ� ��ȯ�ϴ� �Լ�
SELECT '1,500' - '1,300' FROM dual; --��ǥ�� ���ڷ� ��ȯ���� ���� ���� �߻�
SELECT TO_NUMBER('1,500','999,999') - TO_NUMBER('1,300','999,999') FROM dual;


--03/05
--TO_DATE : ���� �����͸� ��¥ �����ͷ� ��ȯ�ϴ� �Լ�
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE,
       TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE
       FROM dual;

--�ǽ� 6-43
SELECT*FROM emp
WHERE hiredate > TO_DATE('1981/06/01', 'YYYY/MM/DD');
--'TO_DATE'������ ����Ǳ��ϴµ�, ��, �� ���� ������ ���� �� ����.


--�ǽ�6-45 NVL �Լ� ����Ͽ� ����ϱ�
SELECT empno, ename, sal, comm, sal+comm, 
    NVL(comm,0),
    sal+NVL(comm,0) 
    FROM emp;
--sal+comm�ϸ� 'null'�����°� �ִµ�, sal + null�ϸ� null�� ���͹���.
--�̷��� null�� 0���� �ٲ��ְ� ����ϰ� �ϴ°�.
--����Ҷ� NVL�ȿ� �ִ� ex) (comm,0)�� �ΰ��� ������ Ÿ���� ���ƾ���(����/���� ���)

--�ǽ�6-46 NVL2 �Լ��� ����Ͽ� ����ϱ�
SELECT empno, ename, comm,
    NVL2(comm,'0','X'),
    NVL2(comm, sal*12+comm, sal*12) AS ANNSAL
    FROM emp;
--NVL2��, �׳� NVL���� �Ű������� �ϳ� �߰���. ex) (comm,'O' <-comm�� null�� �ƴҶ� 'o',
--'X' <-comm�� null�̸� 'X'). �׷��� �ǽ����� �ǹ̴�, Ŀ�̼� ������ ����*12����+Ŀ�̼�, ������ �׳� ����*12��)
  
--�ǽ� 6-47 : DECODE �Լ��� ����Ͽ� ����ϱ�
SELECT empno, ename, job, sal,
    DECODE(job,
            'MANAGER', sal*1.1,
            'SALESMAN', sal*1.05,
            'ANALYST',sal,
            sal*1.03) AS UPSAL
FROM emp;
--���� �������� 'sal*1.03'�̰Ŵ�, ǥ���� MANAGER, SALESMAN, ANALYST�̿��� �ٸ� ��� job���� �ǹ���
--DECODE�� ���� CASE���� �� ���뼺�� �־ ���� ��

--�ǽ� 6-48 : CASE���� ����Ͽ� ���
SELECT empno, ename, job, sal,
    CASE job
         WHEN 'MANAGER' THEN sal*1.1
         WHEN 'SALESMAN' THEN sal*1.05
         WHEN 'ANALYST' THEN sal
         ELSE sal*1.03
    END AS UPSAL
FROM emp;
--DECODE���� CASE���� �ξ� �� ���� ��

--�ǽ� 6-49 : �� ���� ���� ��� ���� �޶����� CASE��
SELECT empno, ename, comm,
    CASE
        WHEN comm IS NULL THEN '�ش���� ����'
        WHEN comm = 0 THEN '�������'
        WHEN comm > 0 THEN '���� : ' || comm
    END AS comm_text
FROM emp;
--WHEN ���� ������� ������ Ÿ���� �� ���ƾ� �Ѵ�. ���ڸ� ����. ���ڸ� ����. ���࿡ �ٸ��� �� 
--���� �ε� ���� �ְ� ������ 'TO_CHAR(comm)'�̷������� �ϸ�ȴ�.
        
--174~175p 6�� ��������
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
      TO_CHAR(NEXT_DAY(ADD_MONTHS(hiredate,3), '������'),'YYYY-MM-DD') AS R_JOB,
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
--�̰Ŵ� �ܵ����� ������������ ��µ�, �̾� �ٿ������¾ȉ��.
--�� ������ END AS MGR �ڿ� ,�� ���̸� �ذ��
--
--2)
--NVL(TO_CHAR(mgr), ' ') AS mgr
--����(black)�� ���ڿ��� ����ؼ� TO_CHAR�����

