select distinct starname
from movieexec,studio,movie,starsin
where starname = movieexec.name and presno=certno and producerno = certno;