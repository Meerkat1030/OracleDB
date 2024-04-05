select title, year
from movie, studio, movieexec a, movieexec b
where producerno = a.certno and
      b.certno = presno and
      studioname = studio.name and
      a.networth in (select max(c.networth)
                     from movieexec c, movie
                     where producerno = c.certno) and 
      b.networth in (select min(d.networth)
                     from movieexec d, studio
                     where presno = d.certno);