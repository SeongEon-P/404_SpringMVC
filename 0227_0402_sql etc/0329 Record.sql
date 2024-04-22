-- 17-1 : 레코드 정의해서 사용하기
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : 변수이름, REC_DEPT :자료형
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABSE';
        dept_rec.loc := 'SEOUL';
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
        END;
        /
        
-- 17-2 : DEPT_RECORD 테이블 생성하기
CREATE TABLE dept_record
AS SELECT * FROM dept;

SELECT*FROM dept_record;

-- record 이용해서 INSERT 하기
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : 변수이름, REC_DEPT :자료형
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

-- 17-4 : record 이용한 UPDATE
DECLARE
    TYPE rec_dept IS record(
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
        );
        dept_rec REC_DEPT; --dept_rec : 변수이름, REC_DEPT :자료형
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

-- 17-5 : record에 다른 record 포함하기
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
    

-- 17-6 : 연관 배열 사용하기
DECLARE
    TYPE itab_ex_IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER; --정의하는 부분, index에서 어떤 데이터 유형을 사용할지 말하는거임. integer은 정수를 말함.
    
    text_arr itab_ex; --선언하는 부분
    
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
    
    

-- 17-7 : 연관 배열 자료형에 레코드 사용하기
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

-- : ROW TYPE 배열 자료형에 레코드 사용하기
DECLARE
    TYPE ITAB_DEPT IS TABLE OF dept%ROWTYPE INDEX BY PLS_INTEGER;
    
    dept_arr ITAB_DEPT; --선언하는 부분
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

-- 457~458p, 17장 연습문제 Q1~2
-- Q1. 다음과 같은 결과가 나오도록 PL/SQL문을 작성해보세요.
--1) EMP 테이블과 같은 열 구조를 가지는 빈 테이블 EMP_RECORD를 생성하는 SQL문을 작성해보세요.
--2) EMP_RECORD 테이블에 레코드를 사용하여 새로운 사원 정보를 다음과 같이 삽입하는 PL/SQL 프로그램을 작성해보세요.
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


-- Q2. EMP 테이블을 구성하는 모든 열을 저장할 수 있는 레코드를 활용하여 연관 배열을 작성해 보세요.
-- 그리고 저장된 연관 배열의 내용을 다음과 같이 출력해 보세요.
    
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

        
        
        
        