select title, year
from movie, moviestar, starsin
where title = movietitle and year = movieyear and starname = name and 
(starname, length) in(select starname, max(length)
                      from starsin, movie, moviestar
                      where starname = name and movietitle = title and movieyear = year and gender = 'female' 
                      and birthdate > (select birthdate
                                       from moviestar
                                       where lower(name) = 'danny devito')
                      group by starname)
order by 1 asc,2;