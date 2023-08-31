--�߰����� '�ش���׾���', '�߰��������', '�߰�����xx'
select ename, comm,
case
when comm is null then '�ش���׾���'
when comm = 0 then '�߰��������'
else concat('�߰�����:',to_char(comm))
end as new_comm
from emp;

select ename, comm,
case 
when comm is null then '�ش���׾���'
when comm = 0 then '�߰��������'
when comm > 0 then '�߰�����'||comm
end as new_comm
from emp;

--emp���̺�� dept���̺��� �������� �ִ� �μ���ȣ ���
select deptno
from dept
intersect
select deptno
from emp;

--select �� �ϳ� ����ϱ�
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
order by d.deptno, e.empno;

select emp.empno, emp.ename, dept.deptno, dept.dname, dept.loc
from emp
join dept on emp.deptno = dept.deptno
order by dept.deptno, emp.empno;

--������, �μ���, �ο���
select to_char(hiredate,'YYYY') as hire_year, deptno, count(*) as cnt
from emp
group by grouping sets(to_char(hiredate, 'YYYY'), deptno);

--�� �μ���, ������ �ο���, �޿� �Ѿ�, �׷�ȭ�� �μ� + �� ������, ��ü �ο���, �޿� �Ѿ�
select decode(grouping(deptno), 1, 'group_dept', deptno) as deptno,
       decode(grouping(job), 1, 'group_job', job) as job,
       count(*), sum(sal)
from emp
group by cube (deptno, job)
order by deptno, job;

--����(join)
--�� �� �̻��� ���̺��� �� �������� ������ �ִ� SQL �����̴�.
--�Ϲ������� ����� ���� �������� �۾��� �Ѵ�.
--��ġ���� �ʴ� ���� null�� ��ȯ�Ѵ�.
--1. inner join : �� ���̺��� ��ġ�ϴ� �ุ ��ȯ(L �� R)
--inner join dept on dept.deptno = emp.deptno
--2. left outer join : ù ��° ���̺��� ��� �� �׸��� �� ��° ���̺�� ��ġ�ϴ� ���� ���
--3. right outer join : �� ��° ���̺��� ��� �� �׸��� ù ��° ���̺�� ��ġ�ϴ� ���� ���
--4. full outer join : �� ���� ��� �����͸� �����ͼ� �ѽ����� ����� ��ü ������ ���(L �� R)

select emp.ename, dept.dname
from emp
left outer join dept on emp.deptno = dept.deptno
order by dept.deptno, emp.empno;

--emp ���̺��� �ڽ��� ����� �̸��� ���ؼ� ���
select e1.*, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

--emp ���̺� 2�� ���ĺ���, empno, ename 2�� ������ �ϱ�
select *
from emp e1, emp e2;

select e1.*, e2.EMPNO, e2.ename
from emp e1
join emp e2 on e1.empno = e2.empno;


select *
from emp, salgrade
where salgrade.losal <= emp.sal and emp.sal <= salgrade.hisal;

select *
from emp, salgrade
where emp.sal between salgrade.losal and salgrade.hisal;

--L - L �� R
--from L
--left outer join r on l.value = r.value
--where r.value is null

--R - L �� R
--from R
--right outer join l on l.value = r.value
--where l.value is null

--L �� R - L �� R
--from L
--full outer join r on l.value = r.value
--where l.value is null or r.value is null

--5. cross join : ù ���� ���̺�� �� ��° ���̺��� ��� ������ ���

--6. self-join : �ڱ� �ڽ��� ���� row�� ���� ������ ���� 

select *
from emp e1
left outer join emp e2 on e1.mgr = e2.empno;

select *
from emp e1
right outer join emp e2 on e1.mgr = e2.empno;


--SQL-99 �߰��� ����
--1. NATURAL JOIN : �� �� �̻��� ������ �̸��� ���� ���� ���̿��� �ڵ����� ��ġ�ϴ� ������ �����Ѵ�.
--select *
--from emp
--natural join salgrade;
select *
from emp e1
natural join emp e2;

