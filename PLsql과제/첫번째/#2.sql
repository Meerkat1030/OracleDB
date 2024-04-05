accept sn prompt '배우 이름은 ?';

declare
    cnt integer;
    average number;
begin
    select count(title), round(avg(length),1) into cnt,average
    from movie , starsin 
    where lower(starname) = '&sn' and title = movietitle and year = movieyear
    group by starname;
    dbms_output.put_line('&sn : '||'출연 영화편수['||cnt||'편], 출연 영화의 평균 상영시간['||average||'분]');
exception
    when OTHERS then 
        DBMS_OUTPUT.PUT_line('검색 오류!!!');
end;