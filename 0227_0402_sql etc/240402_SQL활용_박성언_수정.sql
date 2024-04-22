--1. �Ʒ��� ���� �°� emp���̺� �����͸� �߰��϶�.
 -- �����ȣ:1011, �̸�:�̼���, �μ���ȣ:104, ��å:����, �޿�:500, ���ӻ��:NULL
INSERT INTO emp (empno, name, deptno, position, pay, pempno) VALUES (1011, '�̼���', 104, '����', 500, null);

--2. dept ���̺� area �ʵ��� ���� �����δ� ����, �������� �λ����� ���� ������Ʈ�϶�.
UPDATE dept SET area = CASE WHEN deptno = 101 THEN '����' ELSE '�λ�' END;

--3. emp ���̺��� �μ� �̸��� ȫ������ �����͸� �����϶�. 
DELETE FROM emp
WHERE deptno IN (SELECT deptno FROM dept WHERE dname = 'ȫ����');

--4. emp ���̺��� ����Ͽ� �̸�,  �޿�, ������ ����϶�. �� ������ �޿��� 0-200�̸� �޿��� 5%, 201-300�̸� �޿��� 10%, 301-400 �̸� �޿��� 15%, �������� �޿��� 20%�� �����Ѵ�.(case�� ���)
-- CASE ���ǹ�
SELECT name, pay,
    CASE
    WHEN pay <= 200 THEN pay * 0.05
    WHEN pay <= 300 THEN pay * 0.1
    WHEN pay <= 400 THEN pay * 0.15
    ELSE pay * 0.20
    END AS tax;
FROM emp;

--5. ������ ������ �ѹ��� ������ �̸�, �μ���, ������ �̸������� ������������ ����϶�.
SELECT E.name, D.dname, E.postion
FROM emp E
JOIN dept D ON E.deptno = D.deptno
WHERE d.dname IN ('������', '�ѹ���')
ORDER BY e.name ASC;

--6. emp ���̺��� �̿��Ͽ� ����� �̸��� ���ӻ���� �̸��� ����϶�. �� ���ӻ���� ���� ��� null�� ǥ�õǵ��� �϶�.
SELECT e.name AS Employee, m.name AS Manager
FROM emp e
LEFT JOIN emp m ON e.pempno = m.empno;

--7. �μ��� �޿��� ����� 350 �̻��� �μ��� �μ���, �޿��� ����� ���϶�.
SELECT D.dname, AVG(E.pay) AS avg_pay
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
GROUP BY D.dname
HAVING AVG(E.pay) > 350;

--8. emp ���̺��� �� �μ��� �޿��� ���� ���� ����� �̸�, �μ���, �޿��� ����϶�(sub query).
SELECT E.name, D.dname, E.pay
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
WHERE E.pay = (SELECT MAX(pay) FROM emp WHERE deptno = D.deptno);
    
--9. emp ���̺��� �̼��Կ� ���� �μ��� ������ �̸��� �μ����� ����϶�.(sub query)
SELECT E.name, D.dname
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno 
WHERE E.name = '�̼���';


--10. ������ �ּұ޿����� ���� �޿��� �޴� ����� �̸�, ����, �޿��� ����϶�.(sub query)
SELECT E.name, E.position, D.dname
FROM dept D INNER JOIN emp E ON D.deptno = E.deptno
WHERE E.pay >= (SELECT MIN(pay) FROM emp WHERE position = '����');




CREATE TABLE ��ǰ (
  ��ǰ�ڵ� VARCHAR(4) PRIMARY KEY,
  ��ǰ�� VARCHAR(10),
  ����Ŀ�� VARCHAR(10),
  ���� INT,
  ��ǰ�з� VARCHAR(12)
 );
 
 
 INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ����Ŀ��, ����, ��ǰ�з�) VALUES (0001, '��ǰ1', '����Ŀ1', 100, '�ķ�ǰ');
 INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ����Ŀ��, ����, ��ǰ�з�) VALUES (0002, '��ǰ2', '����Ŀ2', 200, '�ķ�ǰ');
 INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ����Ŀ��, ����, ��ǰ�з�) VALUES (0003, '��ǰ3', '����Ŀ3', 1980, '��Ȱ��ǰ');
 

CREATE TABLE ���� (
  ��ǰ�ڵ� VARCHAR(4) CONSTRAINT fk_��ǰ_to_���� REFERENCES ��ǰ(��ǰ�ڵ�),
  �԰�¥ DATE,
  ���� INT
 );
 
 INSERT INTO ���� (��ǰ�ڵ�, �԰�¥, ����) VALUES (0001, '2019-01-03', 200);
 INSERT INTO ���� (��ǰ�ڵ�, �԰�¥, ����) VALUES (0002, '2019-02-10', 500);
 INSERT INTO ���� (��ǰ�ڵ�, �԰�¥, ����) VALUES (0003, '2019-02-14', 10);

SELECT S.��ǰ��, J.����
FROM ��ǰ S
JOIN ���� J ON S.��ǰ�ڵ� = J.��ǰ�ڵ�
WHERE ��ǰ�з� = '�ķ�ǰ';

SELECT * FROM ��ǰ;
SELECT * FROM ����;







