declare
    cursor csr is select * from movie for update;/*업데이트 딜리트시 반디스 for update delete적어주기*/
    m movie%rowtype;
    tt movie.title%type := 'star wars';
begin
    open csr;
    loop
        fetch csr into m;
        exit when csr%notfound;
        
        if m.title = tt then
            update movie
            set length = length + 99
            where current of csr;/*현재 fetch된 튜플에 대해서 length값을 update*/
        elsif m.title like'%end%' then
            update movie
            set length = length - 10
            where current of csr;
        end if;
    end loop;
    close csr;
end;