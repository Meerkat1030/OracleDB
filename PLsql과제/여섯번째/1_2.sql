create or replace trigger New_Movies
before insert or update on Movie
for each row
declare
    cnt integer;
    ran_mov movie.length%type;
    row_sn movie.studioname%type;
    pragma autonomous_transaction;
begin
    if :new.length is null then
        select length into ran_mov from (select * from movie order by dbms_random.random) where rownum = 1;
        :new.length := ran_mov;
    end if;
    if :new.incolor is null then
        :new.incolor := 't';
    end if; 
    if :new.studioname is null then
        for s in (select studioname into row_sn from (select studioname from movie group by studioname order by count(*)) where rownum = 1) loop
                :new.studioname := s.studioname;
        end loop;
    end if;
end
commit;