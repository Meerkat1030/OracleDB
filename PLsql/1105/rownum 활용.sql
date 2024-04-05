select *
from movie
where rownum = 1
order by year;

select * 
from (select m.*, rownum r from (select * from movie order by year) m) where r = 10;



