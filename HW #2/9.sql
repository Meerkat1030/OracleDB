select  studio.name, count(distinct certno)
from movie, movieexec, studio
where studio.name = studioname and certno = producerno  
group by studioname
having avg(networth) >= 1000000;