create or replace trigger MovieExec_Ins
before insert on Movieexec
for each row
declare
    cnt integer;
    avg_net movieexec.networth%type;
    sql_str varchar(200) := 'select certno from (select certno, rownum r from movieexec) where r = :1';
begin
    if :new.address is null then
        :new.address := random_address;
    end if;
    if :new.networth is null then
        select avg(networth) into avg_net from movieexec;
        
        :new.networth := avg_net;
    end if;
    if :new.name is null then
        :new.name := 'TEMP_'|| :new.certno;
    end if;
end;