declare
    cursor m_csr is select * from movie order by title, year;
    cursor s_csr(tt movie.title%type, yy movie.year%type) is 
            select * from moviestar
            where name in (select starname from starsin
                            where movietitle = tt and movieyear = yy);
    m movie%rowtype;
    cnt integer;
begin
    for mi in m_csr loop
        dbms_output.put(mi.title||'('||mi.year||')');
        select count(*) into cnt from starsin
        where movietitle = mi.title and movieyear = mi.year;
        if cnt = 0 then
            dbms_output.put_line('출연배우 정보 없음');
        else
            dbms_output.put_line('출연배우 수 - '||cnt||'명');
        end if;
        for s in s_csr(mi.title, mi.year) loop
            dbms_output.put_line('  >>  '||s.name||'('||s.address||')');
        end loop;
    end loop;
end;
/*nested for loop실습*/