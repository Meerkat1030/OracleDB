insert into moviestar(name, address, birthdate,gender) values ('가','서울','1999-10-30','m');
select * from moviestar where name='가';
update movieexec
set name = '나당',
    address = '무지개동',
    networth = 470000000
where certno = 25;
update movieexec
set name = '다당',
    address = '무개동',
    networth = 4700000000
where certno = 19;

update movieexec --새로 update되는 이름이 영화배우인 경우
set name = 'mark hamill',
    address = '무지개동',
    networth = 470000000
where certno = 17;

update movieexec
set address = '양산시 서들로',
networth = 1
where certno = 12;

select *
from movieexec;

select *
from studio;

select distinct certno
from studio, movieexec, movie
where presno = certno or producerno = certno
order by certno;

select *
from movieexec, moviestar
where movieexec.name = moviestar.name;

select *
from movieexec,moviestar
where movieexec.name = moviestar.name;

select * from dml_history;
select name  from (select s.*, rownum r from (select * from studio order by dbms_random.random) s) where r = 1;
select * from (select * from studio order by dbms_random.random) where rownum = 1;