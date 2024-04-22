-- 17-1 : ���ڵ� �����ؼ� ����ϱ�
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : �����̸�, REC_DEPT :�ڷ���
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABSE';
        dept_rec.loc := 'SEOUL';
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
        END;
        /
        
-- 17-2 : DEPT_RECORD ���̺� �����ϱ�
CREATE TABLE dept_record
AS SELECT * FROM dept;

SELECT*FROM dept_record;

-- record �̿��ؼ� INSERT �ϱ�
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : �����̸�, REC_DEPT :�ڷ���
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABSE';
        dept_rec.loc := 'SEOUL';
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
        INSERT INTO dept_record
        VALUES dept_rec;
        END;
        /
        
SELECT*FROM dept_record;        

-- 17-4 : record �̿��� UPDATE
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : �����̸�, REC_DEPT :�ڷ���
    BEGIN
        dept_rec.deptno := 50;
        dept_rec.dname := 'DB';
        dept_rec.loc := 'SEOUL';
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
        
        UPDATE dept_record
        SET ROW = dept_rec
        WHERE deptno = 99;
END;
/
SELECT*FROM dept_record;  

-- 17-5 : record�� �ٸ� record �����ϱ�
DECLARE
    TYPE rec_dept IS RECORD(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE   
    );
     TYPE rec_emp IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        dinfo REC_DEPT  
    );
        emp_rec REC_EMP;
BEGIN
     SELECT E.empno, E.ename, D.deptno, D.dname, D.loc
        INTO emp_rec.empno, emp_rec.ename,
        emp_rec.dinfo.deptno,
        emp_rec.dinfo.dname,
        emp_rec.dinfo.loc
    FROM emp E INNER JOIN dept D ON E.deptno = D.deptno
    
    WHERE E.empno = 7788;
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' ||  emp_rec.empno);
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
       
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' ||  emp_rec.dinfo.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' ||  emp_rec.dinfo.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' ||  emp_rec.dinfo.loc);
    END;
    /
    

-- 17-6 : ���� �迭 ����ϱ�
DECLARE
    TYPE itab_ex_IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER; --�����ϴ� �κ�, index���� � ������ ������ ������� ���ϴ°���. integer�� ������ ����.
    
    text_arr itab_ex; --�����ϴ� �κ�
    
BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2nd data';
    text_arr(3) := '3rd data';
    text_arr(4) := '4th data';
    
    DBMS_OUTPUT.PUT_LINE('text_arr(1) : ' || text_arr(1));
    DBMS_OUTPUT.PUT_LINE('text_arr(2) : ' || text_arr(2));
    DBMS_OUTPUT.PUT_LINE('text_arr(3) : ' || text_arr(3));
    DBMS_OUTPUT.PUT_LINE('text_arr(4) : ' || text_arr(4));
    
    END;
    /
    
    

-- 17-7 : ���� �迭 �ڷ����� ���ڵ� ����ϱ�
DECLARE
    TYPE rec_dept IS RECORD(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        
    TYPE ITAB_DEPT IS TABLE OF rec_dept INDEX BY PLS_INTEGER; 
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER := 0;  
BEGIN
    FOR i IN (SELECT deptno, dname FROM dept) LOOP
        idx := idx+1;
        dept_arr(idx).deptno := i.deptno;
        dept_arr(idx).dname := i.dname;
        DBMS_OUTPUT.PUT_LINE(dept_arr(idx).deptno || ':' || dept_arr(idx).dname);
    END LOOP;
END;
/

-- : ROW TYPE �迭 �ڷ����� ���ڵ� ����ϱ�
DECLARE
    TYPE ITAB_DEPT IS TABLE OF dept%ROWTYPE INDEX BY PLS_INTEGER;
    
    dept_arr ITAB_DEPT; --�����ϴ� �κ�
    idx PLS_INTEGER :=0 ;
    
    
BEGIN
    FOR i IN (SELECT * FROM dept) LOOP
        idx := idx+1;
        dept_arr(idx).deptno := i.deptno;
        dept_arr(idx).dname := i.dname;
        dept_arr(idx).loc := i.loc;
 
        DBMS_OUTPUT.PUT_LINE(
        dept_arr(idx).deptno || ':' || 
        dept_arr(idx).dname || ':' ||
        dept_arr(idx).loc
        );
    END LOOP;
END;
/

-- 457~458p, 17�� �������� Q1~2
-- Q1. ������ ���� ����� �������� PL/SQL���� �ۼ��غ�����.
--1) EMP ���̺�� ���� �� ������ ������ �� ���̺� EMP_RECORD�� �����ϴ� SQL���� �ۼ��غ�����.
--2) EMP_RECORD ���̺� ���ڵ带 ����Ͽ� ���ο� ��� ������ ������ ���� �����ϴ� PL/SQL ���α׷��� �ۼ��غ�����.
CREATE TABLE emp_record
AS SELECT * FROM emp WHERE 1<>1;
SELECT * FROM emp_record;

DECLARE
    TYPE rec_emp IS RECORD (
        empno emp.EMPNO%TYPE,
        ename emp.ENAME%TYPE,
        job emp.JOB%TYPE,
        mgr emp.MGR%TYPE,
        hiredate emp.HIREDATE%TYPE,
        sal emp.SAL%TYPE,
        comm emp.COMM%TYPE,
        deptno emp.DEPTNO%TYPE
    );
    
    empdata rec_emp;
BEGIN
    empdata.empno := 1111;
    empdata.ename := 'TEST_USER';
    empdata.job := 'TEST_JOB';
    empdata.mgr := NULL;
    empdata.hiredate := '2018/03/01';
    empdata.sal := 3000;
    empdata.comm := NULL;
    empdata.deptno := 40;
    
    INSERT INTO EMP_RECORD
    VALUES empdata;
    
    COMMIT;
END;
/
SELECT * FROM emp_record;


-- Q2. EMP ���̺��� �����ϴ� ��� ���� ������ �� �ִ� ���ڵ带 Ȱ���Ͽ� ���� �迭�� �ۼ��� ������.
-- �׸��� ����� ���� �迭�� ������ ������ ���� ����� ������.
    
DECLARE
    TYPE ITAB_EMP IS TABLE OF emp%ROWTYPE INDEX BY PLS_INTEGER;
    empdata ITAB_EMP;
    idx PLS_INTEGER := 0;
    
BEGIN
    FOR i IN (SELECT * FROM emp) LOOP
        idx := idx+1;
        empdata(idx).empno := i.empno;
        empdata(idx).ename := i.ename;
        empdata(idx).job := i.job;
        empdata(idx).mgr := i.mgr;
        empdata(idx).hiredate := i.hiredate;
        empdata(idx).sal := i.sal;
        empdata(idx).comm := i.comm;
        empdata(idx).deptno := i.deptno;
        
        DBMS_OUTPUT.PUT_LINE(
        empdata(idx).empno || ' : ' ||
        empdata(idx).ename || ' : ' ||
        empdata(idx).job || ' : ' ||
        empdata(idx).mgr || ' : ' ||
        empdata(idx).hiredate || ' : ' ||
        empdata(idx).sal || ' : ' ||
        empdata(idx).comm || ' : ' ||
        empdata(idx).deptno
        
        );
    
    END LOOP;
END;
/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        
        
        
        