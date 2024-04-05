declare
    type mov_ty is table of movie%rowtype;
    cursor m_csr is select * from movie order by title, year;
    cursor s_csr(tt movie.title%type, yy movie.year%type) is 
            select * from moviestar
            where name in (select starname from starsin
                            where movietitle = tt and movieyear = yy);
    cursor p_csr(pno movieexec.certno%type) is 
            select * from movie where producerno = pno order by year desc;
    ms mov_ty;
    m movie%rowtype;
    cnt integer;
    
begin
    for mi in m_csr loop
        open p_csr(mi.producerno);/*현재 돌고잇는 튜플의 producerno를 넘겨준다*/
            fetch p_csr bulk collect into ms;
        close p_csr;
        dbms_output.put(mi.title||'('||mi.year||') 제작자('||mi.producerno||', 제작한 영화편수 - '||ms.count||'편), ');
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