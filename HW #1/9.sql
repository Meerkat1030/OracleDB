select mo1.title
from movie mo1, movie mo2
where lower(mo2.title) like 'gone with the wind' and mo1.length > mo2.length;