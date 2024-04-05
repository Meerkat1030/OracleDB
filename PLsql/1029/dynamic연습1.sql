declare
    type csr_ty is ref cursor;/*커서 선언*/
    csr csr_ty;/*커서 변수*/
    m movie%rowtype;
    avg_len integer;
    type key_ty is table of varchar(50);
    keywords key_ty := key_ty('and', 'of', 'love');/*내가 찾고자 하는 문자열을 ()안에 넣어주면됨*/
    sql_str varchar(200) := 'select * from movie where title like ''%''||:1||''%'' ';/*keywords의 단어들중 하나 현재는 1번 즉 and가 들어잇음 and가 다 돌고 나면 of로 바뀜 :1이란거는 하나만 돌린다는 뜻*/
    avg_str varchar(200) := 'select avg(length) from movie where title like ''%''||:1||''%'' ';
begin
    for i in keywords.first..keywords.last loop
        execute IMMEDIATE avg_str into avg_len using keywords(i);
        dbms_output.put_line('---'||keywords(i)||'가 영화제목에 들어간 영화들 : '||avg_len||'분 평균');
        open csr for sql_str using keywords(i);
        loop
            fetch csr into m;
            exit when csr%notfound;
            dbms_output.put_line(m.title||'('||m.year||')');
        end loop;
        close csr;/*다이나믹 형식의 open*/
    end loop;
end;