declare
    type a_ty is table of varchar(50);
    city a_ty := a_ty('부산', '울산', '서울', '대구', '대전', '포항');
    gu a_ty := a_ty('동', '서', '남', '북', '중', '해운대');
    dong a_ty := a_ty('대연', '문현', '용호', '민락', '대방', '대이');
    addr varchar(200);
begin
    for i in 1..100 loop
        addr := city(round(dbms_random.value(1, city.last))) ||'시 ';
        addr := addr || gu(round(dbms_random.value(1, gu.last))) || '구 ';
        addr := addr || dong(round(dbms_random.value(1, dong.last))) || '동';
        
        dbms_output.put_line(addr);
    end loop;
end;