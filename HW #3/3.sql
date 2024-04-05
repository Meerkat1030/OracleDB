select name, count(title), avg(length)
from movie, movieexec
where directorno = certno
group by name;