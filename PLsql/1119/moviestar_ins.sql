create or replace trigger MovieStar_Ins
before insert or update on MovieStar
for each row
declare
    cnt integer;
    gen moviestar.gender%type;
    sql_str varchar(200) := 'select certno from (select gender, count(*), rownum r from studio group by gender) where r = :1';
    pragma autonomous_transaction;
begin
    if :new.address is null then
        :new.address := random_address;
    end if;
    if :new.gender is null then
        for s in (select gender, count(*) from moviestar where gender is not null group by gender order by 2) loop
            :new.gender := s.gender;
            exit;
        end loop;
    end if;
    if :new.birthdate is null then
        :new.birthdate := sysdate-dbms_random.value(1,70*365);
    end if;
end;