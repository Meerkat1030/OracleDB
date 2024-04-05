create or replace procedure get_info(tt in movie.title%type, yy in movie.year%type,
        sname out movie.studioname%type, pname out movieexec.name%type,
        len out float)
is
    tmp movie.studioname%type;
    tmp_len float;
begin
    select studioname, name, length into tmp, pname, tmp_len
    from movie, movieexec
    where title = tt and year = yy and producerno = certno;
    len := tmp_len/60;
    sname := tmp; 
    --여기서는 :=로 해줘야 한다
exception
    when others then
    sname := null;
end;
/*프로시저에서 return은 생략*/