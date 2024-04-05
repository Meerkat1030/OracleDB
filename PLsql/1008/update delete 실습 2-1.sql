declare
    cursor csr is select * from moviestar for update;/*업데이트 딜리트시 반디스 for update delete적어주기*/
    s moviestar%rowtype;
    tt movie.title%type := 'star wars';
    cnt integer;
    sname moviestar.name%type;
begin
    open csr;
    loop
        fetch csr into s;
        exit when csr%notfound;
        
        begin
            select distinct starname into sname
            from starsin where starname = s.name;
        exception
            when others then
                delete from moviestar
                where current of csr;
                dbms_output.put_line(s.name||' moviestar tuple 삭제!!');
        end;
    end loop;
    close csr;
end;