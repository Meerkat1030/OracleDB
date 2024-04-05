declare
    type sinfo_ty is record(
        sn studio.name%type,
        saddr studio.address%type,
        cn movieexec.name%type,
        caddr movieexec.address%type
    );
    type s_ty is table of sinfo_ty index by varchar(250);
    cursor csr is select studio.name, studio.address, movieexec.name, movieexec.address
                  from studio, movieexec
                  where presno = certno
                  order by studio.name;
    s s_ty;
    a sinfo_ty;
    i varchar(250);
    j integer := 1;
begin
    open csr;
    loop
        fetch csr into a;
        exit when csr%notfound;
        s(a.sn) := a;
    end loop;
    close csr;
    dbms_output.put_line(rpad('순번',5,' ')||rpad('영화사',27,' ')||rpad('영화사 주소',62,' ')||rpad('사장',22,' ') ||rpad('사장 주소',65,' '));
    i := s.first;
    while i is not null loop
        dbms_output.put_line('['||rpad(j,2,' ')||'] '||rpad(s(i).sn,25,' ')||rpad(s(i).saddr,60,' ')||rpad(s(i).cn,22,' ')||rpad(s(i).caddr,65,' '));
        i := s.next(i);
        j := j+1;
    end loop;
exception
    when others then
    dbms_output.put_line('오류 발생!!');
end;