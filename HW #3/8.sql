select  distinct movieexec.name,movieexec.spousename, title
from movieexec, movie, starsin
where certno = directorno and
year = movieyear and
title = movietitle and
starname in(select distinct spousename
from movieexec,movie
where certno = directorno);