declare
    type tt_ty is table of movie.title%type;
    type yy_ty is table of movie.year%type;
    type mov_ty is table of movie%rowtype;
    ts tt_ty;
    ys yy_ty;
    ms mov_ty;
    cursor csr is select * from movie;/*static cursor*/
begin
    open csr;
        fetch csr bulk collect into ms; /*한번에 왕창 받아 옴*/
    close csr;
    
    for i in ms.first..ms.last loop
        dbms_output.put_line(ms(i).title||'('||ms(i).year||')');
    end loop;
end;