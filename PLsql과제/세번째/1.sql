declare
    cursor me_csr is select * from movieexec where certno in (select producerno from movie) order by name;
    cursor st_csr(m movieexec.certno%type) is select * from studio where presno = m order by name desc; 
    cnt integer;
    type s_ty is table of studio%rowtype;
    mov s_ty;
    cnt2 integer;
begin
    for i in me_csr loop
    open st_csr(i.certno);
            fetch st_csr bulk collect into mov;
    close st_csr;
        cnt2 := 0;
        select count(*) into cnt from studio where i.certno = presno;
        if cnt = 0 then
            dbms_output.put_line('['||me_csr%rowcount||'] 제작자 '||i.name||'는 영화사를 운영하지 않는다.');
        elsif cnt = 1 then
            for j in mov.first..mov.last loop
                dbms_output.put_line('['||me_csr%rowcount||'] 제작자 '||i.name||'는 '||mov(j).name||'을 운영한다.');
            end loop;
        else 
            dbms_output.put('['||me_csr%rowcount||'] 제작자 '||i.name||'는 ');
            for j in mov.first..mov.last loop
                cnt2 := cnt2 + 1;
                if cnt2 < mov.last then
                    dbms_output.put(mov(j).name||', ');
                else 
                    dbms_output.put(mov(j).name);
                end if;
            end loop;
            dbms_output.put_line('을 운영한다');
        end if;    
    end loop;
end;