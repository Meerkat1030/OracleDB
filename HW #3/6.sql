select distinct moviestar.name, movieexec.name, moviestar.birthdate,movieexec.birthdate
from moviestar, movieexec
where movieexec.birthdate = moviestar.birthdate and
moviestar.birthdate in (select distinct movieexec.birthdate
from movieexec, movie
where certno = producerNo);