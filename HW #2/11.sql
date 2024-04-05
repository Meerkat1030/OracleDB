select count(title), length
from movie
group by length
having 1 < count(length)
order by 2 desc;