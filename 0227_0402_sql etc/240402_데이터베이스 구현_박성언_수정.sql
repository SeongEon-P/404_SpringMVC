--[��] �����ͺ��̽� ���� ���� üũ����Ʈ
--1. scott ������ �н����带 �ؾ��� �� �н����带 �缳���ϴ� ����� console�� sqlplus�� �����ϴ� ������� �ۼ��϶�
CONNECT system as sysdba;
ALTER USER scott IDENTIFIED BY new_password;

--2. [SQL] ����Ŭ���� ���� ������ ������ �ִ� ��� ���̺��� �����ִ� ������ �ۼ��϶�
SELECT * FROM user_tables;

--3. guest02 ����ڸ� �߰��ϴ� ������ �ۼ��϶�.(�н�����: 1234)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER guest02
IDENTIFIED BY 1234;

--4. guest02 ����ڰ� �����ͺ��̽��� ����, ���ҽ� ���, ���� ����, �� ����, ���Ǿ� ������ �����ϵ��� ������ �����ϴ� ������ �ۼ��϶�.

GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE VIEW, CREATE SYNONYM TO guest02;

--5. guest02 ������� ���̺� �����̽� ���� ������ 2M���� �����϶�.
ALTER USER guest02
QUOTA 2M ON USERS;

--6. dept(�μ�) ���̺��� ������ ���� �����ϱ� ���� ������ �ۼ��϶�
--    deptno �������� ���� 6���� �����Ѵ�.
--    dname �������� ���� 6���� �����Ѵ�.  
 
CREATE TABLE dept (
  deptno VARCHAR(6),
  dname VARCHAR(6)
);

--7. dept(�μ�) ���̺� area �ʵ带 �������̹��� 10���� �����ϰ� Į���� �߰��Ѵ�.
ALTER TABLE dept ADD area VARCHAR2(10);

--8. dept(�μ�) ���̺��� dname�� ���ڿ� ���̸� 6���� 10���� �����϶�.
ALTER TABLE dept MODIFY dname VARCHAR2(10);

--9. dept(�μ�) ���̺� deptno �ʵ忡 �⺻Ű(primary key) ���������� �߰��϶�.
ALTER TABLE dept ADD PRIMARY KEY (deptno);

--10. dept ���̺� dname �ʵ忡 not null�� uniqe ���������� �����϶�.
ALTER TABLE dept
    MODIFY dname VARCHAR2(10) NOT NULL,
    ADD CONSTRAINT dname_unique UNIQUE (dname);



--11. emp(���) ���̺��� ������ ���� �ۼ��϶�
-- empno ���ڷ� �����ϰ� �⺻Ű�� �����϶�.
-- name �������� ���� 10�ڷ� �����ϰ� not null ���������� ����
-- deptno �������� ���� 6�ڷ� ����
-- position �������̹��� 10�ڷ� �����ϰ� ���� �����, �븮, ����, ���塱 ���� ���� �� �ֵ��� ����
-- pay�� ���ڷ� �����ϰ� not null ���� ������ �����϶�.
-- pempno�� ���ڷ� �����϶�.
CREATE TABLE emp (
  empno NUMBER PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  deptno VARCHAR(6),
  position VARCHAR(10) CONSTRAINT emp_position CHECK (position IN ('���', '�븮', '����', '����')),
  pay NUMBER NOT NULL,
  pempno NUMBER,
 );


--12. emp ���̺��� deptno �÷��� �ܷ�Ű ���� �������� dept ���̺��� deptno �÷��� �����ϵ��� �����϶�.
ALTER TABLE emp ADD CONSTRAINT fk_deptno_to_emp_table FOREIGN KEY (deptno) REFERENCES dept(deptno);

--13. �̸��� SEQ_EMP_SEQUENCE�̰� ���� �� 1001, ���� ��1�� �������� �����϶�.

CREATE SEQUENCE SEQ_EMP_SEQUENCE
    START WITH 1001
    INCREMENT BY 1;

--14. dept ���̺�� emp ���̺� �����͸� �׸��� ���� �Է��϶�. �� empno�� �������� �̿��Ͽ� �ڵ� �����ϵ��� �Է��Ѵ�.
INSERT INTO dept VALUES (101,'������');
INSERT INTO dept VALUES (102,'�ѹ���');
INSERT INTO dept VALUES (103,'��ȹ��');
INSERT INTO dept VALUES (104,'ȫ����');

INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, 'ȫ�浿', 101, '����', 450, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '�迬��', 102, '����', 400, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '������', 101, '����', 350, 1001);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '���±�', 103, '����', 410, null);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '������', 101, '�븮', 300, 1003);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '�����', 103, '�븮', 400, 1004);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '������', 102, '�븮', 320, 1002);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '�̼���', 102, '���', 380, 1007);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '������', 103, '���', 250, 1006);
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (SEQ_EMP_SEQUENCE.NEXTVAL, '������', 101, '���', 200, 1005);

--15. ������̺��� name���� �ε����� �����϶�.(�ε��� �̸� : IDX_EMP_NAME)
CREATE INDEX IDX_EMP_NAME ON emp(name);

--16. �μ��� ��� ���̺��� �����ȣ(empno), �̸�(name), �μ���(dname), �޿�(pay) �÷��� �����Ͽ� ��(VIEW)�� �ۼ��϶�.(�� �̸� : VW_EMP_TEST)
CREATE VIEW VW_EMP_TEST AS
SELECT e.empno, e.name, d.dname, e.pay
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

--17. guest03 ����ڸ� �����Ͽ�(��й�ȣ 4321) guest03���� guest02�� emp ���̺��� ��ȸ, �Է�, ����, �����ϴ� ������ �����϶�.
CREATE USER guest03
IDENTIFIED BY 4321;

GRANT SELECT, INSERT, UPDATE, DELETE ON guest02.emp TO guest03;

--18. guest03 ����ڿ��� �־��� ������ �����϶�.
REVOKE 
    SELECT, INSERT, UPDATE, DELETE ON guest02.emp
FROM guest03;


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
