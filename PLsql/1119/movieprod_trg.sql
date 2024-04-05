create or replace trigger movieprod_trg
instead of insert on movieprod
for each row
declare
    cnt integer;
    p_no movieexec.certno%type;
begin
    select count(*) into cnt
    from movieexec
    where :new.producer = name;
    if cnt = 0 then
        select max(certno) into p_no
        from movieexec;
        insert into movieexec(certno,name) values (p_no+1,:new.producer);
    end if;
    select certno into p_no
    from movieexec
    where :new.producer = name;
    
    update movie
    set producerno = p_no
    where title = :new.title and year = :new.year;
end;