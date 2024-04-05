select starname
from  starsin, movie
where  (year = 1995 and lower(studioname) = 'mgm') and (title = movietitle and year = movieyear);