select title, length, movieexec.name
from movie, starsin, moviestar ,movieexec
where (certno = PRODUCERNO) and (year = movieyear) and(title = movietitle) and (birthdate < '1970-01-01' )
    and(lower(gender) = 'female') and (starname = moviestar.name) 
    and(lower(moviestar.address) like '%california%')
    order by 2 DESC, 1;