--추가수당 '해당사항없음', '추가수당없음', '추가수당xx'
select ename, comm,
case
when comm is null then '해당사항없음'
when comm = 0 then '추가수당없음'
else concat('추가수당:',to_char(comm))
end as new_comm
from emp;

select ename, comm,
case 
when comm is null then '해당사항없음'
when comm = 0 then '추가수당없음'
when comm > 0 then '추가수당'||comm
end as new_comm
from emp;

--emp테이블과 dept테이블에서 공통으로 있는 부서번호 출력
select deptno
from dept
intersect
select deptno
from emp;

--select 절 하나 사용하기
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
order by d.deptno, e.empno;

select emp.empno, emp.ename, dept.deptno, dept.dname, dept.loc
from emp
join dept on emp.deptno = dept.deptno
order by dept.deptno, emp.empno;

--연도별, 부서별, 인원수
select to_char(hiredate,'YYYY') as hire_year, deptno, count(*) as cnt
from emp
group by grouping sets(to_char(hiredate, 'YYYY'), deptno);

--각 부서별, 직업별 인원수, 급여 총액, 그룹화된 부서 + 각 직업별, 전체 인원수, 급여 총액
select decode(grouping(deptno), 1, 'group_dept', deptno) as deptno,
       decode(grouping(job), 1, 'group_job', job) as job,
       count(*), sum(sal)
from emp
group by cube (deptno, job)
order by deptno, job;

--조인(join)
--두 개 이상의 테이블을 열 기준으로 결합해 주는 SQL 연산이다.
--일반적으로 공통된 열을 기준으로 작업을 한다.
--일치하지 않는 경우는 null을 반환한다.
--1. inner join : 두 테이블에서 일치하는 행만 반환(L ∩ R)
--inner join dept on dept.deptno = emp.deptno
--2. left outer join : 첫 번째 테이블의 모든 행 그리고 두 번째 테이블과 일치하는 행을 출력
--3. right outer join : 두 번째 테이블의 모든 행 그리고 첫 번째 테이블과 일치하는 행을 출력
--4. full outer join : 두 개의 모든 데이터를 가져와서 한쌍으로 만들고 전체 데이터 출력(L ∪ R)

select emp.ename, dept.dname
from emp
left outer join dept on emp.deptno = dept.deptno
order by dept.deptno, emp.empno;

--emp 테이블에서 자신의 상급자 이름을 더해서 출력
select e1.*, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

--emp 테이블 2개 합쳐보기, empno, ename 2번 나오게 하기
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

--L - L ∩ R
--from L
--left outer join r on l.value = r.value
--where r.value is null

--R - L ∩ R
--from R
--right outer join l on l.value = r.value
--where l.value is null

--L ∪ R - L ∩ R
--from L
--full outer join r on l.value = r.value
--where l.value is null or r.value is null

--5. cross join : 첫 번쨰 테이블과 두 번째 테이블의 모든 조합을 출력

--6. self-join : 자기 자신의 여러 row간 조인 연산을 수행 

select *
from emp e1
left outer join emp e2 on e1.mgr = e2.empno;

select *
from emp e1
right outer join emp e2 on e1.mgr = e2.empno;


--SQL-99 추가된 조인
--1. NATURAL JOIN : 두 개 이상의 동일한 이름을 가진 열들 사이에서 자동으로 일치하는 열들을 결합한다.
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

--select 절에서 조인 기준이 되는 column의 이름을 명시할 때 객체이름을 붙이면 안된다.

--2. USING 절 : 두 개 이상의 동일한 이름을 가진 열들 사이에서 자동으로 일치하는 열들을 결합한다.
select e.empno, e.ename, e.job, e.mgr, e.sal, e.comm, deptno, d.dname, d.loc
from emp e
join dept d using(deptno)
order by deptno, e.empno;

--3. ON 절 : 조건식들과 함께 결합할 열들을 직접 비교할 수 있다.

--salgrade - hisal을 받는 사람의 인원수를 등급별로 출력해보기
select s.grade, count(*)
from emp e, salgrade s
where e.sal = s.hisal
group by s.grade;

--emp테이블에서 dept테이블과 공통된 'deptno'값을 가지지 않은 부서 이름과 위치를 출력해보기
select d.deptno, d.dname, d.loc 
from emp e
right outer join dept d on e.deptno = d.deptno
where e.deptno is null;

--emp와 dept 결합해서 job이 manager인 사람 출력하기
select *
from emp
natural join dept
where job = 'MANAGER';

select *
from emp
join dept using(deptno)
where job = 'MANAGER';


-- 서브쿼리
--SQL 쿼리 내부에 포함된 쿼리로, 다른 쿼리의 일부로 사용되기 위한 쿼리다. 주로 select, from, where절에서 사용된다.
--복잡한 데이터 조작이나 필터링을 가능하게 해준다.
--중첩된 여러 개의 서브쿼리를 사용 가능하며 비효율적인 작성 방식을 피할 수 있어 쿼리를 최적화할 수 있다.
--대량 데이터나 복잡한 쿼리에서 성능 문제가 발생할 수 있다.
--1.단일행 서브쿼리(single-row subquery)||스칼라 서브쿼리(scalar subquery)
--  단일 행만을 반환하기 위한 서브쿼리(단일값 포함)
--  일반적으로 select, where에서 사용된다. 반환된 단일 값은 메인 쿼리에서 비교연산자에서 사용되거나 출력결과에 포함시킬 수 있다.
--  select절
--  select empno, ename, (select grade from salgrade where emp.sal between salgrade.losal and salgrade.hisal)as sal
--  from emp;
--  where절
--  select ename, hiredate
--  from emp
--  where hiredate >= (select max(hiredate) from emp);

