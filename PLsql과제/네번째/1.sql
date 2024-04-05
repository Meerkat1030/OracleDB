declare
    cursor csr is select studio.name sn, studio.address saddr, movieexec.name mn from studio, movieexec where presno = certno;
    cursor m_csr(sn studio.name%type) is select movie.title tt, movie.year yy, movieexec.name mn from movie, movieexec where producerno = certno and studioname = sn;
    cursor s_csr is select * from (select * from moviestar order by dbms_random.random) where rownum = trunc(dbms_random.value(1,12));
    ins_sql varchar(200) :=
        'insert into studioinfo values(:1,:2,:3,movie_tab(),star_tab())';/*movie랑 star뒤에 ()붙여주는거 잊지마*/
    star_sql varchar(200) :=
        'insert into table(select stars from studioinfo where name = :1) values(star_ty(:2,:3,:4))';
    movie_sql varchar(200) :=
        'insert into table(select movies from studioinfo where name = :1) values(movie_ty(:2,:3,:4,:5))';
    bud number(20);
    sal number(8);
    cont number(2);
begin
    for i in csr loop
        execute immediate ins_sql using i.sn, i.saddr, i.mn;
        for j in m_csr(i.sn) loop
            bud := trunc(dbms_random.value(10000,10000000000000000000));
            execute immediate movie_sql using i.sn, j.tt, j.yy, bud, j.mn;
        end loop;
        for k in s_csr loop
            sal := trunc(dbms_random.value(10000, 10000000));
            cont := trunc(dbms_random.value(1,11));
            execute immediate star_sql using i.sn, k.name, sal, cont;
        end loop;
    end loop;
end;