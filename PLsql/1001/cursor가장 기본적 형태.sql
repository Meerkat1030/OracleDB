declare
    cursor csr is select * from movie;
    m movie%rowtype;

begin
    open csr;
    loop
        fetch csr into m;/*하나의 무비 튜플씩 fetch 시킴*/
        exit when csr%notfound;/*데이터가 더이상 없다면 exit해라*/
        dbms_output.put_line(m.title||'('||m.year||'년 개봉) '||'상영시간: '||m.length);
    end loop;
    close csr;
end;