create or replace procedure Get_StarInfo(star_name in starsin.starname%type,sname out varchar2 ,cnt out integer, average out number)
is
begin
    select count(title), round(avg(length),1) into cnt,average
    from movie , starsin 
    where lower(starname) = star_name and title = movietitle and year = movieyear
    group by starname;
    sname := star_name;
exception
    when others then
    cnt := -1;
    average := -1;
end;