select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, deptno, d.dname, d.loc
from emp e
natural join dept d
order by deptno, e.empno;

--select ������ ���� ������ �Ǵ� column�� �̸��� ����� �� ��ü�̸��� ���̸� �ȵȴ�.

--2. USING �� : �� �� �̻��� ������ �̸��� ���� ���� ���̿��� �ڵ����� ��ġ�ϴ� ������ �����Ѵ�.
select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, deptno, d.dname, d.loc
from emp e
join dept d using(deptno)
order by deptno, e.empno;

--3. ON �� : ���ǽĵ�� �Բ� ������ ������ ���� ���� �� �ִ�.

--salgrade - hisal�� �޴� ����� �ο����� ��޺��� ����غ���
select s.grade, count(*)
from emp e, salgrade s
where e.sal = s.hisal
group by s.grade;

--emp���̺��� dept���̺�� ����� 'deptno'���� ������ ���� �μ� �̸��� ��ġ�� ����غ���
select d.deptno, d.dname, d.loc 
from emp e
right outer join dept d on e.deptno = d.deptno
where e.deptno is null;

--emp�� dept �����ؼ� job�� manager�� ��� ����ϱ�
select *
from emp
natural join dept
where job = 'MANAGER';

select *
from emp
join dept using(deptno)
where job = 'MANAGER';


-- ��������
--SQL ���� ���ο� ���Ե� ������, �ٸ� ������ �Ϻη� ���Ǳ� ���� ������. �ַ� select, from, where������ ���ȴ�.
--������ ������ �����̳� ���͸��� �����ϰ� ���ش�.
--��ø�� ���� ���� ���������� ��� �����ϸ� ��ȿ������ �ۼ� ����� ���� �� �־� ������ ����ȭ�� �� �ִ�.
--�뷮 �����ͳ� ������ �������� ���� ������ �߻��� �� �ִ�.
--1.������ ��������(single-row subquery)||��Į�� ��������(scalar subquery)
--  ���� �ุ�� ��ȯ�ϱ� ���� ��������(���ϰ� ����)
--  �Ϲ������� select, where���� ���ȴ�. ��ȯ�� ���� ���� ���� �������� �񱳿����ڿ��� ���ǰų� ��°���� ���Խ�ų �� �ִ�.
--  select��
--  select empno, ename, (select grade from salgrade where emp.sal between salgrade.losal and salgrade.hisal)as sal
--  from emp;
--  where��
--  select ename, hiredate
--  from emp
--  where hiredate >= (select max(hiredate) from emp);

--2.������ ����(multi-row subquery)
--  ���� ���� ���� ��ȯ�ϱ� ���� ��������
--  �Ϲ������� in, any, all, exists�� ���� �����ڿ� �Բ� ���ȴ�. ����, where���̳� from������ ���ȴ�.
--  ��ȯ�� ���� ���� ���� ������ ���ǰ� ���ؼ� ���͸��ϰų� ���ս�ų �� �ִ�.
--  1. in ������
--      ���� ������ ���ǽĿ��� ������ ���������� ����Ͽ� Ư�� ���� ���ԵǾ� �ִ��� Ȯ���� �� �ִ�.
--  2. exists ������
--      ���� ������ ���� ���� ���� ����� �ִ��� Ȯ���ϰ� ���� �� ����Ѵ�.
--  3. all, any ������
--      ���� ������ �� ���� �������� ��� �� �ϳ� �̻� �Ǵ� ��� ���� ���Ѵ�.
--      where column > any(subquery) 

--�񱳿����ڿ� �Բ� ����ϴ� ���
--select ename, sal
--from emp e1
--where (e1.empno, e1.deptno) = (select e2.ename, e2.sal from emp e2 where e2.deptno = 123)

