select producerno
from (  select producerno, count(*)
        from movie
        group by producerno
        order by 2 desc )
where rownum = 5;


select * from 
(select m.*, rownum rr from (select * from movie order by year) m)
where rr = 12;

