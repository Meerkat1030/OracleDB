select distinct address, avg(length), max(year)
from movie, moviestar, starsin
where movietitle = title and movieyear = year and starname = name and
starname in (select distinct a.name
             from moviestar a, moviestar b
             where a.address = b.address and a.name != b.name)
group by address;