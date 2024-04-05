declare
    type csr_ty is ref cursor;
    csr csr_ty;
    type k_ty is table of varchar(50);
    ks k_ty := k_ty('and', 'of', 'love', 'star');
    avg_len number;
    sql_str varchar(200) := 'select * from movie where title like ''%''||:1||''%'' ';
    avg_str varchar(200) := 'select avg(length) from movie where title like ''%''||:1||''%'' ';
    m movie%rowtype;
begin
    for i in ks.first..ks.last loop
        execute immediate avg_str into avg_len using ks(i);
        dbms_output.put_line('영화제목에 '||ks(i)||'가 포함된 영화 리스트 : 평균상영시간 - '||avg_len);
        open csr for sql_str using ks(i);
        loop
            fetch csr into m;
            exit when csr%notfound;
            dbms_output.put_line(lpad('-',5)||m.title||','||m.year);
        end loop;
        close csr;
    end loop;
end;