select *
from movie
/*where title like'%and%';*/
where title like '%'||'and'||'%';/*같은 방법 dynamic sql에서는 이 형태가 더 유용함*/