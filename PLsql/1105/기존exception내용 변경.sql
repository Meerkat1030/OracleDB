declare
    m   movie%rowtype;
    many_movies exception;
    PRAGMA EXCEPTION_INIT (many_movies, -1422);/*pragma = 컴파일러 디렉티브/컴파일러에게 01422 exception이 이거(many_movies)다*/
begin
    select * into m
    from movie
    where title like '%and%';
    
    dbms_output.put_line(m.title||', '||m.year);
exception
    when others then
    dbms_output.put_line(SQLCODE||' : '||SQLERRM);--sqlcode번호와 오류메세지를 출력해줌 반드시 점부 대문자로
    dbms_output.put_line('하나 이상의 영화 튜플 검색됨...');
end;