declare
    type m_ty is table of movie%rowtype;
    movies m_ty;
    n integer;
    cursor csr is select * from movie;
begin
    open csr;
        fetch csr bulk collect into movies;
    close csr;
    
    n := movies.first;
    loop
        n := n + dbms_random.value(1,10);
        exit when n > movies.last;
        dbms_output.put_line(movies(n).title||'('||movies(n).year||')');
    end loop;
end;