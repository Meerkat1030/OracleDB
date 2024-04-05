create or replace trigger Studio_Ins
before insert on Studio
for each row
declare
    cnt integer;
    p_no studio.presno%type;
    sql_str varchar(200) := 'select certno from (select certno, rownum r from movieexec) where r = :1';
begin
    if :new.address is null then
        :new.address := random_address;
    end if;
    if :new.presno is null then
        select count(*) into cnt from movieexec;
        
        execute immediate sql_str into p_no using trunc(dbms_random.value(1,cnt+1));
        :new.presno := p_no;
    end if;
end;