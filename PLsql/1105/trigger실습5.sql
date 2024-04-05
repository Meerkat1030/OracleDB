create or replace trigger insert_movie
before insert on movie
for each row
declare
    avg_len movie.length%type;
    prod_no movieexec.certno%type;
    cnt integer;
begin
    select count(*) into cnt
    from movieexec
    where certno = :new.producerno;
    if :new.producerno is null or cnt = 0 then
        select certno into prod_no
        from movieexec
        where rownum = 1;
        :new.producerno := prod_no;
    end if;
    
end;