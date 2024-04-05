create or replace trigger fox_studio_trg
instead of insert on fox_studio
for each row
declare
    cnt integer;
begin
    select count(*) into cnt from movie
    where title = :new.title and year = :new.year;
    
    if cnt = 0 then
        insert into movie(title, year,studioname) values (:new.title, :new.year, 'fox');
    else
        update movie
        set studioname = 'fox'
        where title = :new.title and year = :new.year;/*이미 잇는 녀석이면 update로 처리*/
    end if;
end;