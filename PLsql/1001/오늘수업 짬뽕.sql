declare
    type st_ty is table of moviestar%rowtype index by moviestar.name%type;/*associative array*/
    type minfo_ty is record (
        mov movie%rowtype,
        stars st_ty
    );/*record*/
    type mov_ty is table of minfo_ty;/*nested table/minfo_ty모양의 배열*/
    movies mov_ty := mov_ty();
    cursor m_csr is select * from movie;
    cursor s_csr(tt movie.title%type, yy movie.year%type) is 
        select * from moviestar
        where name in (select starname from starsin where movietitle = tt and movieyear = yy);
    m movie%rowtype;
    s moviestar%rowtype;
begin
    open m_csr;
    loop
        fetch m_csr into m;
        exit when m_csr%notfound;
        movies.extend;
        movies(m_csr%rowcount).mov := m;
        open s_csr(m.title, m.year);
        loop
            fetch s_csr into s;
            exit when s_csr%notfound;
            movies(m_csr%rowcount).stars(s.name) := s;
        end loop;
        close s_csr;
    end loop;
    close m_csr;
    for i in movies.first..movies.last loop
        dbms_output.put_line(movies(i).mov.title||', '||movies(i).mov.year);
    end loop;
end;