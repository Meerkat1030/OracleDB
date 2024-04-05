declare
    --sname moviestar.name%type := 'harrison ford';
    sname moviestar.name%type := '박중훈';
    cnt integer;
    average float;
    s moviestar.name%TYPE;
begin

    select distinct starname into s
    from starsin
    where sname = starname;
    
    select count(*), avg(length) into cnt, average
    from movie, starsin
    where title = movietitle and year = movieyear and sname = starname;
    /*group by starname;*/
    
    if cnt = 0 then /*group by를 안썻을때 오류를 잡아야 하면 if문을 이용*/
    dbms_output.put_line(sname||'-검색 실패 !');
    else
    dbms_output.put_line(sname||' = 영화편수: '||cnt||', 평균상영시간: '||average);
    end if;

exception
    when others then
        dbms_output.put_line(sname||'-검색 실패 !');
end;