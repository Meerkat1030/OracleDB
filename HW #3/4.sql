select name, spousename 
from moviestar
where gender = 'female' and name in (select spousename
                                     from movieexec, movie
                                     where certno = producerno and gender = 'male' );