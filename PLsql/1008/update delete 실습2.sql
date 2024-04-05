declare
    cursor csr is select * from moviestar for update;/*업데이트 딜리트시 반디스 for update delete적어주기*/
    s moviestar%rowtype;
    tt movie.title%type := 'star wars';
    cnt integer;
begin
    open csr;
    loop
        fetch csr into s;
        exit when csr%notfound;
        select count(*) into cnt
        from starsin where starname = s.name;
        if cnt = 0 then
            delete from moviestar
            where current of csr;
            dbms_output.put_line(s.name||' moviestar tuple 삭제!!');
        end if;
    end loop;
    close csr;
end;