create or replace trigger StarPlays_Trigger
instead of insert on StarPlays
for each row
declare
    cnt integer;
    cnt2 integer;
    pragma autonomous_transaction;
begin
    select count(*) into cnt from movie where title = :new.title and year = :new.year;
    select count(*) into cnt2 from moviestar where :new.name=name;
    
    if cnt = 0 then
        insert into movie(title, year) values(:new.title,:new.year);
        commit;
    end if;
    if cnt2 = 0 then
        insert into moviestar(name) values(:new.name);
        update moviestar--주소 업뎃
        set address = random_address
        where :new.name = name;
        update moviestar--성별업뎃
        set gender = (select gender from moviestar where birthdate in (select max(birthdate) from moviestar))
        where :new.name = name;
        update moviestar--생일업뎃
        set birthdate = to_date('19800101','yyyymmdd') + dbms_random.value(1,(21*365)-1)
        where :new.name = name;
        commit;
    end if;
    insert into starsin(movietitle, movieyear, starname) values (:new.title, :new.year, :new.name);
    commit;
end
commit;