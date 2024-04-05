accept tt prompt '영화 제목은 ?';
accept yy prompt '개봉년도 ?';

declare
    sname movie.studioname%type;
    saddr studio.address%type;
    ename movieexec.name%type;
    enetw movieexec.networth%type;
begin
    select s.name, s.address, e.name, e.networth into sname, saddr, ename, enetw
    from movie m, studio s, movieexec e
    where lower(title) = '&tt' and year = &yy and m.studioname=s.name and s.presno = e.certno; 
    dbms_output.put_line('영화사 이름 : '||sname||' , 영화사 주소 : '||saddr||' , 사장 이름 : '||ename||' , 사장의 재산 : '||enetw);
exception
    when OTHERS then
        DBMS_OUTPUT.PUT_line('검색 오류!!!');
end;