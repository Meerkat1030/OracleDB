declare
    cursor csr is select * from movie;
    and_title exception;/*사용자 정의 exception*/
    love_title exception;
    of_title exception;
begin
    for m in csr loop
        begin/*exception으로 하나가 빠져나가면 그이후의 내용을 볼수 없어서 block으로 쪼개줌*/
        if m.title like '%and%' then
            raise_application_error(-20000,'And title..');/*에러 코드와 함께 오류 이름 정해줄수 잇음 20000~20999까지가 사용자정의 오류코드범위*/
            /*프로그램이 바로 정지 되어버린다 exception으로 처리 X dbms출력이 아닌 스크립트 출력으로 나옴*/
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