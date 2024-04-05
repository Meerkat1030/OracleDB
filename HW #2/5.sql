select a.name
from moviestar a
where a.name in (select name
                 from moviestar
                 where gender = 'female'
                 minus
                 select name
                 from moviestar, starsin
                 where starname = name and lower(movietitle) like '%sting%')
order by birthdate desc;