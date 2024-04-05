insert into movie(title, year, length) values('abc', 2019, 10);
insert into movie(title, year, length) values('abc', 2018, 100);
insert into movie(title, year) values('abc', 2017);

delete from movie
where title = 'abc';

update movie
set length = 99
where title like '%of%';

update movie
set length = length -10
where title like '%of%';

select * from movie
where title like'%abc%';

select title, year, length, certno , networth
from movie, movieexec
where title like '%of%' and producerno = certno;

select random_address from dual;


select * from dml_history;