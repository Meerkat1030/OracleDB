declare
    type m_ty is record(
        tt movie.title%type,
        yy movie.year%type,
        addr studio.address%type,
        p_no studio.presno%type
    );/*반드시 괄호안에 넣어줘야한다 또한 ;가 아니라 ,로 계속 이어나가야함*/
      /*cusor의 select 순서랑 똑같이 넣어주기*/
    cursor csr is select title, year,address,presno from movie, studio
                    where studioname = name;/* select * 이형태는 cursor로 받기 힘들다*/
                                            /* 조인시킨 결과중 뭘들고올지 애매해서*/
    m movie%rowtype;
    rec m_ty;/*record 변수 생성*/
begin
    open csr;
    loop
        fetch csr into rec;
        exit when csr%notfound;/*데이터가 더이상 없다면 exit해라*/
        dbms_output.put_line(rec.tt||'('||rec.yy||'년 개봉)'||rec.addr);
    end loop;
    close csr;
end;