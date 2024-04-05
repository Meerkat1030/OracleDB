declare
    type st_ty is record(
        sn starsin.starname%type,
        cnt number,
        lenavg number,
        fy movie.year%type
    );
    type s_ty is table of st_ty;
    a st_ty;
    b s_ty := s_ty();
    i integer := 1;
    cursor csr is select starname, count(title), round(avg(length),2), min(year)
                  from movie, starsin
                  where movietitle = title and movieyear = year
                  group by starname
                  order by starname;
begin
    open csr;
    dbms_output.put_line(rpad('순번',5,' ')||rpad('배우이름',26,' ')||rpad('출연 영화편수',33,' ')||rpad('평균 상영시간',33,' ')||rpad('첫 영화 년도',34,' '));
    loop
        fetch csr into a;
        exit when csr%notfound;
        b.extend;
        b(i) := a;
        dbms_output.put_line(rpad(i,4,' ')||rpad(b(i).sn,30,' ')||rpad(b(i).cnt,30,' ')||rpad(b(i).lenavg,30,' ')||rpad(b(i).fy,30,' '));
        i := i + 1;
    end loop;
    close csr;
exception
    when others then
    dbms_output.put_line('오류 발생!!');
end;