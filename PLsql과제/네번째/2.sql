declare
    cursor csr is select * from studioinfo;
    m_list studioinfo.movies%type;
    s_list studioinfo.stars%type;
begin
    for i in csr loop
        dbms_output.put_line('영화사 이름 : '||i.name ||', 영화사 주소 : '||i.address||', 영화사 사장 : ['||i.president||']');
        m_list := i.movies;
        if m_list.count > 0 then
            for j in 1..m_list.last loop
            dbms_output.put_line('  >>  영화 제목 : '||m_list(j).title||'('||m_list(j).year||'년 개봉) 영화 제작에 필요한 예산 : '||m_list(j).budget||'원, 영화 감독['||m_list(j).producer||']');
            end loop;
        else
            dbms_output.put_line('  >>  영화 정보 없음');
        end if;
        s_list := i.stars;
        if s_list.count > 0 then
            for k in 1..s_list.last loop
            dbms_output.put_line('  ▶▶  배우 이름 : '|| s_list(k).name||', 계약 금액 : '||s_list(k).salary||'원, 계약 기간 : '||s_list(k).cont_period||'년');
            end loop;
        else
            dbms_output.put_line('  ▶▶  배우 정보 없음');
        end if;    
    end loop;
end;