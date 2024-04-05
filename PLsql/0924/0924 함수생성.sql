create or replace function get_studio(tt in movie.title%type, yy in movie.year%type)--movie에 잇는 title의 데이터 타입을 따온다
RETURN movie.studioname%type
is
    sname movie.studioname%type;
begin
    select studioname into sname
    from movie
    where title = tt and year = yy;
    
    return sname;
exception
    when others then
    return  null;
end;