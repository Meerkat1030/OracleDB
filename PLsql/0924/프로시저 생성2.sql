create or replace procedure get_info(sname in movie.studioname%type, cnt out integer)
is
begin
    select count(*) into cnt
    from movie
    where sname = studioname;
exception
    when others then
    cnt := null;
end;
/*프로시저에서 return은 생략*/