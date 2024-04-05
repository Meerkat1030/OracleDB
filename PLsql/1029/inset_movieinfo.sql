declare
    cursor m_csr is select * from movie;
    cursor star_csr(tt movie.title%type, yy movie.year%type) is select starname from starsin where movietitle = tt and movieyear = yy;/*현재 영화에 출연한 배우를 찾아주는 커서*/
    ins_sql varchar(200) := 
        'insert into movieinfo values (:1, :2, :3, star_tab(), studio_tab())';
    star_sql    varchar(200) := 
        'insert into table(select stars from movieinfo where title = :1 and year = :2) values (star_ty(:3, :4))';
begin
    for m in m_csr loop
    dbms_output.put_line(m.title||'('||m.year||')');
        execute immediate ins_sql using m.title, m.year, m.length;
        for sn in star_csr(m.title, m.year) loop
            execute immediate star_sql using m.title, m.year, sn.starname,1000;
        end loop;
    end loop;
end;