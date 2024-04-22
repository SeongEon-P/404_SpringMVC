-- 15-1 : SCOTT �������� ����� �����ϱ�
-- C##orclstudy : ����Ŭ 12c ���� ��������, ���� ������ id �տ� C##�� �ٿ��� ���� ������ ������.
-- ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; : ���� ��ũ��Ʈ�� ���� �����ϵ��� �ϴ� ����, ���� ���۽� �����ؾ���
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
--���� ������ ��� ������ �������� �����ؾ���
CREATE USER orclstudy
IDENTIFIED BY ORACLE;

-- ���� ���� ���� �ο��ϱ�(������ �������� �����ؾ���)
GRANT CREATE SESSION TO orclstudy;

-- ���� ��й�ȣ ����
ALTER USER orclstudy
IDENTIFIED BY ORCL;

-- ���� �����ϱ�
DROP USER orclstudy; -- ������ �����ϰ�, ������ �����ߴ� ��ü(��Ű��)�� ���ܵ�.
DROP USER orclstudy CASCADE; -- ������ �����ϰ�, ������ ������� ��� ��ü�� ������.

-- �ý��� ���� �����ϱ�(������ �������� ����)
-- 15-7 : SYSTEM �������� �����Ͽ� �����(orclstudy) �����ϱ�
CREATE USER orclstudy
IDENTIFIED BY ORACLE;

GRANT
    RESOURCE, CREATE SESSION, CREATE TABLE
    TO orclstudy;

-- ������ �Է��� �������̺� �����̽� �뷮 �����ϱ�
ALTER USER orclstudy
QUOTA 2M ON USERS; -- QUOTA 2M�� 2�ް�����Ʈ �뷮�� �ְڴٸ� ����.

-- ���̺� �����̽� ������ �뷮���� ����
ALTER USER orclstudy
QUOTA UNLIMITED ON USERS;

-- ��� ���̺� �����̽��� ������ �뷮 ����
GRANT UNLIMITED TABLESPACE TO orclstudy;
    
-- ���� ���
REVOKE
  CREATE TABLE
    FROM orclstudy;
    
REVOKE
 RESOURCE
    FROM orclstudy;
    
-- ��ü ����(SELECT, INSERT, UPDATE, DELETE ��) �ο��ϱ�
-- ��ü ���� �ο� �� ��Ҵ� ���� ��� cmdâ�� sqlplus�� �����
CREATE TABLE temp(
    col1 VARCHAR2(20),
    col2 VARCHAR2(20)
);

-- ��ü ������ ���, SCOTT �������� �����ؾ���. �ֳ��ϸ� SCOTT ������ temp ���̺��� ������� ����
GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON temp
TO orclstudy;

-- ��ü ���� ���,
REVOKE 
    SELECT, INSERT, UPDATE, DELETE
ON temp
FROM orclstudy;


-- CONNECT �� : CREATE SESSION ���Ѹ� ������ �ִ� ��
GRANT CONNECT TO orclstudy;

-- RESOURCE �� : CREATE VIEW, CREATE SYNONYM�� ������ ��κ��� ������ ����.
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO orclstudy;

-- �� ���� �� ����, ��� (������ �������� ���� �ؾ���)
-- 1. CREATE ROLE �� ����
CREATE ROLE rolestudy;

-- 2. ������ �ѿ� ���� �����ϱ�
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO rolestudy;

-- 3. ������ ������ ���� �������� �����ϱ�
GRANT rolestudy TO orclstudy;

-- 4. �� ����ϱ�
REVOKE rolestudy FROM orclstudy;

-- 5. �� �����ϱ� : ���� �����ϸ� ���� �ο��޾Ҵ� ��� ������ ���� ��ҵǰԵ�
DROP ROLE rolestudy;


-- 416p, 15�� ��������, Q1~3
-- Q1. ���� ���ǿ� �����ϴ� SQL���� �ۼ��� ������.
-- 1) SYSTEM �������� �����Ͽ� PREV_HW ������ ������ ������.
-- 2) ��й�ȣ�� ORCL�� �����մϴ�. ���� ������ �ο��ϰ� PREV_HW �������� ������ �ߵǴ��� Ȯ���� ������.
CREATE USER PREV_HW
IDENTIFIED BY ORCL;

GRANT CREATE SESSION TO PREV_HW; 
--GRANT CONNECT TO PREV_HW; �̰ɷ� �ص���.


-- Q2. SCOTT �������� �����Ͽ� ������ ������ PREV_HW ������ SCOTT ������ EMP, DEPT, SALGRADE ���̺� SELECT ������ �ο��ϴ� SQL���� �ۼ��غ�����.
--     ������ �ο������� PREV_HW �������� SCOTT�� EMP, DEPT, SALGRADE ���̺��� �� ��ȸ�Ǵ��� Ȯ���غ�����.
GRANT SELECT ON emp TO PREV_HW;
GRANT SELECT ON dept TO PREV_HW;
GRANT SELECT ON salgrade TO PREV_HW;

-- cmd���� PREV_HW�� Ȯ��.
SELECT * FROM SCOTT.EMP;
SELECT * FROM SCOTT.DEPT;
SELECT * FROM SCOTT.SALGRADE;

-- Q3. SCOTT �������� �����Ͽ� PREV_HW ������ SALGRADE ���̺��� SELECT ������ ����ϴ� SQL���� �ۼ��� ������. ������ ������ �Ϸ�Ǹ� ������ ����
--     PREV_HW �������� SALGRADE ���̺��� ��ȸ ���θ� Ȯ���غ��ô�.
REVOKE 
    SELECT ON salgrade
FROM PREV_HW;

-- cmd���� Ȯ��
SELECT * FROM SCOTT.SALGRADE;
    
-- �������� ���ڿ�(VARCHAR2()) : 10byte��ŭ �����ϸ� 10btye��ŭ�� �뷮�� �����ϴ� �ڷ���
-- varchar : varchar2�� ���� �ڷ��������� ������ ������ ����� ������ �ڷ���
-- CHAR(100) : �������� ���ڿ�. 10byte��ŭ �����ص�, ������ �ִ�뷮���� �����

    
    
    
    
    