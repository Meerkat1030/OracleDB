select distinct title, year
from movie, starsin
where movietitle = title and movieyear = year and  
(length, starname) =(select max(length), starname
                     from movie, starsin
                     where title = movietitle and year = movieyear and
                     starname = (select starname
                           from starsin
                           where gurantee = (select max(gurantee)
                                             from starsin))
                     group by starname)
or (year, starname) = (select min(movieyear), starname
                       from starsin
                       where starname = (select starname
                                         from starsin
                                         where gurantee = (select max(gurantee)
                                                           from starsin))
                       group by starname);


