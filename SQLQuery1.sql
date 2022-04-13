create database mars_new;

use mars_new;

create table product(prod_id varchar(6) primary key, 
					prod_name varchar(10) not null, 
					prod_desc varchar(20), 
					price numeric(8,2) not null);

drop table product;

alter table product
add primary key(prod_id);

alter table product
alter column prod_id varchar(6) not null;

insert into product values('EL102', 'LAPTOP', 450, 'DELL');

insert into product (prod_id, prod_name, price, prod_desc)
values ('EL102', 'LAPTOP', 450, 'DELL');

insert into product (prod_id, prod_name, price, prod_desc)
values ('EL106', 'DESKTOP', 350, 'LG'), ('EL107', 'MOUSE', 150, 'LOGITECH');

insert into product (prod_id, prod_name, price, prod_desc)
values ('EL108', 'KEYBOARD', 350, 'HP');

insert into product (prod_id, prod_name, price, prod_desc)
values ('EL112', 'HEADPHONE', 275, 'HP');



select * from product;

select * from product where prod_name like 'LAP%';

select * from product where prod_name like '%TOP%';

select * from product where prod_desc like '%SUN%';

select * from product where prod_desc like '%SUN';

select * from product where price in (450,50,150);

select * from product where price between 50 and 400;

select * from product where price between 50 and 400 and prod_name like 'M%';

select prod_name,price from product where price between 50 and 400 and prod_name like 'M%';

update product set price = 75 where prod_id = 'EL105';

update product set price = price * 1.1 where prod_name = 'LAPTOP';

update product set price = 75 where prod_id = 'EL107';

delete from product where prod_id = 'EL108';


begin tran t
delete from product where prod_id = 'EL107';
rollback tran t;



begin tran t
delete from product where prod_id = 'EL107';
commit tran t;	-- to commit transaction
rollback tran t; -- to rollback transaction

--Aggregate function (COUNT, SUM, AVG, MIN, MAX)

select count(*) as 'No. of rows' from product where price >300;

select SUM(price) as 'total' from product where price_name like 'LAP%';

select count(*),SUM(price) as 'total' from product where price_name like 'LAP%' and price > 300;

select prod_name, max(price) as 'MAX_PRICE' from product group by prod_name;

select * from product order by price desc; --to order

select prod_name, max(price) as 'MAX_PRICE' from product group by prod_name
having prod_name like 'MOB%';

select prod_name, count(*) from product group by prod_name;

select prod_name, count(*) as 'COUNT' from product group by prod_name order by count(*);

--Subquery
select * from product where prod_id in(select prod_id from product where prod_name = 'LAPTOP')
select * from product where prod_id = (select prod_id from product where prod_name = 'LAPTOP') --it will be error bcoz '= symbol' wont allow to have multiple values

--select the product name which is having highest price
select * from product where price in(select MAX(price)from product);

--select the product name which is having second highest price
select MAX(price) from product where price not in(select MAX(price)from product);

-- Minimum price
select * from product where price in(select MIN(price)from product);

-- In build function in SQL Server for length
select LEN('MARS IT') as 'string length';

-- In build function in SQL Server for concate
select CONCAT('MARS ','RETURNSHIP') as 'program name';

select substring('MARS RETURNSHIP', 1,4) as 'exact string';
select substring('MARS RETURNSHIP', 5,15) as 'exact string'; --includes blank space
select substring('MARS RETURNSHIP', 6,15) as 'exact string';	--starts with R

--Absolute Function
select abs(-143.87) as 'absolute value';	--takes the negative value

--Numeric Functions
select ceiling(42.15) as 'ceil';	--it will round the decimal value here it will give 43

select floor(42.15) as 'floor';

select round(112.364,1) as 'round val';

select sqrt(625) as 'square root';

--Day 3 Sql Training
use mars_new;

select * from product;

create table orders(ord_id varchar(6) primary key, 
					ord_date date not null, 
					ord_desc varchar(10),
					prod_id varchar(6) references product(prod_id));


create table order1(ord_id varchar(6) primary key, 
					ord_date date not null, 
					ord_desc varchar(10),
					prod_id varchar(6) references product(prod_id));

select * from order1;

insert into order1 values('ORD01', '12-AUG-2021', 'NEW', 'EL102');
insert into order1 values('ORD02', '2021-09-01', 'REPEAT', 'EL101');

insert into order1 values('ORD03', '2021-09-12', 'REPEAT', null);
insert into order1 values('ORD04', '2021-09-14', 'REPEAT', null);



--get information about the product which got an order before Sep 2021

--inner join --fetch you common records from the tables
select p.prod_name, p.prod_desc, p.price, o.ord_date  --older menthod
from product p, order1 o 
where p.prod_id = o.prod_id and
o.ord_date < '2021-09-01';

select p.prod_name, p.prod_desc, p.price, o.ord_date  --latest using inner join
from product p inner join order1 o 
on p.prod_id = o.prod_id
where o.ord_date < '2021-09-01';

-- left outer join
select p.prod_name, p.prod_desc, p.price, o.ord_date  
from product p left outer join order1 o 
on o.prod_id = p.prod_id;

-- Right outer join
select p.prod_name, p.prod_desc, p.price, o.ord_date  
from product p right outer join order1 o 
on o.prod_id = p.prod_id;

-- full outer join
select p.prod_name, p.prod_desc, p.price, o.ord_date  
from product p full outer join order1 o 
on o.prod_id = p.prod_id;

--(note:not advisiable since self join consume more resources)
--self join 
select top 1 p1.prod_name as 'prodA', p2.prod_name as 'prodB', p1.prod_desc
from product p1, product p2
where p1.prod_desc = p2.prod_desc
and p1.prod_name <> p2.prod_name;

select prod_name from product where prod_desc='DELL';

select p1.prod_name as 'prodA', p2.prod_name as 'prodB', p1.prod_desc
from product p1, product p2
where p1.prod_desc = p2.prod_desc
and p1.prod_name <> p2.prod_name;

select p1.prod_name as 'prodA', p2.prod_name as 'prodB'
from product p1, product p2
where p1.prod_desc = p2.prod_desc;

--For Backup the tables
select * into product_bk
from product
where 1 = 0;

select * into product_bk1
from product;

select * from product_bk1;

-- to create a table which will have all the product details
--along with their order ids if any

select * into product_demobk from product where prod_id = prod_id;
select * from product_demobk;

select p.prod_name, p.prod_desc, p.price, o.ord_date 
from product p inner join order1 o 
on p.prod_id = o.prod_id;

create table person (pers_id int primary key identity(1,1),
					pers_name varchar(20) not null,
					age int, check(age>18));

create table person (pers_id int primary key identity(1,1),
					pers_name varchar(20) not null,
					age int check(age>=18));
alter table person
alter column age int check(age>=18)

insert into person values('Robert',20)
insert into person values('James',21)
insert into person values('John',16)
insert into person values('Mike',23)
insert into person values('Jack',22)

select * from person;

delete from person where per_id = 2;

DBCC CHECKIDENT('person')

DBCC CHECKIDENT('person', RESEED, 0)

alter table person1
alter column age int check(age>=20)

create index prod_name_idx
on product(prod_name)		--Which has non unique index

create index prod_name_idx
on product(prod_desc)

create view prod_less_than300 as 
select prod_name, prod_desc, price
from product
where price < 300

select * from  prod_less_than300

drop view prod_less_than300		--delete prod_less_than300