--2.다중행 쿼리(multi-row subquery)
--  여러 개의 행을 반환하기 위한 서브쿼리
--  일반적으로 in, any, all, exists와 같은 연산자와 함께 사용된다. 또한, where절이나 from절에서 사용된다.
--  반환된 여러 행은 메인 쿼리의 조건과 비교해서 필터링하거나 결합시킬 수 있다.
--  1. in 연산자
--      메인 쿼리의 조건식에서 다중행 서브쿼리를 사용하여 특정 값이 포함되어 있는지 확인할 수 있다.
--  2. exists 연산자
--      메인 쿼리가 하위 집합 내에 결과가 있는지 확인하고 싶을 때 사용한다.
--  3. all, any 연산자
--      메인 쿼리의 열 값과 서브쿼리 결과 중 하나 이상 또는 모든 값을 비교한다.
--      where column > any(subquery) 

--비교연산자와 함께 사용하는 경우
--select ename, sal
--from emp e1
--where (e1.empno, e1.deptno) = (select e2.ename, e2.sal from emp e2 where e2.deptno = 123)

--그룹별 최고 급여 직원 출력
select *
from emp
where sal in (select max(sal) from emp group by deptno);

select *
from emp
where sal = any(select max(sal) from emp group by deptno);

--30번 부서 사원들의 최대 급여보다 작은 급여를 받는 사람들 출력하기
select *
from emp
where sal < (select max(sal) from emp where deptno = 30);

--3.인라인 뷰(inline view) from절에서 사용되는 서브쿼리 
--  1.임시로 테이블 형태의 결과 집합을 생성하는 방법
--      장점 : 복잡한 쿼리를 단순화, 유지보수성, 가독성
--      select column1, column2, ...
--      from(subquery) as alias

select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from(select * from emp where deptno = 10) e10, (select * from dept) d
where e10.deptno = d.deptno;

--  2.with절
--      CTE(Common Table Expression)로 명명된 임시 테이블 형태로 중복을 줄이는데 도움이된다.

with e10 as (select * from emp where deptno = 10), d as (select * from dept)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from e10, d
where e10.deptno = d.deptno;

--emp테이블에서 가장 높은 급여를 받는 직원의 이름과 급여를 출력
select ename, sal
from emp
where sal = (select max(sal) from emp);

--dept 테이블에서 각 부서별로 속한 직원의 수와 평균 급여를 출력
select d.deptno, d.dname, count(*), floor(avg(sal)) as avg_sal
from dept d
left outer join emp e on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

--emp테이블에서 각 직원의 이름과 급여를 조회하고, 해당 직원의 급여가 부서 평균보다 높은 경우에만 출력
select e1.ename, e1.sal, e1.deptno
from emp e1
where e1.sal >= (select avg(sal) from emp e2 where e1.deptno = e2.deptno group by e2.deptno)
order by e1.deptno;

select e1.ename, e1.sal, e1.deptno
from emp e1, (select avg(sal) as avg_sal, deptno from emp group by deptno) e2
where e1.sal > e2.avg_sal and e1.deptno = e2.deptno
order by e1.deptno;

--emp테이블에서 부서 번호가 10인 부서에 속한 직원들 중에서 급여가 3000 이상인 직원의 이름과 급여를 출력
select ename, sal, deptno
from emp
where /*sal >= (select sal from emp where */deptno = 10 and sal >= 3000/*)*/;

select deptno, count(*) as empcnt, max(sal) as maxsal
from emp
group by deptno
having max(deptno) = 10 and max(sal) > 3000;

select ename, sal
from (select * from emp where deptno = 10 and sal >= 3000);

--각 직원의 이름과 부서 이름을 출력. (부서 번호 대신 부서 이름)
select e.ename, d.dname
from emp e
left outer join dept d on e.deptno = d.deptno;

--각 직원의 이름과 해당 직원의 급여를 조회하되, 급여가 부서 평균 급여보다 높은 경우에는 "상위"라고 표시하고 그 외에는 "일반"이라고 출력
select ename, sal, deptno,
case
when sal >= (select avg(sal) from emp group by deptno) then '상위'
when sal < (select avg(sal) from emp group by deptno) then '일반'
end as sal_avg
from emp;

--각 부서별로 속한 직원의 수와 평균 급여를 조회하되, 급여가 해당 부서의 평균 급여보다 높은 직원의 이름과 급여를 함께 출력(평균 급여 내림차순으로 정렬)
select e.ename, e.sal, d.deptno, count(*), floor(avg(sal)) as avg_sal
from emp e

--각 직원의 이름과 보너스를 조회하되, 보너스가 없는 직원들 중에서 가장 급여가 높은 직원의 이름과 급여를 출력
select ename, sal
from emp
WHERE comm IS NULL
ORDER BY sal DESC;

