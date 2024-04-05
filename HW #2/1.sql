select avg(length), min(year), count(title)
from movie, studio
group by studioname
order by 3 desc; 