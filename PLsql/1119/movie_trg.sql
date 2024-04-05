create or replace trigger Movie_Trg
before insert or update on Movie
for each row
declare
    avg_len movie.length%type;
    certno movieexec.certno%type;
    s_name studio.name%type;
    cnt integer;
    sql_str varchar(200) := 'select name from (select name, rownum r from studio) where r = :1';
begin
    if :new.length is null then
        select avg(length) into avg_len from movie;
        :new.length := avg_len;
    end if;
    if :new.incolor is null then
        :new.incolor := 't';
    end if;
    if :new.producerno is null then
        select certno into certno from movieexec
        where networth = (select max(networth) from movieexec) and rownum = 1;
        :new.producerno := certno;
    else
        select count(*) into cnt from movieexec
        where certno = :new.producerno;
        if cnt = 0 then
            insert into movieexec(certno) values(:new.producerno);
        end if;
    end if;
    if :new.studioname is null then
        select count(*) into cnt from studio;
        execute immediate sql_str into s_name using trunc(dbms_random.value(1,cnt+1));
        :new.studioname := s_name;
    else
        select count(*) into cnt from studio
        where name = :new.studioname;
        if cnt = 0 then
            insert into studio(name) values(:new.studioname);
        end if;
    end if;
end;