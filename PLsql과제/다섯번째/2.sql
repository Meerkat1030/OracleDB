create or replace trigger Star_Insert
before insert on moviestar
for each row
declare
    pragma autonomous_transaction;
    male_cnt integer:=0;
    female_cnt integer:=0;
    a integer:=0;
begin
    if :new.address is not null then
        :new.address := random_address;
    end if;
    if :new.birthdate is not null then
        :new.birthdate := to_date('19500101','yyyymmdd') + dbms_random.value(1,50*365);
    end if;
    select count(gender) into male_cnt
    from moviestar
    where gender = 'male' and birthdate > :new.birthdate;
    select count(gender) into female_cnt
    from moviestar
    where gender = 'female' and birthdate > :new.birthdate;
    if :new.gender is not null then
        if male_cnt < female_cnt then
            :new.gender := 'female';
        elsif male_cnt > female_cnt then
            :new.gender := 'male';
        elsif male_cnt = female_cnt then
            a := trunc(dbms_random.value(1,2+1));
            if a = 1 then
                :new.gender := 'male';
            elsif a = 2 then
                :new.gender := 'female';
            end if;
        end if;
        commit;
    end if;
end;