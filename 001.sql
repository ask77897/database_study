select EMPNO, ENAME, job, mgr, hiredate, sal, comm, deptno
from emp;

select *
from emp;

select distinct emp.deptno, dept.loc
from emp, dept;

select distinct deptno
from emp;

select ename, deptno
from emp
order by ename;

select *
from emp
where sal>1000 and deptno=20;

select job, deptno, avg(sal)
from emp
group by job, deptno
order by job;

select job, deptno, avg(sal)
from emp
group by job, deptno
having avg(sal)<=3000
order by job;

select *
from emp
where deptno=20 or job='SALESMAN';

select *
from emp
where job!='MANAGER' and job!='SALESMAN' and job!='CLERK';

select *
from emp
where job like '%A%';

select *
from emp
where comm is null;

select *
from emp, dept
where dept.loc = 'NEW YORK' and emp.job = 'SALESMAN';