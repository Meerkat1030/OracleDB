create or replace trigger movieprod_ins
instead of insert on movieprod
for each row
declare
    cnt integer;
    pno movie.producerno%type;
    sname movie.studioname%type;
    p_net movieexec.networth%type;
begin
    select count(*) into cnt
    from movie
    where title = :new.title and year = :new.year;
    if cnt = 0 then
        select studioname into sname from (select studioname, count(*) from movie group by studioname order by 2,1)where rownum = 1;
        insert into movie(title, year,studioname) values(:new.title,:new.year,sname);
    end if;
    select count(*) into cnt from movieexec where name = :new.producer;
    if cnt = 0 then
         select max(certno)+1 into pno from movieexec;
         select networth into p_net from movieexec where certno = (select presno from movie, studio where title = :new.title and year = :new.year and studioname = name); 
        insert into movieexec(certno,name,networth) values(pno,:new.producer,p_net);
    end if;
    
    select certno into pno from movieexec where name = :new.producer;
    update movie
    set producerno = pno
    where title = :new.title and year = :new.year;
end;