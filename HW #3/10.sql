select studio.name, empno, movieexec.name, movieexec.address
from movieexec, studio
where certno = presno and studio.name in
(select distinct name
from studio, movie
where name = soundstudio);