select * from emp;

select ename
from emp
where (sal*12)+nvl(comm,0) >= 30000; /*or sal*12 >= 30000;*/

select sal*12+comm as total_salary
from emp;

--nvl(Null Value) -> nvl(��,��ü��)
select sal*12+nvl(comm,0) as total_salary
from emp;

desc emp;

desc dept;

select * from emp
where deptno=20 and sal >= 2000
union
select * from emp
where deptno=30 and sal >=2000;

select * from emp
where deptno=20 and sal >= 2000
union all
select * from emp
where deptno=20 and sal >=2000;

select * from emp
where deptno = 30
intersect
select * from emp
where job = 'SALESMAN';

select empno, ename, sal, detpno
from emp
minus
select empno, ename, sal, detpno
from emp
where deptno =10;

--��� �̸��� 5���� �̻��� �ֵ� ���
select ename
from emp
where length(ename)>=5;

--job�� 3���ڱ����� ���
select substr(job,1,3)
from emp;

--A�� �� ���� % �Ⱦ��� ���
select *
from emp
where instr(job, 'A', 1) !=0 ;

select concat('hello', 'world') from dual;

select length('hello') from dual;

select lower('HELLO') from dual;

select upper('hello') from dual;

select substr('hello, wolrd', 1 ,5) from dual;

select instr('hello, world', 'o', 1,2) from dual;

select replace('hello, world', 'world', 'WORLD') from dual;

select trim(both 'H' from 'HELLO WORLD HH') from dual;

select trim(leading 'O' from 'HELLO WORLD HH') from dual;

select sysdate from dual;

select extract(YEAR from hiredate) FROM emp;

select to_date('2020/01/01','YYYY/MM/DD') from dual;

select to_char(sysdate, 'YYYY/MM/DD') from dual;

--������ �Ի� 40�ֳ��� ������ ���
select ename, add_months(hiredate,480)
from emp;

--�Ի����� 42�� �� ����� ���
select *
from emp
where extract(year from hiredate) = 1981;

select *
from emp
where extract(year from hiredate) + 42 <=extract(year from sysdate);

select *
from emp
where floor(months_between(sysdate, hiredate)) >=42*12;

select *
from emp
where to_char(sysdate,"YYYY") = to_char(add_month(hiredate,480) ,'YYYY');

select coalesce(null, 'apple', 'banana', 'orange') from dual;

select coalesce(null, null, null, null) from dual;

select coalesce(null, null, 'apple', null) from dual;

select empno, ename, job, sal, decode(job, 'MANAGER', sal*1.1, 'SALESMAN', sal*1.05, 'ANALYST', sal*1.3, sal) as NEW_SAL
from emp;

--�߰� ���� '�ش� ���� ����, '�ش� ���� ����'
select ename, nvl2(comm, '�ش� ���� ����', '�ش� ���� ����') as new_comm
from emp;

--MANAGER �޿� �հ�
select sum(sal) as MANAGER_SAL
from emp
where job = 'MANAGER';

--30�� �μ� �ο� ��
select count(*)
from emp
where deptno = 30;

--���� ������ �ο��� �Ի絿���(������ �Ի�) ���
select *
from emp
where extract(year from hiredate) = (select extract(year from min(hiredate)) from emp);

--���� ������ 3�� �̻��� job�� ���
select job, count(*)
from emp
group by job
having count(*) >= 3;

select deptno, job, sum(sal)
from emp
group by rollup(deptno, job);

select deptno, job, sum(sal)
from emp
group by cube(deptno, job);

select deptno, job, sum(sal)
from emp
group by grouping sets((deptno, job),(deptno),(job),());

select deptno, job, sum(sal), grouping(deptno), grouping(job)
from emp
group by cube(deptno, job);

--�߰����� '�ش���׾���', '�߰��������', '�߰�����xx'
select ename, comm
case 
from emp
when comm = null then '�ش���׾���'
when comm = 0 then '�߰��������'
else '�߰�����'+comm
end as new_comm, comm;

--emp���̺�� dept���̺��� �������� �ִ� �μ���ȣ ���
select *
from emp, dept
group by ( emp.deptno, dept.deptno);
--������, �μ���, �ο���
--�� �μ���, ������ �ο���, �޿� �Ѿ�, �׷�ȭ�� �μ� + �� ������, ��ü �ο���, �޿� �Ѿ�   