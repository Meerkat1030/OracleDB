declare
    type m_ty is varray(100) of movie%rowtype;/*크기 10짜리 배열생성*/
    movies m_ty := m_ty();/*이렇게 선언 안하면 오류남 존나중요 */
    cursor csr is select * from movie;
    m movie%rowtype;
begin
    open csr;
    loop
        fetch csr into m;
        exit when csr%notfound;
        movies.extend;/*매번 한공간만 추가하게*/
        movies(csr%rowcount) := m;/*rowcount는 현재 추출된 첨자 값 즉, i를 선언후 값을 하나씩올려준다거나 할 필요 없음*/
    end loop;
    close csr;
    
    for i in movies.first..movies.last loop/*처음거부터 마지막거까지 for*/
        dbms_output.put_line(movies(i).title||', '||movies(i).year);
    end loop;
end;