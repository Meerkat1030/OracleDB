declare
    type m_ty is table of varchar(100);/*nested table이라서 max크기를 안정해줘도 된다*/
    movs m_ty := m_ty('하나', '둘');/*초기화 필수*/
    
begin
    movs.extend(3);
    movs(3) := '셋';
    movs(4) := '넷';
    movs(5) := '다섯';/*declare부분에서 이미 1, 2는 차있다*/
    
    for i in movs.first..movs.last loop
        dbms_output.put_line(movs(i));
    end loop;
    --movs.delete(3);/*3번째 것만 삭제*/
    movs.trim(3);/*3번째 뒤의 모든것을 삭제*/
    dbms_output.put_line('===== count: '||movs.count||'last : '||movs.last);
    for i in movs.first..movs.last loop
        if movs.exists(i) then
            dbms_output.put_line(movs(i));
        else
            dbms_output.put_line(i||'th 데이터 없음 ..');
        end if;
    end loop;
    
end;