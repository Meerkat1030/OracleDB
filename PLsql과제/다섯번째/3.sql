create or replace trigger Exec_Update
before update on movieexec
for each row
declare
    pragma autonomous_transaction;
    cnt1 integer := 0;
    cnt2 integer := 0;
    cnt3 integer := 0;
    cnt4 integer := 0;
    sn studio.name%type;
begin
    select count(*) into cnt1 from movie where producerno = :old.certno;
    select count(*) into cnt2 from studio where presno = :old.certno;
    select count(*) into cnt3 from moviestar where name = :old.name;
    select count(*) into cnt4 from movieexec where :new.networth > (select avg(networth) from movieexec);
    if cnt1>0 or cnt2 > 0 then
        :new.name := :old.name;
    elsif cnt1 = 0 or cnt2 = 0 then
        if cnt4 > 0 then
        select name into sn from (select * from studio order by dbms_random.random) where rownum = 1;
        update studio
        set presno = :new.certno
        where name = sn;
        commit;
       end if;
    end if;
    if cnt3 > 0 then
        :new.address := '부산시 남구 대연3동';
    end if;
end;