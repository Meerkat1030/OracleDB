accept tt prompt '영화 제목은 ?';
accept yy prompt '개봉년도 ?';

declare
    len integer;
begin
    select length into len
    from movie
    where title = '&tt' and year = &yy; --&yy하면 년도를 입력가능하게함 accept에서 선언을 해주고 사용 입력 대상이 문자열이라면 ''넣어주기
    dbms_output.put_line('&tt'||'('||&&yy||'년도에 개봉) 상영시간: '||len||'분'); --system.out.println이랑 같은거
exception
    when OTHERS then --에러가 나면 일로온나
        DBMS_OUTPUT.PUT('검색 오류!!!');
end;