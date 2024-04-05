declare
    addr varchar(200);
    c varchar(50);
    g varchar(50);
    d varchar(50);
begin
    for i in 1..100 loop
        get_address(c,g,d);
        dbms_output.put_line(addr);
    end loop;
end;