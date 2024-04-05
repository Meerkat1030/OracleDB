select distinct title, year
from movie, movieexec d, movieexec e, movieexec f, studio
where directorno = d.certno and 
      producerno = e.certno and 
      presno = f.certno and
d.networth in (select max(a.networth)
               from movie, movieexec a
               where a.certno = directorno) and
e.networth in (select min(c.networth)
               from movie, movieexec c
               where c.certno = producerno) and
f.networth in (select min(b.networth)
               from studio, movieexec b
               where b.certno = presno);