--�׷캰 �ְ� �޿� ���� ���
select *
from emp
where sal in (select max(sal) from emp group by deptno);

select *
from emp
where sal = any(select max(sal) from emp group by deptno);

--30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ����� ����ϱ�
select *
from emp
where sal < (select max(sal) from emp where deptno = 30);

--3.�ζ��� ��(inline view) from������ ���Ǵ� �������� 
--  1.�ӽ÷� ���̺� ������ ��� ������ �����ϴ� ���
--      ���� : ������ ������ �ܼ�ȭ, ����������, ������
--      select column1, column2, ...
--      from(subquery) as alias

select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from(select * from emp where deptno = 10) e10, (select * from dept) d
where e10.deptno = d.deptno;

--  2.with��
--      CTE(Common Table Expression)�� ���� �ӽ� ���̺� ���·� �ߺ��� ���̴µ� �����̵ȴ�.

with e10 as (select * from emp where deptno = 10), d as (select * from dept)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from e10, d
where e10.deptno = d.deptno;

--emp���̺��� ���� ���� �޿��� �޴� ������ �̸��� �޿��� ���
select ename, sal
from emp
where sal = (select max(sal) from emp);

--dept ���̺��� �� �μ����� ���� ������ ���� ��� �޿��� ���
select d.deptno, d.dname, count(*), floor(avg(sal)) as avg_sal
from dept d
left outer join emp e on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

--emp���̺��� �� ������ �̸��� �޿��� ��ȸ�ϰ�, �ش� ������ �޿��� �μ� ��պ��� ���� ��쿡�� ���
select e1.ename, e1.sal, e1.deptno
from emp e1
where e1.sal >= (select avg(sal) from emp e2 where e1.deptno = e2.deptno group by e2.deptno)
order by e1.deptno;

select e1.ename, e1.sal, e1.deptno
from emp e1, (select avg(sal) as avg_sal, deptno from emp group by deptno) e2
where e1.sal > e2.avg_sal and e1.deptno = e2.deptno
order by e1.deptno;

--emp���̺��� �μ� ��ȣ�� 10�� �μ��� ���� ������ �߿��� �޿��� 3000 �̻��� ������ �̸��� �޿��� ���
select ename, sal, deptno
from emp
where /*sal >= (select sal from emp where */deptno = 10 and sal >= 3000/*)*/;

select deptno, count(*) as empcnt, max(sal) as maxsal
from emp
group by deptno
having max(deptno) = 10 and max(sal) > 3000;

select ename, sal
from (select * from emp where deptno = 10 and sal >= 3000);

--�� ������ �̸��� �μ� �̸��� ���. (�μ� ��ȣ ��� �μ� �̸�)
select e.ename, d.dname
from emp e
left outer join dept d on e.deptno = d.deptno;

--�� ������ �̸��� �ش� ������ �޿��� ��ȸ�ϵ�, �޿��� �μ� ��� �޿����� ���� ��쿡�� "����"��� ǥ���ϰ� �� �ܿ��� "�Ϲ�"�̶�� ���
select ename, sal, deptno,
case
when sal >= (select avg(sal) from emp group by deptno) then '����'
when sal < (select avg(sal) from emp group by deptno) then '�Ϲ�'
end as sal_avg
from emp;

--�� �μ����� ���� ������ ���� ��� �޿��� ��ȸ�ϵ�, �޿��� �ش� �μ��� ��� �޿����� ���� ������ �̸��� �޿��� �Բ� ���(��� �޿� ������������ ����)
select e.ename, e.sal, d.deptno, count(*), floor(avg(sal)) as avg_sal
from emp e

--�� ������ �̸��� ���ʽ��� ��ȸ�ϵ�, ���ʽ��� ���� ������ �߿��� ���� �޿��� ���� ������ �̸��� �޿��� ���
select ename, sal
from emp
WHERE comm IS NULL
ORDER BY sal DESC;

