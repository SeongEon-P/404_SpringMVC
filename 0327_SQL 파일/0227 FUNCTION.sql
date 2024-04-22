-- ��ҹ��� ��ȯ�Լ� 
SELECT ename, UPPER(ename), LOWER(ename), INITCAP(ename) FROM emp;
SELECT * FROM emp WHERE UPPER(ename) = UPPER('Scott');
SELECT * FROM emp WHERE UPPER(ename) LIKE UPPER('%ScOtT%');
-- LENGTH(�� �̸�) ���ڿ��� ���̸� ���ϴ� �Լ�
SELECT ename, LENGTH(ename) FROM emp WHERE LENGTH(ename) >= 5;
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM dual;
SELECT * FROM dual;
-- SUBSTR : ���ڿ��� �Ϻθ� �����ϴ� �Լ�
SELECT job, SUBSTR(job,1,2), SUBSTR(job,3,2), SUBSTR(job,5) FROM emp;
SELECT job, 
SUBSTR(job, -LENGTH(job)),
SUBSTR(job, -LENGTH(job),2),
SUBSTR(job, -3)
FROM emp;
-- ��� �̸��� ù �α��ڿ� ������ �α��ڸ� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT ename, SUBSTR(ename,1,2), SUBSTR(ename,-2) FROM emp;
-- �ֹε�Ϲ�ȣ�� �� 6���ڿ� ��ȭ��ȣ�� �� 8���ڸ� ����ϴ� SQL���� �ۼ��� ������.
SELECT  '900101-1234567',SUBSTR('900101-1234567',1,6)
    , '010-1234-5678', SUBSTR('010-1234-5678',1,8) FROM dual;
-- INSTR() : ���ڿ� ������ �ȿ��� Ư�� ���� ��ġ�� ã�� �Լ�
SELECT INSTR('HELLO, ORACLE!','ORACLE') AS INSTR,
INSTR('HELLO, ORACLE!','L',5) AS INSTR,
INSTR('HELLO, ORACLE!','L',2,3) AS INSTR
FROM dual;
SELECT ename,INSTR(ename,'S') FROM emp E WHERE INSTR(ename,'S') > 0;
SELECT * FROM emp WHERE ename LIKE '%S%';
-- INSTR�� LIKE�� ����Ͽ� �ι�°�� ����° ���� LA�� ��� �̸��� ã�� SQL���� �ۼ��ϼ���.
SELECT * FROM emp WHERE ename LIKE '_LA%';
SELECT * FROM emp WHERE INSTR(ename,'LA') = 2;
-- REPLACE : Ư�� ���ڸ� �ٸ� ���ڷ� �ٲ��ִ� �Լ�
SELECT '010-1234-5678' AS REPLACE_BEFORE,
        REPLACE(UPPER('HELLO, oracle!'),UPPER('ORACLE'),'PYTHON') AS REPACE,
        REPLACE('010-1234-5678','010') AS REPACE 
  FROM dual;
--LPAD(), RPAD() : �������� �� ������ Ư�� ���ڷ� ä��� �Լ�
SELECT 'Oracle',
        LPAD('Oracle',10,'#') AS LPAD,
        RPAD('Oracle',10,'#') AS RPAD,
        LPAD('Oracle',10) AS LPAD,
        RPAD('Oracle',10) AS RPAD
FROM dual;

SELECT RPAD('971225-',14,'*') AS RPAD_JMNO,
        RPAD('010-1234-',13,'*') AS RPAD_PHONE FROM dual;
-- �ֹε�� ��ȣ�� 7�ڸ� ����ϰ� �������� *�� ����ϴ� SQL�� 
-- ��ȭ��ȣ�� 9�ڸ� ����ϰ� �������� *�� ����ϴ� SQL��
SELECT  '900101-1234567', RPAD(SUBSTR('900101-1234567',1,7), LENGTH('900101-1234567'), '*') 
       ,'010-1234-5678' , RPAD(SUBSTR('010-1234-5678',1,9), LENGTH('010-1234-5678'), '*') 
