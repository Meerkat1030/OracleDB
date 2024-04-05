insert into studio(name,presno) values ('S4',5);

insert into movieexec(certno) values (53);

insert into moviestar(name) values ('T13');

update moviestar
set address = '대연동'
where name = 'T3';

select * from moviestar
where name like 'T%';

select * from studio
where name like 'S%';

select certno from (select certno, rownum r from movieexec)
where r = 2;

select * from movieexec where certno >= 50;

select gender
from (select gender, rownum r from(select gender, count(*) from moviestar where gender is not null group by gender order by 2))
where r = 1;

insert into movie(title, year) values('Z5',2019);
insert into movie(title, year,producerno) values('Z7',2019,60);
insert into movie(title, year,studioname) values('Z8',2019,'new1');

select * from movie
where title like 'Z%';

select * from movieexec
where certno > 50;

select * from studio
where name like 'NEW%';

update movie
set studioname = 'NEW3'
where title like 'Z%';

