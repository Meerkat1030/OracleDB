select DISTINCT movieexec.name, networth
from movieexec, studio
where presno = certno and
movieexec.name in 
  (select starname
  from starsin, movie
  where title = movietitle and year = movieyear
  group by starname
  having count(title) >= 3)
order by 2 desc;