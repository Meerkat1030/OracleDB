select me1.name, me1.address
from movieexec me1
    minus
select me1.name , me1.address    
from movieexec me1, movieexec me2
where me1.networth < me2.networth;
