declare
    
    cursor csr is select title, year,address from movie, studio
                    where studioname = name;/* select * 이형태는 cursor로 받기 힘들다*/
                                            /* 조인시킨 결과중 뭘들고올지 애매해서*/
    m movie%rowtype; 
    tt movie.title%type;
    yy movie.year%type;
    addr studio.address%type;
begin
    open csr;
    loop
        fetch csr into tt, yy, addr;/*하나의 무비 튜플씩 fetch 시킴*/
        exit when csr%notfound;/*데이터가 더이상 없다면 exit해라*/
        dbms_output.put_line(tt||'('||yy||'년 개봉)'||addr);
    end loop;
    close csr;
end;