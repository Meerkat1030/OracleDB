declare
    cursor csr is select * from movie;
    and_title exception;/*사용자 정의 exception*/
    love_title exception;
    of_title exception;
begin
    for m in csr loop
        begin/*exception으로 하나가 빠져나가면 그이후의 내용을 볼수 없어서 block으로 쪼개줌*/
        if m.title like '%and%' then
            raise and_title;
        elsif m.title like '%love%' then
            raise love_title;
        elsif m.title like '%of%' then
            raise of_title;
        end if;
        dbms_output.put_line(m.title||'('||m.year||')');
    exception 
        when and_title then
            dbms_output.put_line('and_title exception raised..');
        when love_title then
            dbms_output.put_line('love_title exception raised..');
        when of_title then
            dbms_output.put_line('of_title exception raised..');
    end;
    end loop;
end;