FROM dual;
-- CONCAT : ���ڿ��� ���ڿ��� �̾ ����ϴ� �Լ�
SELECT 
CONCAT(empno, ename), 
CONCAT(empno, CONCAT(' : ', CONCAT(ename, CONCAT(' : ', job)))) 
FROM emp;
SELECT 
empno || ename, 
empno || ' : ' || ename || ' : ' || job 
FROM emp;
-- TRIM : ���� �����̳� Ư�� ���ڸ� �����ϴ� �Լ�
SELECT '[' || TRIM(' - -Oracle- - ') || ']' AS TRIM,
        '[' || TRIM('-' FROM '- -Oracle- -') || ']' AS TRIM
FROM dual;
-- LTRIM, RTRIM
SELECT '[' || TRIM(' -Oracle- ') || ']' AS TRIM,
'[' || LTRIM(' -Oracle- ') || ']' AS LTRIM,
'[' || LTRIM('<-Oracle->', '-<') || ']' AS LTRIM,
'[' || RTRIM(' -Oracle- ') || ']' AS RTRIM,
'[' || RTRIM('<-Oracle->','>-') || ']' AS RTRIM FROM dual;

--ROUND : �ݿø��� �ϴ� �Լ�
SELECT ROUND(1234.5678) AS ROUND,
ROUND(1234.5678,0) AS ROUND,
ROUND(1234.5678,1) AS ROUND,
ROUND(1234.5678,2) AS ROUND,
ROUND(1234.5678,-1) AS ROUND_MINUS,
ROUND(1234.5678,-2) AS ROUND_MINUS FROM dual;
--TRUNC : ������ �ϴ� �Լ�
SELECT TRUNC(1234.5678) AS TRUNC,
TRUNC(1234.5678,0) AS TRUNC,
TRUNC(1234.5678,1) AS TRUNC,
TRUNC(1234.5678,2) AS TRUNC,
TRUNC(1234.5678,-1) AS TRUNC_MINUS,
TRUNC(1234.5678,-2) AS TRUNC_MINUS FROM dual;
SELECT TRUNC(sal/1.2) FROM emp;
-- CEIL, FLOOR : ���� ����� �۰ų� ū ������ ã�� �Լ�
SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14) FROM dual;
-- MOD() : ���ڸ� ���� ������ ���� ���ϴ� �Լ�
SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM dual;
-- SELECT 15%6, 10%2, 11%2 FROM dual; %�����ڴ� ��� �Ұ�

-- SYSDATE : ���� ��¥�� ����ϴ� �Լ�
SELECT SYSDATE AS NOW, SYSDATE-1 AS YESTERDAY, SYSDATE+1 AS TOMORROW FROM dual;
--ADD_MONTH : �������� ���ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE,-3) FROM dual;
SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 12*10) AS WORK10YEAR FROM emp;
SELECT empno, ename, hiredate, SYSDATE FROM emp 
WHERE ADD_MONTHS(hiredate,12*37) > SYSDATE;

SELECT empno, ename, hiredate, SYSDATE,
        SYSDATE-hiredate AS DAYS,
        -- SYSDATE+hiredate AS DYAS, DATE+DATE�� �Ұ���
        MONTHS_BETWEEN(hiredate,SYSDATE) AS MONTHS,
        MONTHS_BETWEEN(SYSDATE,hiredate) AS MONTHS,
        TRUNC(MONTHS_BETWEEN(hiredate,SYSDATE)) AS MONTHS
FROM emp;
-- NEXT_DAY : ���ƿ��� ������ ����ϴ� �Լ�
-- LAST_DAY : ���� ������ ���� ����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���'), LAST_DAY('2023-02-01') FROM dual;
-- ���糯¥�� �������� 3������ ���� ����� �������� ��¥�� ������ ���� ����ϴ� SQL���� �ۼ��غ�����.
SELECT SYSDATE,  
NEXT_DAY(ADD_MONTHS(SYSDATE,3),'������'),
LAST_DAY(ADD_MONTHS(SYSDATE,3))
FROM dual;

-- �ڵ� �� ��ȯ
SELECT 100.2 + '200.2' FROM dual;
SELECT '100' + '200' FROM dual;
SELECT hiredate - '2024/02/27' FROM emp;
--TO_CHAR : ����, ��¥ �����͸� ���� �����ͷ� ��ȯ�ϴ� �Լ�
SELECT TO_CHAR(sysdate, 'DD/MM/YYYY HH24:MI:SS'),
    TO_CHAR(sysdate, 'MM/DD/YYYY AM HH12:MI:SS'),
    TO_CHAR(sysdate, 'RR-MM-DD DY HH24:MI:SS') FROM dual;

