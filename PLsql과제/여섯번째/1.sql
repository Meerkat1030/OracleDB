create or replace trigger MovieProd_Insert
instead of insert on Movieprod
for each row
declare
    cnt integer;
    cnt2 integer;
    c movieexec.certno%type;
    net movieexec.networth%type;
    p_no movieexec.certno%type;
begin
    select count(*) into cnt from movieexec where :new.producer = name;
    select count(*) into cnt2 from movie where :new.title = title and :new.year = year;
   
    if cnt = 0 then
        select max(certno) into c from movieexec;
        insert into movieexec(certno, name) values(c+1, :new.producer);
    end if;
    select certno into p_no from movieexec where :new.producer = name;
    if cnt2 = 0 then
        insert into movie(title,year,producerno) values (:new.title, :new.year,p_no);
        select networth into net from movieexec where certno = (select presno from movie, studio where title = :new.title and year = :new.year and studioname = name);
        update movieexec
        set networth = net
        where name = :new.producer;
    else
        update movie
        set producerno = p_no
        where title = :new.title and year = :new.year;
        select networth into net from movieexec where certno = (select presno from movie, studio where title = :new.title and year = :new.year and studioname = name);
        update movieexec
        set networth = net
        where name = :new.producer;
    end if;
end;