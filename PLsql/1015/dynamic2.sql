declare
    type csr_ty is ref cursor;
    csr csr_ty;
    std varchar(50) := '&studio';
    len constant integer := 100;
    sql_str varchar(200);
    m movie%rowtype;
    t movie.title%type;
    y movie.year%type;
    sn movie.studioname%type;
    sa studio.address%type;
    
begin
    if std = 'fox' then
        sql_str := sql_str || 'select title, year, studioname, address '||
                              ' from movie,studio where studioname = name and length > :1  and studioname = :2 ';
        open csr for sql_str using len,std;
    else
        sql_str := sql_str || 'select title, year '||
                              ' from movie where length > :1 ';
        open csr for sql_str using len;
    end if;
    
    loop
        if std = 'fox' then
            fetch csr into t, y, sn, sa;
        else
            fetch csr into t, y, sn;
        end if;
        exit when csr%notfound;
        dbms_output.put(t||'('||y||'), 영화사 - '||sn);
        if std = 'fox' then
            dbms_output.put_line(' '||sa);
        else
            dbms_output.put_line(' ');
        end if;
    end loop;
    close csr;
end;