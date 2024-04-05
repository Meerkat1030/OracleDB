declare
    sname moviestar.name%type := 'harrison ford';
    s moviestar%rowtype;
begin
    select * into s
    from moviestar
    where name = sname or name like '%o%';
    
    if sql%found then
        dbms_output.put_line(s.name||', '||s.address);
    elsif sql%notfound then
        dbms_output.put_line(sname||'검색실패');
    end if;
exception /*묵시적은 cursor이라고도 불림*/
    when no_data_found then
        dbms_output.put_line(sname||'검색실패!');
    when too_many_rows then /*너무 많은 검색결과로 오류가 날때*/
        dbms_output.put_line('하나 이상의 튜플 검색');
    
end;