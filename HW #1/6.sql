select name, address
from moviestar
where GENDER = 'male' or lower(address) like '%malibu%';