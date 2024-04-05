select movieexec.name
from studio, movieexec
where lower(studio.name) = 'fox' and presno = certno ;