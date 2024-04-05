select distinct moviestar.name , birthdate
from  MovieStar, starsin
where (MOVIEYEAR = '1980' or lower(MOVIETITLE) like '%and%' or lower(MOVIETITLE) like '%of%') and (starname = name)
order by birthdate DESC;
