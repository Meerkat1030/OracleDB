create or replace trigger insert_movie
before insert on movie
for each row
declare
    avg_len movie.length%type;
    prod_no movieexec.certno%type;
    cnt integer;
    prod_name movieexec.name%type := 'new';
begin
    select count(*) into cnt
    from movieexec
    where certno = :new.producerno;
    if :new.producerno is null or cnt = 0 then
        select max(certno) into prod_no
        from movieexec;
        
        :new.producerno := prod_no+1;
        insert into movieexec(name, certno, address) values(prod_name||:new.producerno,:new.producerno,random_address);
    end if;
    
end;