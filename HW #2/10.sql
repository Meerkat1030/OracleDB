select avg(distinct networth)
from starsin,movieexec,movie
where starname = movieexec.name and producerno = certno;