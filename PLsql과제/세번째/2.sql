declare
    cursor ms_csr is select * from moviestar order by name;
    cursor si_csr(s moviestar.name%type) is select * from starsin where starname = s order by movieyear;
    cnt integer;
    cnt2 integer;
    cnt3 integer := 0;
begin
    for i in ms_csr loop
    select count(*) into cnt from starsin where starname = i.name;
    if cnt >= 1 then
        cnt2 := 0;
        cnt3 := cnt3+1;
        dbms_output.put('['||cnt3||']'||i.name||' : ');
        for j in si_csr(i.name) loop
            cnt2 := cnt2 + 1;
            if cnt2 > 1 then
            dbms_output.put(', '||j.movietitle||'('||j.movieyear||'년)');
            else
            dbms_output.put(j.movietitle||'('||j.movieyear||'년)');
            end if;
        end loop;
        if cnt2 > 1 then
            dbms_output.put_line(' 등의 '||cnt2||'편에 출연');
        else
            dbms_output.put_line('1편 출연');
        end if;
    end if;
    end loop;
end;