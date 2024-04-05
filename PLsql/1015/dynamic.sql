declare
    type csr_ty is ref cursor;
    csr csr_ty;
    len constant integer := 100;
    sql_str varchar(200) := 'select * from movie where length > :1';
    m movie%rowtype;
begin
    open csr for sql_str using len;
    loop
        fetch csr into m;
        exit when csr%notfound;
        dbms_output.put_line(m.title||'('||m.year||') '||m.length||'분');
    end loop;
    close csr;
end;