SELECT 
    SYSDATE,
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

SELECT sal,
    TO_CHAR(sal, '$999,999') AS SAL_$,
    TO_CHAR(sal, 'L999,999') AS SAL_L,
    TO_CHAR(sal, '999,999.00') AS SAL,
    TO_CHAR(sal, '000,999,999.00') AS SAL,
    TO_CHAR(sal, '000999999.99') AS SAL,
    TO_CHAR(sal, '999,999,99') AS SAL
FROM emp;
--TO_NUMBER : ����(���ڷε� ���ڵ�)�� ���ڷ� ��ȯ�ϴ� �Լ�
SELECT '1,500' - '1,300' FROM dual; -- ,�� ���ڷ� ��ȯ���� ���� ���� �߻�
SELECT TO_NUMBER('1,500','999,999') - TO_NUMBER('1,300','999,999') FROM dual;
-- TO_DATE : ���� �����͸� ��¥ �����ͷ� ��ȯ�ϴ� �Լ�
SELECT TO_DATE('2018-07-14','YYYY-MM-DD') AS TODATE,
    TO_DATE('20180714','YYYYMMDD') AS TODATE 
FROM dual;
SELECT * FROM emp
WHERE hiredate > TO_DATE('01/06/1981', 'DD/MM/YYYY');
--6-45 NVL �Լ�
SELECT empno, ename, sal, 
    comm, sal+comm,
    NVL(comm,0), sal+NVL(comm,0)
FROM emp;
--6-46 NVL2 �Լ�
SELECT empno, ename, comm
    ,NVL2(comm, 'O','X')
    ,NVL2(comm, sal*12+comm, sal*12) AS ANNSAL
FROM emp;
--6-47 DECODE�Լ�
SELECT empno, ename, job, sal,
    DECODE(job, 'MANAGER',sal*1.1,
                'SALESMAN',sal*1.05,
                'ANALYST',sal,
                sal*1.03) AS UPSAL
FROM emp;
--6-48 CASE��
SELECT empno, ename, job, sal,
    CASE job
        WHEN 'MANAGER' THEN sal*1.1
        WHEN 'SALESMAN' THEN sal*1.05
        WHEN 'ANALYST' THEN sal
        ELSE sal*1.03
    END AS UPSAL
FROM emp;
--6-49 ���� ������ ���� ���ǽ����� CASE�� ����ϱ�
SELECT empno, ename, comm,
    CASE 
        WHEN comm IS NULL THEN '�ش���� ����'
        WHEN comm = 0 THEN '���� ����'
        WHEN comm > 0 THEN '���� : '|| comm
    END AS comm_text
FROM emp;
-- 6�� ��������
--1
SELECT empno, RPAD(SUBSTR(empno,1,2),4,'*') AS MASKING_EMPNO,
       ename, RPAD(SUBSTR(ename,1,1),LENGTH(ename),'*') AS MASKING_ENAME
FROM emp WHERE LENGTH(ename)>=5 AND LENGTH(ename)<6;
--2
SELECT empno, ename,sal,
    TRUNC(sal/21.5, 2) AS DAY_PAY,
    ROUND(sal/21.5/8,1) AS TIME_PAY
FROM emp;
--3
SELECT empno, ename, hiredate,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hiredate,3),'������'),'YYYY-MM-DD') AS R_JOB,
    NVL(TO_CHAR(comm),'N/A') AS comm
FROM emp;
--4
SELECT empno, ename, mgr, 
    CASE 
        WHEN mgr IS NULL THEN '0000'
        WHEN SUBSTR(mgr,1,2) = '75' THEN '5555'
        WHEN mgr LIKE '76%' THEN '6666'
        WHEN INSTR(mgr,'77')=1 THEN '7777'
        WHEN SUBSTR(mgr,1,2) = '78' THEN '8888'
        ELSE TO_CHAR(mgr)
    END AS CHG_MGR
FROM emp;























