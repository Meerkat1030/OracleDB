select count(title), avg(length)
from movie, starsin
where movietitle = title and movieyear = year and lower(starname) = 'harrison ford';