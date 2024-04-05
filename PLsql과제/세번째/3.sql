declare
    cursor pro_csr is select * from movieexec where certno in(select producerno from movie)  order by name;
    cursor st_csr(m movieexec.certno%type) is select * from studio where presno = m;
    cursor sn_csr(n movieexec.name%type) is select * from starsin where starname = n order by movieyear;
    cnt integer;
    cnt2 integer;
    type sn_ty is table of starsin%rowtype;
    yy sn_ty;
    g varchar2(60);
begin
    for i in pro_csr loop
    dbms_output.put_line('☆제작자['||i.name||'] : 주소['||i.address||'], 재산['||i.networth||'원]');
    select count(*) into cnt from studio where i.certno = presno;
    if cnt = 0 then
        dbms_output.put_line('      운영 영화사 : 없음');
    elsif cnt >= 1 then
        dbms_output.put_line('      운영영화사 :');
        for j in st_csr(i.certno) loop
--        cnt2 := cnt2 + 1;
        dbms_output.put_line('          이름['||j.name||'],사무실 주소['||j.address||']');
        end loop;
    end if;
    select count(*) into cnt2 from starsin where i.name = starname;
    if cnt2 = 0 then
        dbms_output.put_line('      배우 경력 : 해당 없음');
    elsif cnt2 >= 1 then
    select gender into g from moviestar where i.name = name;
        if g = 'female' then
            dbms_output.put_line('      배우 경력 : 성별[여성],총 영화편수['||cnt2||'편]');
        else
            dbms_output.put_line('      배우 경력 : 성별[남성],총 영화편수['||cnt2||'편]');
        end if;
    open sn_csr(i.name);
        fetch sn_csr bulk collect into yy;
    close sn_csr;
        dbms_output.put_line('          최초 출연 영화 : '||yy(yy.first).movietitle||'['||yy(yy.first).movieyear||'년]');
        dbms_output.put_line('          최근 출연 영화 : '||yy(yy.last).movietitle||'['||yy(yy.last).movieyear||'년]');
    end if;
    end loop;
end;