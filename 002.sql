select * from emp;

select ename
from emp
where (sal*12)+nvl(comm,0) >= 30000; /*or sal*12 >= 30000;*/

select sal*12+comm as total_salary
from emp;

--nvl(Null Value) -> nvl(값,대체값)
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

--사원 이름이 5글자 이상인 애들 출력
select ename
from emp
where length(ename)>=5;

--job을 3글자까지만 출력
select substr(job,1,3)
from emp;

--A가 들어간 직업 % 안쓰고 출력
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

--직원들 입사 40주년이 언젠지 출력
select ename, add_months(hiredate,480)
from emp;

--입사한지 42년 된 사람만 출력
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

--추가 수당 '해당 사항 없음, '해당 사항 있음'
select ename, nvl2(comm, '해당 사항 있음', '해당 사항 없음') as new_comm
from emp;

--MANAGER 급여 합계
select sum(sal) as MANAGER_SAL
from emp
where job = 'MANAGER';

--30번 부서 인원 수
select count(*)
from emp
where deptno = 30;

--제일 오래된 인원과 입사동기들(같은해 입사) 출력
select *
from emp
where extract(year from hiredate) = (select extract(year from min(hiredate)) from emp);

--같은 직업이 3명 이상인 job을 출력
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

--추가수당 '해당사항없음', '추가수당없음', '추가수당xx'
select ename, comm
case 
from emp
when comm = null then '해당사항없음'
when comm = 0 then '추가수당없음'
else '추가수당'+comm
end as new_comm, comm;

--emp테이블과 dept테이블에서 공통으로 있는 부서번호 출력
select *
from emp, dept
group by ( emp.deptno, dept.deptno);
--연도별, 부서별, 인원수
--각 부서별, 직업별 인원수, 급여 총액, 그룹화된 부서 + 각 직업별, 전체 인원수, 급여 총액   