declare
    cursor csr is select * from people;
    p_list people.phone_list%type;
    a_list people.addresses%type;
begin
    for p in csr loop
        dbms_output.put_line(p.name||'-'||p.birthdate);
        p_list := p.phone_list;
        for i in 1..p_list.last loop
            dbms_output.put_line('  >>  '||p_list(i).name||'-'||p_list(i).seq||'-'||p_list(i).no);
        end loop;
        a_list := p.addresses;
        for j in 1..a_list.last loop
            dbms_output.put_line('  >>  '||a_list(j).city||'시 '||a_list(j).gu||'구 '||a_list(j).dong);
        end loop;
    end loop;
end;