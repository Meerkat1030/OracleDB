select me1.name
from movieexec me1, movieexec me2
where lower(me2.name) like 'merv griffin' and me1.networth > me2.networth ;