declare
    type n_ty is table of movie%rowtype index by varchar(250);
    movies n_ty;
    i varchar(250);
    cursor csr is select * from movie;
    m movie%rowtype;/*두줄은 세트처럼 항상 붙어 다녀야 한다*/
begin
    open csr;
    loop
        fetch csr into m;
        exit when csr%notfound;
        movies(m.title||m.year) := m;/*key값으로 하나로 만듬 // 때온 튜플을 배열에 넣어주는것*/
    end loop;
    close csr;
    i := movies.first;
    while i is not null loop
        dbms_output.put_line(i||' : '||movies(i).title||'('||movies(i).year||'년 개봉)');
        i := movies.next(i);
    end loop;

end;