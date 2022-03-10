create table dept(
dname string,
loc string,
deptno int
)
row format delimited
fields terminated by ',';

create table emp(
empno int,
ename string,
job string,
mgr int,
hiredate string,
sal int,
comm int,
deptno int
)
row format delimited
fields terminated by ',';

create table salgrade(
grade int,
losal int,
hisal int
)
row format delimited
fields terminated by ',';
