select movietitle, avg(gurantee)
from starsin
where (movietitle) in (select title
                       from movie
                       where lower(studioname) ='fox')
group by movietitle
order by 1 asc;
