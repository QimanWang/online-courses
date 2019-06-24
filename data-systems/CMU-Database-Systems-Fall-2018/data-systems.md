# CMU data systems fall 2018

## 1. History of SQL and Relational Algebra

Relational Algebras - sql is the high level of sigma algebra operators under the hood.
DB can figure out how to retrieve the data, query optimization.
Ted codd IBM system R, 1970's
Ibm bd2 1983 support sql
Oracle copy ibm
Ingress (quell) -> postgres
Structured query language
SQL has standards:
2016 : json, polymorphic tables.
1999 : regex, etc
SQL 92 is the min standard

DML - manipulate
DDL - definition
DCL - control

relational algebra.

## 2. SQL 

SQL is bag, not list or set
Count(*), count(1), count(col)
Mysql u can sent_mode "ansi" to be more strict


Mysql: insensitive, single/double
Concat: concat(), ||, +

Time stamp is hard to deal with in different flavors

SQLite is most used db, like phone / photoshop.

Window function: row_number(), rank()
Ex: Select … Fun() over() as a  from enrolled

Select *, row_number() over() as foo from table

// over ( partition by )
Select *, row_number() over( partition by foo ) as foo from table
Order by x

Select *, row_number() over(order by cid)

Highest grade for each course:
Select * from(
	Select *, rank() over (partition by cid order by grade asc) as rank from enrolled) as ranking
	Where ranking.rank = 1
We give each grade ranks, then select all rank = 1

Common table expressions: similar to nested, using with clause

With … cte as (
	Select …
)
Select * from cte;

With cte(c1,c2) as (
	Select 1,2
)
Select c1 + c2 from cte;


With ste(maxID) as (
	Select max(sid) from enrolled
)
Select name from student, ste
Where student.sid = ste.maxID;

// why? We can do recursion!
With recursive cte (counter) as (
	(select 1)
	Union all -- keeps duplicates
	(select counter + 1 from cte
		Where counter < 10)
)
Select * from cte;


-- set statement_timeout = '10s';
-- auto matically kills it.

Always try to compute answer in a single sql statement using cte.

Select * from(
	Select *, rank() over (partition by cid order by grade asc) as rank from enrolled) as ranking
	Where ranking.rank = 1
We give each grade ranks, then select all rank = 1

## Database storage

layers of DBMS:

**disk manager** moves data between memory and disk

CPU,CPU caches, DRAM are volatile: random access address
SSD, HDD, Network Storage are Non Volatile :sequential access block / pages 4kb

Non-volatile memory - random access and presistent like disk.

Goal: cache data in memeory as much as possible to avoid slow read/write access.

