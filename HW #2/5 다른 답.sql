select name
from moviestar
where gender = 'female' and name not in
(select name
from moviestar, starsin
where lower(movietitle)like '%sting%' and starname = name)
order by birthdate desc;